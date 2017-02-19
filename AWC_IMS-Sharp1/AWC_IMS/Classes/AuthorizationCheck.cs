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

namespace AWC_IMS.Classes
{

    
    public static class AuthorizationCheck
    {
        //string[,] authTable = new string[5,9] {{"11", "Cart.aspx"}, {}, {}, {}, {}, {}, {}, {}, {}};


        public static string AuthCheck(string AuthorID, string[] authRoles)
        {
            string connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
            string strBindQuery = "SELECT * FROM authorization_level";
            MySqlConnection conn = new MySqlConnection(connStr);
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandText = strBindQuery;
            cmd.Connection = conn;
            DataSet dsCustomer = new DataSet();
            MySqlDataAdapter daCustomer = new MySqlDataAdapter(cmd);
            daCustomer.Fill(dsCustomer);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            foreach(DataRow row in dsCustomer.Tables[0].Rows) 
            {
                if (AuthorID == row.ItemArray[0].ToString())
                    return (string)row.ItemArray[1];
            }

            return "none";

        }

        //auth check method(authID)
        //query authlevel
        //compare to dataset

    }

   
        
}
