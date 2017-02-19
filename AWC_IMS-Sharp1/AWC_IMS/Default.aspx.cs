using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWC_IMS
{
    public partial class _Default : System.Web.UI.Page
    {
        string connection = "Data Source = mysql10.000webhost.com; Initial Catalog = a6386384_awcims; User Id = a6386384_roo; Password = cs483proj;";
        string qry;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataSource sds = new SqlDataSource();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
