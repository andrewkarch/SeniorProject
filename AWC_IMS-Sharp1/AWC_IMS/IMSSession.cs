using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AWC_IMS.Classes
{
    public class IMSSession
    {
            // private constructor
            private IMSSession()
            {
                CustomerId = "";
                Username = "";
                AuthorizationLevel = "";
                isLoggedIn = false;
            }

            // Gets the current session.
            public static IMSSession Current
            {
                get
                {
                    IMSSession session =
                      (IMSSession)HttpContext.Current.Session["__IMSSession__"];
                    if (session == null)
                    {
                        session = new IMSSession();
                        HttpContext.Current.Session["__IMSSession__"] = session;
                    }
                    return session;
                }
            }

            // **** add your session properties here, e.g like this:

            // User information
            public string Username { get; set; }
            public string AuthorizationLevel { get; set; }
            public bool isLoggedIn { get; set; }
            public DateTime MyDate { get; set; }

            // Management pages
            public string CustomerId { get; set; }
            public string POID { get; set; }
    }
}