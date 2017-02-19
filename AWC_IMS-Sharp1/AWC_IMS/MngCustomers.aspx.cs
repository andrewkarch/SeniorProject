using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace AWC_IMS
{
    public partial class MngCustomers : System.Web.UI.Page
    {
        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strBindQuery = "SELECT * FROM customer";
        const string VIEWFILTER = "";
        string strFilter = VIEWFILTER;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
            lblFormError.CssClass = "hidden";
            txtSearch.Focus();
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

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label lbldeleteID = (Label)GridView1.Rows[e.RowIndex].FindControl("lblId");
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.Connection = conn;
                cmd.CommandText = "Delete from customer where customer_id='" + lbldeleteID.Text + "'";
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.ToString();
            }
            BindData();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                conn = new MySqlConnection(connStr);
                Label lblId = (Label)GridView1.Rows[e.RowIndex].FindControl("lblId");
                txtName = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtName");
                txtUsername = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtUsername");
                txtDesc = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtDesc");
                txtAddress = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtAddress");
                txtCity = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCity");
                txtState = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtState");
                txtZip = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtZip");
                txtCountry = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCountry");
                cmd.Connection = conn;
                cmd.CommandText = "Update customer set name='" + txtName.Text + "',description='" + txtDesc.Text + "',billing_street_address='" + txtAddress.Text + "',billing_city='" + txtCity.Text + "',billing_zipcode='" + txtZip.Text + "',billing_country='" + txtCountry.Text + "',username='" + txtUsername.Text + "' where customer_id='" + lblId.Text + "'";
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

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindData();
        }

        protected void Add_Click1(object sender, EventArgs e)
        {
            if (!(txtName.Text.Equals("") && txtUsername.Text.Equals("") && txtAddress.Text.Equals("") && txtCity.Text.Equals("") && txtState.Text.Equals("") && txtZip.Text.Equals("")))
            {
                try
                {
                    conn = new MySqlConnection(connStr);
                    cmd.Connection = conn;
                    cmd.CommandText = "INSERT INTO customer SET name = '" + txtName.Text + "', description = '" + txtDesc.Text + "', billing_street_address = '" + txtAddress.Text + "', billing_city = '" + txtCity.Text + "', billing_state = '"+ txtState.Text +"', billing_zipcode = '" + txtZip.Text + "', billing_country = '" + txtCountry.Text + "', username = '" + txtUsername.Text + "'";
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

        protected void Update_Click1(object sender, EventArgs e)
        {

        }

        protected void Cancel_Click1(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim().Equals(""))
                strFilter = VIEWFILTER;
            else
                strFilter = "(name like '*" + txtSearch.Text.Trim() + "*') OR (username like '*" + txtSearch.Text.Trim() + "*')";
            BindData();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}