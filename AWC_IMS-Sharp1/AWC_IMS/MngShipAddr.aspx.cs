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
using AWC_IMS.Classes;

namespace AWC_IMS
{
    public partial class MngShipAddr : System.Web.UI.Page
    {
        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strOrderBy = "";
        string strBindQuery = "SELECT * FROM customer_shipping_address";
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
                    if (!IMSSession.Current.CustomerId.Equals(""))
                    {
                        strBindQuery = "SELECT * FROM customer_shipping_address WHERE customer_id=" + IMSSession.Current.CustomerId;
                    }
                    else
                    {
                        Response.Redirect("~/MngCustomers.aspx");
                    }

                    if (!Page.IsPostBack)
                    {
                        BindData();
                    }
                    lblFormError.CssClass = "hidden";
                }
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
            

        public void BindData()
        {
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.CommandText = strBindQuery + strOrderBy;
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
            var csaId = GridView1.DataKeys[e.RowIndex].Value;
            conn = new MySqlConnection(connStr);
            cmd.Connection = conn;
            cmd.CommandText = "Delete from customer_shipping_address where csa_id = @CsaId";
            cmd.Parameters.AddWithValue("@CsaId", csaId);
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
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
                var csaId = GridView1.DataKeys[e.RowIndex].Value;
                string strAddress = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtAddress")).Text;
                string strCity = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCity")).Text;
                string strState = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtState")).Text;
                string strZip = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtZip")).Text;
                string strCountry = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCountry")).Text;
                cmd.Connection = conn;
                cmd.CommandText = "Update customer_shipping_address set shipping_street_address=@Address,shipping_city=@City,shipping_state=@State,shipping_zipcode=@Zip,shipping_country=@Country where csa_id=@CsaId";
                cmd.Parameters.AddWithValue("@Address", strAddress);
                cmd.Parameters.AddWithValue("@City", strCity);
                cmd.Parameters.AddWithValue("@State", strState);
                cmd.Parameters.AddWithValue("@Zip", strZip);
                cmd.Parameters.AddWithValue("@Country", strCountry);
                cmd.Parameters.AddWithValue("@CsaId", csaId.ToString());
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
            if (!(txtNewAddress.Text.Equals("") && txtNewCity.Text.Equals("") && txtNewState.Text.Equals("") && txtNewZip.Text.Equals("")))
            {
                try
                {
                    conn = new MySqlConnection(connStr);
                    cmd.Connection = conn;
                    cmd.CommandText = "INSERT INTO customer_shipping_address SET customer_id=@CustId, shipping_street_address=@Address,shipping_city=@City,shipping_state=@State,shipping_zipcode=@Zip,shipping_country=@Country";
                    cmd.Parameters.AddWithValue("@CustId", IMSSession.Current.CustomerId);
                    cmd.Parameters.AddWithValue("@Address", txtNewAddress.Text);
                    cmd.Parameters.AddWithValue("@City", txtNewCity.Text);
                    cmd.Parameters.AddWithValue("@State", txtNewState.Text);
                    cmd.Parameters.AddWithValue("@Zip", txtNewZip.Text);
                    cmd.Parameters.AddWithValue("@Country", txtNewCountry.Text);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    txtNewAddress.Text = "";
                    txtNewCity.Text = "";
                    txtNewState.Text = "";
                    txtNewZip.Text = "";
                    txtNewCountry.Text = "";
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


        protected void Clear_Click1(object sender, EventArgs e)
        {
            txtNewAddress.Text = "";
            txtNewCity.Text = "";
            txtNewState.Text = "";
            txtNewZip.Text = "";
            txtNewCountry.Text = "";
        }
    }
}