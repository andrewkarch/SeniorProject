<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MngEmployees.aspx.cs" Inherits="AWC_IMS.MngEmployees" %>
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
        <h2 id="H1">Manage Employees</h2>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="grid_6" dir="ltr">
                <p>
                    Search by Last Name or Username:</p>
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
                        Width="936px" DataKeyNames="employee_id"
                        OnRowEditing="EditRow" 
                        OnRowUpdating="UpdateRow" CellPadding="3"
                        OnRowDeleting="DeleteRow" GridLines="Vertical" BackColor="White"
                        OnRowCancelingEdit="CancelEditRow"
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:TemplateField HeaderText="First Name" HeaderStyle-HorizontalAlign="Left"> 
                               <EditItemTemplate> 
                                <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("first_name") %>'></asp:TextBox> 
                               </EditItemTemplate> 
                               <ItemTemplate> 
                                <asp:Label ID="lblFirstName" runat="server" Text='<%# Bind("first_name") %>'></asp:Label> 
                               </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" HeaderStyle-HorizontalAlign="Left"> 
                               <EditItemTemplate> 
                                <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("last_name") %>'></asp:TextBox> 
                               </EditItemTemplate> 
                               <ItemTemplate> 
                                <asp:Label ID="lblLastName" runat="server" Text='<%# Bind("last_name") %>'></asp:Label> 
                               </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Username" HeaderStyle-HorizontalAlign="Left"> 
                               <EditItemTemplate> 
                                <asp:TextBox ID="txtUsername" runat="server" Text='<%# Bind("username") %>'></asp:TextBox> 
                               </EditItemTemplate> 
                               <ItemTemplate> 
                                <asp:Label ID="lblUsername" runat="server" Text='<%# Bind("username") %>'></asp:Label> 
                               </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Position Id" HeaderStyle-HorizontalAlign="Left"> 
                               <EditItemTemplate> 
                                <asp:TextBox ID="txtPositionId" runat="server" Text='<%# Bind("position_id") %>'></asp:TextBox> 
                               </EditItemTemplate> 
                               <ItemTemplate> 
                                <asp:Label ID="lblPositionId" runat="server" Text='<%# Bind("position_id") %>'></asp:Label> 
                               </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department" HeaderStyle-HorizontalAlign="Left">  
                               <ItemTemplate> 
                                <asp:Label ID="lblDepartment" runat="server" Text='<%# Bind("name") %>'></asp:Label> 
                               </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Active" HeaderStyle-HorizontalAlign="Left"> 
                               <EditItemTemplate> 
                                <asp:TextBox ID="txtActive" runat="server" Text='<%# Bind("active") %>'></asp:TextBox> 
                               </EditItemTemplate> 
                               <ItemTemplate> 
                                <asp:Label ID="lblActive" runat="server" Text='<%# Bind("active") %>'></asp:Label> 
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
            Getting Employee Information...
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div class="clear"></div>
    <div class="grid_12">
        <asp:Panel ID="Panel1" CssClass="formPanel" runat="server">
            <asp:Label ID="lblFormName" runat="server" Text="Add Employee"></asp:Label>
            <asp:Label ID="lblFormError" CssClass="hidden" runat="server" Text=""></asp:Label><br />
            <div class="formControlColumnLeft1">
                <asp:Label ID="lblFirstName" CssClass="formLabel" runat="server" Text="* First Name"></asp:Label><br />
                <asp:Label ID="lblLastName" CssClass="formLabel" runat="server" Text="* Last Name"></asp:Label><br />
                <asp:Label ID="lblUsername" CssClass="formLabel" runat="server" Text="* Username"></asp:Label><br />
            </div>
            <div class="formControlColumnLeft2">
                <asp:TextBox ID="txtNewFirstName" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtNewLastName" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtNewUsername" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
            </div>
            <div class="formControlColumnRight1">
                <asp:Label ID="lblPositionId" CssClass="formLabel" runat="server" Text="* Position Id"></asp:Label><br />
                <asp:Label ID="lblActive" CssClass="formLabel" runat="server" Text="* Active"></asp:Label><br />
            </div>
            <div class="formControlColumnRight2">
                <asp:TextBox ID="txtNewPositionId" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
                <asp:TextBox ID="txtNewActive" CssClass="formInput" AutoCompleteType="None" runat="server"></asp:TextBox><br />
            </div>
            <div class="clear"></div>
            <asp:Button ID="Add" runat="server" CssClass="button" Text="Add" OnClick="Add_Click1" />
            <asp:Button ID="Cancel" runat="server" CssClass="button" Text="Cancel" OnClick="Cancel_Click1" /><br />
        </asp:Panel>
    </div>
</asp:Content>