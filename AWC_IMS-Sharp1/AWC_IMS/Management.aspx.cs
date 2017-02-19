using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AWC_IMS.Classes;

namespace AWC_IMS
{
    public partial class Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string auth = IMSSession.Current.AuthorizationLevel;
            if (auth == "13"){

            }
            else
            {
            }
        }
    }
}
