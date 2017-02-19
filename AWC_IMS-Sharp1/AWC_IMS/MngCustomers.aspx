<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MngCustomers.aspx.cs" Inherits="AWC_IMS.MngCustomers" %>
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
        <h2 id="pageTitle">Manage Customers</h2>
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
                <asp:GridView ID="GridView1" CssClass="tablesorter" runat="server" AutoGenerateColumns="False"
                    ShowHeaderWhenEmpty="True" AllowPaging="True" AllowSorting="true"
                    PageSize="10" onselectedindexchanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="customer_id" HeaderText="id" SortExpression="id" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                        <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
                        <asp:BoundField DataField="billing_street_address" HeaderText="Address" SortExpression="billing_address" />
                        <asp:BoundField DataField="billing_city" HeaderText="City" SortExpression="billing_city" />
                        <asp:BoundField DataField="billing_state" HeaderText="State" SortExpression="billing_state" />
                        <asp:BoundField DataField="billing_zipcode" HeaderText="ZIP" SortExpression="billing_zipcode" />
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit0" runat="server" Text="Edit" />
                                <asp:Button ID="btnDelete0" runat="server" Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
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
            Getting Customers...
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div class="clear"></div>
    <div class="grid_12">
        <asp:Panel ID="formPanel" CssClass="formPanel" runat="server">
            <asp:Label ID="lblFormName" runat="server" Text="Add Customer"></asp:Label>
            <asp:Label ID="lblFormError" CssClass="hidden" runat="server" Text=""></asp:Label><br />
            <div class="formControlColumnLeft1">
                <asp:Label ID="lblName" CssClass="formLabel" runat="server" Text="* Name"></asp:Label><br />
                <asp:Label ID="lblUsername" CssClass="formLabel" runat="server" Text="* User"></asp:Label><br />
                <asp:Label ID="lblDesc" CssClass="formLabel" runat="server" Text="Description"></asp:Label><br />
                <asp:Label ID="lblAddress" CssClass="formLabel" runat="server" Text="* Address"></asp:Label><br />
            </div>
            <div class="formControlColumnLeft2">
                <asp:TextBox ID="txtName" CssClass="formInput" AutoCompleteType="Company" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtUsername" CssClass="formInput" AutoCompleteType="DisplayName" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtDesc" CssClass="formInput" AutoCompleteType="Notes" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtAddress" CssClass="formInput" AutoCompleteType="BusinessStreetAddress" runat="server"></asp:TextBox><br />
            </div>
            <div class="formControlColumnRight1">
                <asp:Label ID="lblCity" CssClass="formLabel" runat="server" Text="* City"></asp:Label><br />
                <asp:Label ID="lblState" CssClass="formLabel" runat="server" Text="* State"></asp:Label><br />
                <asp:Label ID="lblZip" CssClass="formLabel" runat="server" Text="* ZIP"></asp:Label><br />
                <asp:Label ID="lblCountry" CssClass="formLabel" runat="server" Text="* Country"></asp:Label><br />
            </div>
            <div class="formControlColumnRight2">
                <asp:TextBox ID="txtCity" CssClass="formInput" AutoCompleteType="BusinessCity" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtState" CssClass="formInput" AutoCompleteType="BusinessState" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtZip" CssClass="formInput" AutoCompleteType="BusinessZipCode" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtCountry" CssClass="formInput" AutoCompleteType="BusinessCountryRegion" runat="server"></asp:TextBox><br />
            </div>
            <div class="clear"></div>
            <asp:Button ID="Add" runat="server" CssClass="button" Text="Add" OnClick="Add_Click1" />
            <asp:Button ID="Update" runat="server" CssClass="button hidden" Text="Update" OnClick="Update_Click1" />
            <asp:Button ID="Cancel" runat="server" CssClass="button" Text="Cancel" OnClick="Cancel_Click1" /><br />
        </asp:Panel>
    </div>
</asp:Content>
