using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using AWC_IMS.Classes;

using MySql.Data;
using MySql.Data.MySqlClient;
using System.Diagnostics;

namespace AWC_IMS.Account
{
    public partial class Login : System.Web.UI.Page
    {

        string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        string strBindQuery = "SELECT * FROM account";
        HttpCookie authCookie = new HttpCookie("auth");
       

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            /*
             if(usernametxt.text==dataset.accounts.username && passwordtxt.text==dataset.accounts.password)
             *  get authBit
             else
             *  send back error message
             *  
             redirect to main page after successful login
             reload login page, for failed login
             
             
             */
            string strUser = UsernameTxt.Text;
            string strPass = PasswordTxt.Text;

            //strBindQuery = "SELECT a.authorization_id, c.customer_id FROM account a, customer c WHERE a.username='" + strUser + "' AND a.password='" + strPass + "' AND a.username = c.username";
            strBindQuery = "SELECT a.authorization_id FROM account a WHERE a.username='" + strUser + "' AND a.password='" + strPass + "'";
            try
            {
                conn = new MySqlConnection(connStr);
                cmd.CommandText = strBindQuery;
                cmd.Connection = conn;
                daCustomer = new MySqlDataAdapter(cmd);
                daCustomer.Fill(dsCustomer);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
            }

            if (dsCustomer.Tables[0].Rows.Count > 0)
            {
                authCookie.Value = "1";
                authCookie.Expires = DateTime.Now.AddHours(1);
                Response.Cookies.Add(authCookie);
                String authLevel = (dsCustomer.Tables[0].Rows[0])["authorization_id"].ToString();

                IMSSession.Current.AuthorizationLevel = authLevel;
                IMSSession.Current.Username = strUser;
                IMSSession.Current.isLoggedIn = true;
                if (authLevel == "13")
                {
                    try
                    {
                        cmd.CommandText = "SELECT customer_id FROM customer WHERE username='" + strUser + "'";
                        cmd.ExecuteNonQuery();
                        dsCustomer = new DataSet();
                        daCustomer = new MySqlDataAdapter(cmd);
                        daCustomer.Fill(dsCustomer);
                        IMSSession.Current.CustomerId = (dsCustomer.Tables[0].Rows[0])[0].ToString();
                    }
                    catch (Exception)
                    {
                        
                        throw;
                    }
                        Response.Redirect("Catalog.aspx");
                }
                else if(authLevel == "11"){
                    Response.Redirect("Management.aspx");
                }
                //TextBox1.Text = "1 " + authLevel;
                // username found
                /* foreach (DataRow row in dsCustomer.Tables[0].Rows)
                 {
                     if (row.ItemArray[1].ToString().Equals(strPass))
                     {
                         // password matches
                     }
                     else
                     {
                         // password does not match
                     }
                 }*/
            }
            else
            {
                //TextBox1.Text = "0";
                // username not found
            }

        }

       
    }

   
}
