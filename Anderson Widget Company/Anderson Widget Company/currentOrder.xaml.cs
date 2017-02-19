using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Data;
using Microsoft.Phone.Controls;

using System.Diagnostics;

namespace Anderson_Widget_Company
{
    public partial class currentOrder : PhoneApplicationPage
    {
        //public static string itemQuString = "10";
        public currentOrder()
        {
            InitializeComponent();
            ServiceReference1.Service1Client client = new ServiceReference1.Service1Client();
            client.GetOrderCompleted +=  new EventHandler<ServiceReference1.GetOrderCompletedEventArgs>(getOrder);
            client.GetOrderAsync();
            
            
        }
        void getOrder(object sender, ServiceReference1.GetOrderCompletedEventArgs e){

            String products = e.Result.ToString();
            ApplicationTitle.Text = products;
            //listBox1.Items.Add(products);
        }
        

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            //String sql = "SELECT quantity
            //FROM inventory
            //WHERE prodct_id = " + GlobalVariables.productID
            //GlobalVariables.itemQuantity = RESULT OF ABOVE QUERY
            NavigationService.Navigate(new Uri("/modifyInventory.xaml", UriKind.Relative));
        }

        private void button3_Click(object sender, RoutedEventArgs e)
        {

            NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));
        }

        private void listBox1_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void PhoneApplicationPage_Loaded(object sender, RoutedEventArgs e)
        {

        }
    }
}