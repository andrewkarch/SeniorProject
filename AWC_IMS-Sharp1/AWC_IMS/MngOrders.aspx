<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MngOrders.aspx.cs" Inherits="AWC_IMS.MngOrders" %>
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
        <h2 id="pageTitle">Manage Orders</h2>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="grid_6">
                <p>Search by PO number or Customer Name:</p>
                <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" CssClass="searchText"
                    OnTextChanged="txtSearch_TextChanged">
                </asp:TextBox>
            </div>
    <div class="grid_6"></div>
    <div class="grid_12">
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="pop_id" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" ShowFooter="True"
                    OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting" ShowHeaderWhenEmpty="True"
                    AllowPaging="True" AllowSorting="True" GridLines="Vertical" BackColor="White" BorderColor="#999999"
                    BorderStyle="Solid" BorderWidth="2px" CssClass="table">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:TemplateField HeaderText="POPID" HeaderStyle-HorizontalAlign="Left"> 
                            <ItemTemplate>
                                <asp:Label ID="lblPopId" runat="server" Text='<%# Bind("pop_id") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="POID" HeaderStyle-HorizontalAlign="Left"> 
                            <ItemTemplate>
                                <asp:Label ID="lblPoId" runat="server" Text='<%# Bind("po_id") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left"> 
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" HeaderStyle-HorizontalAlign="Left"> 
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100px" Text='<%# Bind("quantity") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("quantity") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date Placed" HeaderStyle-HorizontalAlign="Left"> 
                            <ItemTemplate>
                                <asp:Label ID="lblDatePlaced" runat="server" Text='<%# Bind("date_placed") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date Filled" HeaderStyle-HorizontalAlign="Left"> 
                            <ItemTemplate>
                                <asp:Label ID="lblDateFilled" runat="server" Text='<%# Bind("date_filled") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Filled By" HeaderStyle-HorizontalAlign="Left"> 
                            <ItemTemplate>
                                <asp:Label ID="lblEmployeeId" runat="server"  Text='<%# Bind("employee_id") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ship To Address" HeaderStyle-HorizontalAlign="Left"> 
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAddress" runat="server" Width="100px" Text='<%# Bind("csa_id") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("csa_id") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="Update" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <span onclick="return confirm('Are you sure you want to delete?')">
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" />
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="Sorting" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
        AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            Getting Purchase Order Products...
        </ProgressTemplate>
    </asp:UpdateProgress>
    </div>
    <div class="clear"></div>
</asp:Content>
