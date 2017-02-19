using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AWC_IMS.Classes;
namespace AWC_IMS
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Boolean log = IMSSession.Current.isLoggedIn;
            string auth = IMSSession.Current.AuthorizationLevel;
                if (log == true)
                {
                    loginLink.Text = "Log Out";
                    if (auth == "13")
                    {
                        NavigationMenu.Items.Clear();
                        NavigationMenu.Items.AddAt(0, new MenuItem("Home", "~/Default.aspx"));
                        NavigationMenu.Items.AddAt(1, new MenuItem("Contact", "~/Contact.aspx"));
                        NavigationMenu.Items.AddAt(2, new MenuItem("About", "~/About.aspx"));
                        NavigationMenu.Items.AddAt(3, new MenuItem("Catalog", "~/Catalog.aspx"));
                    }
                    else
                    {
                            NavigationMenu.Items.Clear();
                            NavigationMenu.Items.AddAt(0, new MenuItem("Home", "~/Default.aspx"));
                            NavigationMenu.Items.AddAt(1, new MenuItem("Contact", "~/Contact.aspx"));
                            NavigationMenu.Items.AddAt(2, new MenuItem("About", "~/About.aspx"));
                            NavigationMenu.Items.AddAt(3, new MenuItem("Management", "~/Management.aspx"));
                      
                    }
                }
                else
                {
                    loginLink.Text = "Log In";
                    NavigationMenu.Items.Clear();
                    NavigationMenu.Items.AddAt(0, new MenuItem("Home", "~/Default.aspx"));
                    NavigationMenu.Items.AddAt(1, new MenuItem("Contact", "~/Contact.aspx"));
                    NavigationMenu.Items.AddAt(2, new MenuItem("About", "~/About.aspx"));
                }

            }
        protected void loginLink_Click(object sender, EventArgs e)
        {
            if (loginLink.Text.Equals("Log In"))
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                loginLink.Text = "Log In";
                IMSSession.Current.isLoggedIn = false;
                IMSSession.Current.AuthorizationLevel = "";
                IMSSession.Current.Username = "";
                Response.Redirect("/");
            }
        }

       
    }
}
