using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections.Specialized;

using AWC_IMS.Classes;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace AWC_IMS
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadCartFromCookieToDataTable();
                ViewState["SortExpression"] = "Item ASC";
                AddDataToGridView(); 
            }
            
        }
        
        //Populates a DataTable from the data in the cookie.
        private void LoadCartFromCookieToDataTable()
        {
            //Creates the dataTable (Cart) for data to be loaded in to.
            DataTable Cart = new DataTable();

            //Adds the columns to the DataTable
            Cart.Columns.Add("Item");
            Cart.Columns.Add("ItemName");
            Cart.Columns.Add("ItemID");
            Cart.Columns.Add("Quantity");
            Cart.Columns.Add("Price");

            //Makes the Column "Item" auto increment to count the items in the cart.
            Cart.Columns["Item"].AutoIncrement = true;
            Cart.Columns["Item"].AutoIncrementSeed = 1;
            Cart.Columns["Item"].AutoIncrementStep = 1;

            //Sets the ItemID as the primary Key for the DataTable
            DataColumn[] Primary = new DataColumn[1];
            Primary[0] = Cart.Columns["Item"];
            Cart.PrimaryKey = Primary;

            //Loads the cookie created by the Catalog
            HttpCookie cookie = Request.Cookies.Get("cartCookie");
            
            double total = 0;
            //Loads the Cart with data from cookie
            if (cookie != null)
            {
                NameValueCollection MyCookieValues = new NameValueCollection(cookie.Values);
                foreach (string s in cookie.Values)
                //String[] MyKeyNames = MyCookieValues.AllKeys;
                //foreach (string KeyName in MyKeyNames)
                //for(int i = 0; i < cookie.Values.Count; i++)
                {
                    //string myValue = Request.Cookies.Get("cartCookie").Values[""+i];
                    string myValue = cookie.Values[s];
                    string itemName, itemID, quantity, price;
                    if (myValue != "" && myValue != null)
                    {
                        itemName = myValue.Substring(myValue.IndexOf('!') + 1, (myValue.IndexOf('@') - myValue.IndexOf('!') - 1));
                        itemID = myValue.Substring(0, myValue.IndexOf('!'));
                        quantity = myValue.Substring(myValue.IndexOf('$') + 1);
                        price = myValue.Substring(myValue.IndexOf('@') + 1, (myValue.IndexOf('#') - myValue.IndexOf('@') - 1));
                        total += Convert.ToDouble(price) * Convert.ToInt32(quantity);
                        Cart.Rows.Add(null, itemName, itemID, quantity, price);
                    }
                }
            }
            else
            {
                Cart.Rows.Add(null, "Cart Empty", "", "", "");

            } 
            TotalLabel.Text = total.ToString();
            ViewState["Cart"] = Cart;
        }

        private void AddDataToGridView()
        {
                DataTable Cart = (DataTable)ViewState["Cart"];
                DataView CartDataView = new DataView(Cart);
                CartDataView.Sort = ViewState["SortExpression"].ToString();
                CartGridView.DataSource = Cart;
                CartGridView.DataBind();
        }
                
        protected void GridView_RowDeleted(object sender, GridViewDeleteEventArgs e)
        {
            HttpCookie cookie = Request.Cookies.Get("cartCookie");
            GridViewRow currRow = CartGridView.Rows[e.RowIndex];
            String pid = "" + currRow.Cells[2].Text;
            cookie.Values.Remove(pid);
            Response.Cookies.Add(cookie);
            LoadCartFromCookieToDataTable();
            ViewState["SortExpression"] = "Item ASC";
            AddDataToGridView();
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
            MySqlConnection conn = new MySqlConnection(connStr);;
            MySqlCommand cmd = new MySqlCommand();
            cmd.Connection = conn;
            conn.Open();
            int custid = Int32.Parse(IMSSession.Current.CustomerId);
            //Add order to table
            cmd.CommandText = "INSERT INTO purchase_order (customer_id, date_placed, csa_id) VALUES (" + custid + ", CURDATE(), (SELECT csa_id FROM customer_shipping_address WHERE customer_id = '" + custid + "' LIMIT 1))";
            try
            {
                int rc = cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }

            //Get purchase order id
            int po_id = 0;
            cmd.CommandText = "SELECT po_id FROM purchase_order WHERE customer_id = '" + custid + "' AND date_placed = CURDATE() AND date_filled is null LIMIT 1";
            try
            {
                int rc = cmd.ExecuteNonQuery();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd); ;
                DataSet ds = new DataSet();
                da.Fill(ds);
                DataTableReader tr = ds.CreateDataReader();
                while (tr.Read())
                {
                    po_id = tr.GetInt32(0);
                }
            }
            catch (Exception)
            {
                throw;
            }

            //Add items to purchase_order_product table
            
            try
            {
                foreach (GridViewRow r in CartGridView.Rows)
                {
                    int pid = Convert.ToInt32(r.Cells[2].Text);
                    int quantity = Convert.ToInt32(r.Cells[3].Text);
                    cmd.CommandText = "INSERT INTO purchase_order_product (po_id, product_id, quantity) VALUES (" + po_id + ", " + pid +", " + quantity + ")";
                    int rc = cmd.ExecuteNonQuery();
                }

            }
            catch (Exception)
            {
                throw;
            }

            //Update Inventory
            foreach( GridViewRow r in CartGridView.Rows){
                int pid = Convert.ToInt32(r.Cells[2].Text);
                int quantity = Convert.ToInt32(r.Cells[3].Text);
                int invID = 0;
                //get inventory id
                cmd.CommandText = "SELECT inventory_id from inventory where product_id = '" + pid + "' LIMIT 1";
                try
                {
                    cmd.ExecuteNonQuery();
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd); ;
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    DataTableReader tr = ds.CreateDataReader();
                    while (tr.Read())
                    {
                        invID = tr.GetInt32(0);
                    }
                }
                catch (Exception)
                {
                    throw;
                }
                //update quantity
                cmd.CommandText = "UPDATE inventory SET quantity = quantity - " + quantity + " WHERE inventory_id = '" + invID + "'";
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {

                    throw;
                }
            }

            Response.Redirect("~/OrderConfirm.aspx"); 

        }

    }
}