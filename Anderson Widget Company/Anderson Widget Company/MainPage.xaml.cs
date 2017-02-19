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
    public partial class MainPage : PhoneApplicationPage
    {
        String authBit; 
       
        public MainPage()
        {
            InitializeComponent();
            
        }
        private void button1_Click(object sender, RoutedEventArgs e)
        {
            //NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));

            ServiceReference1.Service1Client client = new ServiceReference1.Service1Client();
            client.GetLoginCompleted += new EventHandler<ServiceReference1.GetLoginCompletedEventArgs>(checkLogin);
            client.GetLoginAsync(txtUsernameInput.Text);
            
            
        }
        void checkLogin(object sender, ServiceReference1.GetLoginCompletedEventArgs e){

            authBit = e.Result.ToString();
            if (authBit == "1")
            {
                NavigationService.Navigate(new Uri("/Page1.xaml", UriKind.Relative));
            }
            else
            {
                txtUsernameInput.Text = "User not found or not a picker";
            }
        }
        private void txtUsernameInput_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void txtUsernameInput_Tap(object sender, GestureEventArgs e)
        {
            txtUsernameInput.Text = "";
        }
    }
}