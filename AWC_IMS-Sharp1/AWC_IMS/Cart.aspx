<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="AWC_IMS.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("table").tablesorter()
        });
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_12">
        <h2 id="pageTitle">Shopping Cart</h2>
    </div>
    <div class="grid_12">
        <div class="cartTotal">
            <h2>
                <asp:GridView ID="CartGridView" runat="server" AutoGenerateColumns="False" 
                    ShowHeaderWhenEmpty="True" ViewStateMode="Enabled" BackColor="White" 
                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" 
                    CellSpacing="4" ForeColor="Black" GridLines="Vertical" Width="936px" 
                    onrowdeleting="GridView_RowDeleted">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                    
                        <asp:BoundField HeaderText="Item" DataField="Item" />
                        <asp:BoundField HeaderText="Item Name" DataField="ItemName" />
                        <asp:BoundField HeaderText="Item ID" DataField="ItemID" />
                        <asp:BoundField HeaderText="Quantity" DataField="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price per Unit" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                Total:&nbsp; $<asp:Label ID="TotalLabel" runat="server" Text="0.00"></asp:Label>
            </h2>
            <br />
            <asp:Button ID="btnConfirm" runat="server" CssClass="" 
                onclick="btnConfirm_Click"  Text="Confirm Order" />
            <br />
        </div>
    </div>
    <br />
</asp:Content>
