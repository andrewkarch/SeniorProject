<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Management.aspx.cs" Inherits="AWC_IMS._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        #btnInventory
        {}
    </style>
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="grid_12">
        <h2 id="pageTitle">Data Management System</h2>
    </div>
    <div class="clear"></div>
    <div class="grid_12 center">
        <div class="manageMenu">
            <p class="menuHeading"><br />Choose the data to work with:</p>
            <br />
            <asp:Button ID="btnInventory" runat="server" CssClass="item" PostBackUrl="~/MngInventory.aspx" Text="Manage Inventory" /><br />
            <br />
            <asp:Button ID="btnCustomers" runat="server" CssClass="item" PostBackUrl="~/MngCustomers.aspx" Text="Manage Customer" /><br />
            <br />
            <asp:Button ID="btnEmployees" runat="server" CssClass="item" PostBackUrl="~/MngEmployees.aspx" Text="Manage Employees" /><br />
            <br />
            <asp:Button ID="btnOrders" runat="server" CssClass="item" PostBackUrl="~/MngOrders.aspx" Text="Manage Orders" /><br />
            <br />
        </div>
    </div>
</asp:Content>
