using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace Anderson_Widget_Company
{
    public class GlobalVariables
    {
        public static string employeeID = "";   //stores the employee ID of user logged into handheld
        public static string orderID = "";      //stores order ID retrieved from server
        public static string itemQuantity = ""; //stores item quantity during inventory modification
        public static string productID = "";    //stores productID for inventory modification

    }
}
