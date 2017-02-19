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

namespace WcfService1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    public class DBServiceClient : DBService
    {
        public int GetAuth(String strUser)
        {

        String connStr = "server=uberstu.dyndns-ip.com;User Id=cs483db;Password = CS483proj;Persist Security Info=True;database=awcimsdb";
        MySqlConnection conn;
        MySqlCommand cmd = new MySqlCommand();
        MySqlDataAdapter daCustomer;
        DataSet dsCustomer = new DataSet();
        String strBindQuery = "SELECT * FROM account WHERE username='"+strUser+"'";

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

        //public CompositeType GetDataUsingDataContract(CompositeType composite)
        //{
        //    if (composite == null)
        //    {
        //        throw new ArgumentNullException("composite");
        //    }
        //    if (composite.BoolValue)
        //    {
        //        composite.StringValue += "Suffix";
        //    }
        //    return composite;
        //}
    }
}
