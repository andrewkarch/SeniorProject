<%@ Page Title="AWC Log In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="AWC_IMS.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="grid_12">
    <h2>
        AWC Log In
    </h2>
    <p>Please enter your username and password</p>
        <p>.</p>
    &nbsp;Username
        <asp:TextBox ID="UsernameTxt" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        Password 
        <asp:TextBox ID="PasswordTxt" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Button ID="LoginButton" runat="server" Text="Login" 
            onclick="LoginButton_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />

    <br />
    <p>Contact your AWC sales representative if you don't have an account....</p>
    </div>
</asp:Content>
