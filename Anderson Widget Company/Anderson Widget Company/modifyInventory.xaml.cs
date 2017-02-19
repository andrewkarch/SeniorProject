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
    public partial class modifyInventory : PhoneApplicationPage
    {
        public double num1 = 0;  
        
        public modifyInventory()
        {
            InitializeComponent();
        }
        
        private void button4_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/currentOrder.xaml", UriKind.Relative));
        }

        private void button3_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/currentOrder.xaml", UriKind.Relative));
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            num1 = double.Parse(GlobalVariables.itemQuantity);
            num1 = num1 + 1;
            GlobalVariables.itemQuantity = num1.ToString();
            textBox1.Text = GlobalVariables.itemQuantity;
            //modifiedInventory++;
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            num1 = double.Parse(GlobalVariables.itemQuantity);
            num1 = num1 - 1;
            GlobalVariables.itemQuantity = num1.ToString();
            textBox1.Text = GlobalVariables.itemQuantity;
            //modifiedInventory--;
        }

        private void textBox1_TextChanged(object sender, TextChangedEventArgs e)
        {
            GlobalVariables.itemQuantity = textBox1.Text;
        }

        private void PhoneApplicationPage_Loaded(object sender, RoutedEventArgs e)
        {
            textBox1.Text = GlobalVariables.itemQuantity;

        }

        private void textBox1_TextInputUpdate(object sender, TextCompositionEventArgs e)
        {

        }
    }
}