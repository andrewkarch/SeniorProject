using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MySql.Data.MySqlClient;

using AWC_IMS.Classes;

namespace AWC_IMS
{
    public partial class MngEmployees : System.Web.UI.Page
    {
        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strBindQuery = "SELECT e.employee_id, e.first_name, e.last_name, e.username, e.position_id, d.name, e.active " +
            "FROM employee e, position p, department d " +
            "WHERE p.department_id = d.department_id " +
            "AND p.position_id = e.position_id " +
            "ORDER BY e.last_name, e.first_name";
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
            if (!(txtNewFirstName.Text.Equals("") && txtNewLastName.Text.Equals("") && txtNewUsername.Text.Equals("") && txtNewPositionId.Text.Equals("") && txtNewActive.Text.Equals("")))
            {
                try
                {
                    conn = new MySqlConnection(connStr);
                    cmd.Connection = conn;
                    cmd.CommandText = string.Format("INSERT INTO employee (first_name, last_name, username, position_id, active) VALUES ('{0}', '{1}', '{2}', {3}, {4});", txtNewFirstName.Text, txtNewLastName.Text, txtNewUsername.Text, txtNewPositionId.Text, txtNewActive.Text);
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    GridView1.EditIndex = -1;
                    BindData();
                    conn.Close();
                    txtNewFirstName.Text = "";
                    txtNewLastName.Text = "";
                    txtNewUsername.Text = "";
                    txtNewPositionId.Text = "";
                    txtNewActive.Text = "";
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
            txtNewFirstName.Text = "";
            txtNewLastName.Text = "";
            txtNewUsername.Text = "";
            txtNewPositionId.Text = "";
            txtNewActive.Text = "";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim().Equals(""))
                strFilter = VIEWFILTER;
            else
                strFilter = "(last_name like '*" + txtSearch.Text.Trim() + "*') OR (username like '*" + txtSearch.Text.Trim() + "*')";
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
            int id = int.Parse(GridView1.DataKeys[e.RowIndex]["employee_id"].ToString());
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.Connection = conn;
                cmd.CommandText = "DELETE FROM employee WHERE employee_id=@employee_id";
                cmd.Parameters.AddWithValue("@employee_id", id);
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
            int id = int.Parse(GridView1.DataKeys[e.RowIndex]["employee_id"].ToString());
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.Connection = conn;
                cmd.CommandText = "Update employee set first_name = @first_name,last_name=@last_name, username= @username, active= @active" + " where employee_id = @employee_id";
                cmd.Parameters.AddWithValue(
                    "@first_name", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtFirstName")).Text);
                cmd.Parameters.AddWithValue(
                    "@last_name", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtLastName")).Text);
                cmd.Parameters.AddWithValue(
                    "@username", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtUsername")).Text);
                cmd.Parameters.AddWithValue(
                    "@active", ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtActive")).Text);
                cmd.Parameters.AddWithValue("@employee_id", id);
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