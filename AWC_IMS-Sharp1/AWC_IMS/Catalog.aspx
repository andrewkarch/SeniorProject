<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalog.aspx.cs" Inherits="AWC_IMS.Catalog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("table").tablesorter()
        });
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server">
    </asp:ScriptManager>
    <div class="grid_12">
        <h2 id="pageTitle">Product Catalog</h2>
    </div>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="grid_6" dir="ltr">
                <p>
                    Search by Customer ID or Name:</p>
                <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" CssClass="searchText"
                    OnTextChanged="txtSearch_TextChanged">
                </asp:TextBox>
            </div>
            <div class="clear">
            </div>
    
    <div class="grid_12">
                <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                <asp:GridView ID="GridView1" CssClass="tablesorter" runat="server" AutoGenerateColumns="False"
                    ShowHeaderWhenEmpty="True" AllowPaging="True" AllowSorting="true"
                    PageSize="10"  >
                    <Columns>
                        <asp:BoundField DataField="product_id" HeaderText="id" SortExpression="id" 
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                        <asp:BoundField DataField="description" HeaderText="Description" 
                            SortExpression="description" />
                        <asp:BoundField DataField="price" HeaderText="Price" 
                            SortExpression="price" />
                        <asp:BoundField DataField="qsum" HeaderText="Quantity in Stock" 
                            SortExpression="quantity" />
                        <asp:TemplateField HeaderText="Quantity to Add">
                            <ItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="Sorting" />
            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
        AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            Getting Customers...
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:Button ID="Button1" runat="server" Text="Add to Cart" 
        onclick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
        Text="Go To Checkout" />
</asp:Content>
