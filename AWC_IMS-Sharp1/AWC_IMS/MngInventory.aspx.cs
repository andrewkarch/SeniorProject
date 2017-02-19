using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MySql.Data.MySqlClient;

using AWC_IMS.Classes;

namespace AWC_IMS
{
    public partial class MngInventory : System.Web.UI.Page
    {
        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strBindQuery = "SELECT p.product_id, p.name, p.description, p.active, p.price, i.quantity, i.row, i.box, i.inventory_id " +
                    "FROM inventory i, product p " +
                    "WHERE i.product_id = p.product_id " +
                    "ORDER BY p.product_id;";
        const string VIEWFILTER = "";
        string strFilter = VIEWFILTER;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IMSSession.Current.isLoggedIn == true)
            {
                if (AuthorizationCheck.AuthCheck(IMSSession.Current.AuthorizationLevel, new string[] { "Admin", "Maintainence" }).Equals("none"))
                    Response.Redirect("~/Default.aspx");
                else
                {
                    if (!Page.IsPostBack)
                    {
                        BindData();
                    }
                    lblFormError.CssClass = "hidden";
                    txtSearch.Focus();
                }
            }
            else
                Response.Redirect("~/Default.aspx");
        }

        public void BindData()
        {
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
                lblError.Text = ex.ToString();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void Add_Click1(object sender, EventArgs e)
        {
            lblError.Text = "";
            if (!(txtNewProductId.Text.Equals("") && txtNewQuantity.Text.Equals("") && txtNewRow.Text.Equals("") && txtNewBox.Text.Equals("")))
            {
                try
                {
                    conn = new MySqlConnection(connStr);
                    cmd.Connection = conn;
                    cmd.CommandText = string.Format("INSERT INTO inventory (product_id, quantity, row, box) VALUES ('{0}', {1}, {2}, '{3}'); ", txtNewProductId.Text, txtNewQuantity.Text, txtNewRow.Text, txtNewBox.Text);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    GridView1.EditIndex = -1;
                    BindData();
                    conn.Close();
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.ToString();
                }
            }
            else
            {
                lblFormError.CssClass = "error";
                lblFormError.Text = "Please enter all required fields...";
            }
        }

        protected void Cancel_Click1(object sender, EventArgs e)
        {
            lblError.Text = "";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            lblError.Text = "";
            if (txtSearch.Text.Trim().Equals(""))
                strFilter = VIEWFILTER;
            else
                strFilter = "(name like '*" + txtSearch.Text.Trim().ToString() + "*') OR (description like '*" + txtSearch.Text.Trim().ToString() + "*')";
            BindData();
        }

        protected void EditRow(object sender, GridViewEditEventArgs e)
        {
            lblError.Text = "";
            GridView1.EditIndex = e.NewEditIndex;
            this.BindData();
        }

        protected void CancelEditRow(object sender, GridViewCancelEditEventArgs e)
        {
            lblError.Text = "";
            GridView1.EditIndex = -1;
            this.BindData();
        }

        protected void DeleteRow(object sender, GridViewDeleteEventArgs e)
        {
            lblError.Text = "";
            int id = int.Parse(GridView1.DataKeys[e.RowIndex]["inventory_id"].ToString());
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.Connection = conn;
                cmd.CommandText = "DELETE FROM inventory WHERE inventory_id=@inventory_id";
                cmd.Parameters.AddWithValue("@inventory_id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.ToString();
            }
            
            lblError.Text =
            "Record has been deleted successfully !";
            lblError.ForeColor = System.Drawing.
            Color.Red;
            BindData();
        }

        protected void ChangePage(object sender, GridViewPageEventArgs e)
        {
            lblError.Text = "";
            GridView1.PageIndex = e.NewPageIndex;
            this.BindData();
        }

        protected void UpdateRow(object sendedr, GridViewUpdateEventArgs e)
        {
            lblError.Text = "";
            int id = int.Parse(GridView1.DataKeys[e.RowIndex]["inventory_id"].ToString());
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.Connection = conn;
                cmd.CommandText = "Update inventory set product_id = @product_id,quantity=@quantity, row= @row, box = @box" + " where inventory_id = @inventory_id";
                cmd.Parameters.AddWithValue(
                    "@product_id", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtProductId")).Text);
                cmd.Parameters.AddWithValue(
                    "@quantity", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtQuantity")).Text);
                cmd.Parameters.AddWithValue(
                    "@row", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtRow")).Text);
                cmd.Parameters.AddWithValue(
                    "@box", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtBox")).Text);
                cmd.Parameters.AddWithValue("@inventory_id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.ToString();
            }

            lblError.Text =
            "Record has been updated successfully !";
            lblError.ForeColor = System.Drawing.
            Color.Red;
            GridView1.EditIndex = -1;
            BindData();
        }
    }
}