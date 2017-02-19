using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using MySql.Data.MySqlClient;
using System.Diagnostics;
using System.Data;

namespace WcfService2
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    public class Service1 : IService1
    {
        public int GetLogin(string value)
        {
            String connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        String strBindQuery = "SELECT * FROM account WHERE username='" + value + "' AND authorization_id='14'";

        try
        {
            conn = new MySqlConnection(connStr);
            cmd.CommandText = strBindQuery;
            cmd.Connection = conn;
            daCustomer = new MySqlDataAdapter(cmd);
            daCustomer.Fill(dsCustomer);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Console.WriteLine(daCustomer);
        }
        catch (Exception ex)
        {
            // lblError.Text = ex.ToString();
        }

        if (dsCustomer.Tables[0].Rows.Count > 0)
            return 1;
        else
            return 0;
        }
        public String GetOrder()
        {
            String connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
            MySqlConnection conn;
            MySqlCommand cmd = new MySqlCommand();
            MySqlDataAdapter daCustomer;
            DataSet dsCustomer = new DataSet();

            conn = new MySqlConnection(connStr);
            cmd.Connection = conn;
            //get products ordered
            try
            {
                conn.Open();
                cmd.CommandText = "SELECT i.product_ID, i.row, p.quantity, i.box, p.po_id, i.quantity " +
                "FROM inventory i, purchase_order_product p " +
                "WHERE i.product_ID = p.product_ID " +
                "AND p.po_id = (SELECT po_id FROM purchase_order WHERE date_filled is null  LIMIT 1)"; 
                daCustomer = new MySqlDataAdapter(cmd);
                daCustomer.Fill(dsCustomer);
                cmd.ExecuteNonQuery();
                conn.Close();
                if (dsCustomer.Tables[0].Rows.Count > 0)
                {
                    String returnString = String.Format("{0,4} {1,4} {2,4} {3,4} {4,4};", "PID", "Row", "Box", "Qnty", "Stock");
                    DataTableReader tr = dsCustomer.CreateDataReader();
                    while (tr.Read())
                    {
                        returnString += String.Format("{0,4} {1,4} {2,4} {3,4} {4,4};",
                            tr.GetInt32(0).ToString(), tr.GetString(1).ToString(), tr.GetString(3).ToString(), tr.GetInt32(2).ToString(), tr.GetInt32(5).ToString());
                    }
                    tr.Close();
                    tr = dsCustomer.CreateDataReader();
                    tr.Read();
                    returnString += tr.GetInt32(4);
                    tr.Close();
                    return returnString;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
            }
            return "";
            
        }

        public void confirmPick(int orderNum)
        {
            String connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
            MySqlConnection conn;
            MySqlCommand cmd = new MySqlCommand();
            MySqlDataAdapter daCustomer;
            DataSet dsCustomer = new DataSet();
            String strBindQuery = "UPDATE purchase_order SET date_filled = CURDATE() WHERE po_id = '" + orderNum + "'";

            try
            {
                conn = new MySqlConnection(connStr);
                cmd.CommandText = strBindQuery;
                cmd.Connection = conn;
                daCustomer = new MySqlDataAdapter(cmd);
                daCustomer.Fill(dsCustomer);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Console.WriteLine(daCustomer);
            }
            catch (Exception ex)
            {
            }
        }

        public void updateQuantity(int pid, string row, string box, int quantity)
        {
            String connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
            MySqlConnection conn;
            MySqlCommand cmd = new MySqlCommand();
            MySqlDataAdapter daCustomer;
            DataSet dsCustomer = new DataSet();
            String strBindQuery = "UPDATE inventory SET quantity = '"+ quantity +"' WHERE product_id = '" + pid + "'";

            try
            {
                conn = new MySqlConnection(connStr);
                cmd.CommandText = strBindQuery;
                cmd.Connection = conn;
                daCustomer = new MySqlDataAdapter(cmd);
                daCustomer.Fill(dsCustomer);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Console.WriteLine(daCustomer);
            }
            catch (Exception ex)
            {
            }
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }
}
