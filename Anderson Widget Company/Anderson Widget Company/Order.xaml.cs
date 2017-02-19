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
using Microsoft.Phone.Controls;

namespace Anderson_Widget_Company
{
    public partial class Order : PhoneApplicationPage
    {
        int orderNum;
        public Order()
        {
            InitializeComponent();   
            ServiceReference1.Service1Client client = new ServiceReference1.Service1Client();
            client.GetOrderCompleted +=  new EventHandler<ServiceReference1.GetOrderCompletedEventArgs>(getOrder);
            client.GetOrderAsync();
            
            
        }
        void getOrder(object sender, ServiceReference1.GetOrderCompletedEventArgs e)
        {

            String products = e.Result.ToString();
            //textBlock1.Text = products;
            if (products != "")
            {
                textBlock1.Text = "";
                int i = 0;
                int start = 0;
                int end = 1;
                int len = products.Length;
                while (end < products.LastIndexOf(";"))
                {
                    end = products.IndexOf(";", end);
                    string currRow = products.Substring(start + 1, end - start - 1);
                    listBox1.Items.Add(currRow);
                    start = end;
                    end = start + 1;
                }
                orderNum = int.Parse(products.Substring(end));
                PageTitle.Text += " # " + orderNum;
                //listBox1.Items.Add(products);
            }
            else
            {
                textBlock1.Text = "No Orders Found";
            }

        }
        

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
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
        //+ button
        private void button3_Click_1(object sender, RoutedEventArgs e)
        {
            if (listBox1.SelectedItems.Count == 1 && listBox1.SelectedIndex > 0)
            {
                int si = listBox1.SelectedIndex;
                string currRow = listBox1.SelectedItem.ToString();
                string quantity = currRow.Substring(currRow.LastIndexOf(' '));
                int newQuantity = int.Parse(quantity);
                newQuantity++;
                string newRow = currRow.Substring(0, currRow.LastIndexOf(' ')+1 ) + newQuantity.ToString();
                listBox1.Items[si] = newRow;
                listBox1.SelectedIndex = si;
                listBox1.UpdateLayout();
            }
        }
        //- button
        private void button4_Click(object sender, RoutedEventArgs e)
        {
            if (listBox1.SelectedItems.Count == 1 && listBox1.SelectedIndex > 0)
            {
                int si = listBox1.SelectedIndex;
                string currRow = listBox1.SelectedItem.ToString();
                string quantity = currRow.Substring(currRow.LastIndexOf(' '));
                int newQuantity = int.Parse(quantity);
                if(newQuantity > 0)
                    newQuantity--;
                string newRow = currRow.Substring(0, currRow.LastIndexOf(' ') + 1) + newQuantity.ToString();
                listBox1.Items[si] = newRow;
                listBox1.SelectedIndex = si;
                listBox1.UpdateLayout();
            }
        }
        //confirm pick
        private void button2_Click_1(object sender, RoutedEventArgs e)
        {
            
            ServiceReference1.Service1Client client = new ServiceReference1.Service1Client();
            client.confirmPickAsync(orderNum);
            NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));
        }
        //confirm quantity
        private void button1_Click_1(object sender, RoutedEventArgs e)
        {
            int si = listBox1.SelectedIndex;
            if (si > 0)
            {
                string currRow = listBox1.SelectedItem.ToString();
                string quantity = currRow.Substring(currRow.LastIndexOf(' '));
                int newQuantity = int.Parse(quantity);
                string strPid = currRow.Substring(0, 5);
                int PID = int.Parse(strPid);
                string Row = currRow.Substring(6, 5);
                string Box = currRow.Substring(12, 5);
                ServiceReference1.Service1Client client = new ServiceReference1.Service1Client();
                client.updateQuantityAsync(PID, Row, Box, newQuantity);
            }
            //NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));
        }
    }
}