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
    public partial class MngOrders : System.Web.UI.Page
    {
        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strOrderBy = "";
        string strBindQuery = "SELECT pop.pop_id, pop.po_id, pr.name, pop.quantity, po.date_placed, po.date_filled, po.employee_id, po.csa_id " +
            "FROM purchase_order_product pop, purchase_order po, product pr " +
            "WHERE pop.po_id = po.po_id " +
            "AND pop.product_id = pr.product_id " +
            "ORDER BY pop.po_id";
        const string VIEWFILTER = "";
        string strFilter = VIEWFILTER;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
            txtSearch.Focus();
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
            var popId = GridView1.DataKeys[e.RowIndex].Value;
            conn = new MySqlConnection(connStr);
            cmd.Connection = conn;
            cmd.CommandText = "Delete from purchase_order_product where pop_id = @pop_id";
            cmd.Parameters.AddWithValue("@pop_id", popId);
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
                string strPopId = ((Label)GridView1.Rows[e.RowIndex].FindControl("lblPopId")).Text;
                string strPoId = ((Label)GridView1.Rows[e.RowIndex].FindControl("lblPopId")).Text;
                //string strPopId = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPopId")).Text;
                //string strPoId = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPoId")).Text;
                //string strName = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtName")).Text;
                string strQuantity = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtQuantity")).Text;
                //string strDatePlaced = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtDatePlaced")).Text;
                //string strDateFilled = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtDateFilled")).Text;
                //string strEmployeeId = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEmployeeId")).Text;
                string strAddress = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtAddress")).Text;
                cmd.Connection = conn;
                //cmd.CommandText = "Update pop_id set name='" + strName + "',po_id='" + strAddress + "',product_id='" + strCity + "',quantity='" + strZip + "',billing_country='" + strCountry + "',username='" + strUsername + "' where customer_id=" + customerId.ToString();
                cmd.CommandText = "Update purchase_order_product set quantity='" + strQuantity + "' where pop_id=" + strPopId;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.CommandText = "Update purchase_order set csa_id='" + strAddress + "' where po_id=" + strPoId;
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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim().Equals(""))
                strFilter = VIEWFILTER;
            else
                strFilter = "(name like '*" + txtSearch.Text.Trim() + "*') OR (username like '*" + txtSearch.Text.Trim() + "*')";
            BindData();
        }
    }
}