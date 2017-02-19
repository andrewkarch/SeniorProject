<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirm.aspx.cs" Inherits="AWC_IMS.Catalog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("table").tablesorter()
        });
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_12">
        <h2 id="pageTitle">Order Confirmation</h2>
    </div>
    <div class="grid_12">
        <p>Your order has been placed. Thank you for your order!</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    </div>
    <div class="grid_12">
    </div>
    </asp:Content>
