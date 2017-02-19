using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Diagnostics;
using MySql.Data;
using MySql.Data.MySqlClient;
namespace AWC_IMS
{
    public partial class Catalog : System.Web.UI.Page
    {

        HttpCookie cartCookie = new HttpCookie("cartCookie");
        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strBindQuery = "SELECT p.product_id, p.name, p.description, p.price, SUM(i.quantity) as qsum " +
           "FROM inventory i, product p " +
           "WHERE i.product_id = p.product_id " + 
           "GROUP BY p.product_id";
        const string VIEWFILTER = "";
        string strFilter = VIEWFILTER;
        protected void Page_PreRender(object o, System.EventArgs e)
        {

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //AsyncPostBackTrigger trig = new AsyncPostBackTrigger();
            //trig.ControlID = GridView1.UniqueID;
            //trig.EventName = "RowCommand";
            //UpdatePanel1.Triggers.Add(trig); 
            if (!Page.IsPostBack)
            {

                BindData();
                //Label1.Text = "";
                //txtSearch.Focus();
            }
            //lblFormError.CssClass = "hidden";
            //
        }
        public void BindData()
        {
            DataSet ds = new DataSet();
            DataTableReader tr;
           
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.CommandText = strBindQuery;
                cmd.Connection = conn;
                daCustomer = new MySqlDataAdapter(cmd);
                daCustomer.Fill(dsCustomer);
                conn.Open();
                cmd.ExecuteNonQuery();
                
                if (!strFilter.Equals("*"))
                {
                    DataView view = new DataView();
                    view.Table = dsCustomer.Tables[0];
                    view.RowFilter = strFilter;
                    GridView1.DataSource = view;
                }
                else
                {
                    GridView1.DataSource = dsCustomer;
                }
                GridView1.DataBind();
                GridView1.UseAccessibleHeader = true;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                conn.Close();
            }
            catch (Exception ex)
            {
                //txtSearch.Text = ex.ToString();
            }
        }
        protected void OrderGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            Button lb = e.Row.FindControl("btnAdd0") as Button;
            ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb);  
        }  
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim().Equals(""))
                strFilter = VIEWFILTER;
            else
                strFilter = "(Convert(product_id, 'System.String') like '*" + txtSearch.Text.Trim() + "*') OR (name like '*" + txtSearch.Text.Trim() + "*') OR (description like '*" + txtSearch.Text.Trim() + "*')";
            
            BindData();
        }
        //
        protected void Button1_Click(object sender, EventArgs e)
        {
             foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {                   
                    TextBox textBox = row.FindControl("txtQuantity") as TextBox;
                    string idStr = row.Cells[0].Text;
                    string name = row.Cells[1].Text;
                    string priceStr = row.Cells[3].Text;
                    string stockStr = row.Cells[4].Text;
                    string quantityStr = textBox.Text;
                    int id, stock, quantity;
                    double price;

                    if (textBox.Text != "")
                    {
                        if (Int32.TryParse(quantityStr, out quantity) &&
                           Int32.TryParse(idStr, out id) && Int32.TryParse(stockStr, out stock) &&
                           Double.TryParse(priceStr, out price))
                        {
                            if (quantity <= stock)
                            {
                                cartCookie.Values.Add("" + idStr, idStr + "!" + name + "@" +
                                priceStr + "#" + stockStr + "$" + quantityStr);
                                textBox.Text = "Added to cart.";
                            }
                            else
                            {
                                textBox.Text = "Not enough in stock.";
                            }
                        }
                        else
                        {
                            textBox.Text = "Invalid amount.";
                        }
                    }
                 }
              }
             Response.Cookies.Add(cartCookie);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
          Response.Redirect("Cart.aspx");
        }

            
     
    }
}