<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MngInventory.aspx.cs" Inherits="AWC_IMS.MngInventory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            //$("table").tablesorter({
            //    headers: {
            //        0: { sorter: false },
            //        6: { sorter: false },
            //        7: { sorter: false }
            //    }
            //});
        });
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server">
    </asp:ScriptManager>
    <div class="grid_12">
        <h2 id="pageTitle">Manage Inventory</h2>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="grid_6" dir="ltr">
                <p>
                    Search by Product Name or Description:</p>
                <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" CssClass="searchText"
                    OnTextChanged="txtSearch_TextChanged">
                </asp:TextBox>
            </div>
            <div class="clear">
            </div>
            <div class="grid_12">
                <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    ShowHeaderWhenEmpty="True" AllowPaging="True" AllowSorting="True" 
                    Width="936px" DataKeyNames="inventory_id"
                    OnRowEditing="EditRow" 
                    OnRowUpdating="UpdateRow" CellPadding="3"
                    OnRowDeleting="DeleteRow" GridLines="Vertical" BackColor="White" 
                    BorderColor="#999999" BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Product Id" HeaderStyle-HorizontalAlign="Left"> 
                           <EditItemTemplate> 
                            <asp:TextBox ID="txtProductId" runat="server" Text='<%# Bind("product_id") %>'></asp:TextBox> 
                           </EditItemTemplate> 
                           <ItemTemplate> 
                            <asp:Label ID="lblProductId" runat="server" Text='<%# Bind("product_id") %>'></asp:Label> 
                           </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" HeaderStyle-HorizontalAlign="Left"> 
                           <EditItemTemplate> 
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("quantity") %>'></asp:TextBox> 
                           </EditItemTemplate> 
                           <ItemTemplate> 
                            <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("quantity") %>'></asp:Label> 
                           </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Row" HeaderStyle-HorizontalAlign="Left"> 
                           <EditItemTemplate> 
                            <asp:TextBox ID="txtRow" runat="server" Text='<%# Bind("row") %>'></asp:TextBox> 
                           </EditItemTemplate> 
                           <ItemTemplate> 
                            <asp:Label ID="lblRow" runat="server" Text='<%# Bind("row") %>'></asp:Label> 
                           </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Box" HeaderStyle-HorizontalAlign="Left"> 
                           <EditItemTemplate> 
                            <asp:TextBox ID="txtBox" runat="server" Text='<%# Bind("box") %>'></asp:TextBox> 
                           </EditItemTemplate> 
                           <ItemTemplate> 
                            <asp:Label ID="lblBox" runat="server" Text='<%# Bind("box") %>'></asp:Label> 
                           </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="Update" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel"/>
                            </EditItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete"/>
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
            Getting Inventory Information...
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div class="clear"></div>
    <div class="grid_12">
        <asp:Panel ID="formPanel" CssClass="formPanel" runat="server">
            <asp:Label ID="lblFormName" runat="server" Text="Add Inventory"></asp:Label>
            <asp:Label ID="lblFormError" CssClass="hidden" runat="server" Text=""></asp:Label><br />
            <div class="formControlColumnLeft1">
                <asp:Label ID="lblProductId" CssClass="formLabel" runat="server" Text="* Product Id"></asp:Label><br />
                <asp:Label ID="lblQuantity" CssClass="formLabel" runat="server" Text="* Quantity"></asp:Label><br />
            </div>
            <div class="formControlColumnLeft2">
                <asp:TextBox ID="txtNewProductId" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtNewQuantity" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
            </div>
            <div class="formControlColumnRight1">
                <asp:Label ID="lblRow" CssClass="formLabel" runat="server" Text="* Row"></asp:Label><br />
                <asp:Label ID="lblBox" CssClass="formLabel" runat="server" Text="* Box"></asp:Label><br />
            </div>
            <div class="formControlColumnRight2">
                <asp:TextBox ID="txtNewRow" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtNewBox" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
            </div>
            <div class="clear"></div>
            <asp:Button ID="Add" runat="server" CssClass="button" Text="Add" OnClick="Add_Click1" />
            <asp:Button ID="Cancel" runat="server" CssClass="button" Text="Cancel" OnClick="Cancel_Click1" /><br />
        </asp:Panel>
    </div>
</asp:Content>
