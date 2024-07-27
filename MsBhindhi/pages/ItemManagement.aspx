<%@ Page Title="Item Management" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="ItemManagement.aspx.cs" Inherits="Lab_6.ItemManagement" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="restaurant-management-container" style="min-width: 800px">
            <h1 class="restaurant-management-title">Item Management</h1>

            <div class="add-restaurant-form">
                <h2 class="add-restaurant-header">Add New Item</h2>
                <div class="add-item-info">
                    <asp:Label ID="lblRestaurantName" runat="server" Text="Restaurant Name:" CssClass="add-item-label"></asp:Label>
                    <asp:TextBox ID="txtRestaurantName" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>

                <div class="add-item-info">
                    <asp:Label ID="lblName" runat="server" Text="Name:" CssClass="add-item-label"></asp:Label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>

                <div class="add-item-info">
                    <asp:Label ID="lblDescription" runat="server" Text="Description:" CssClass="add-item-label"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="add-restaurant-textbox" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>

                <div class="add-item-info">
                    <asp:Label ID="lblPrice" runat="server" Text="Price:" CssClass="add-item-label"></asp:Label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="add-restaurant-textbox" TextMode="Number"></asp:TextBox>
                </div>

                <div class="add-item-info">
                    <asp:Label ID="lblInventory" runat="server" Text="Inventory:" CssClass="add-item-label"></asp:Label>
                    <asp:TextBox ID="txtInventory" runat="server" CssClass="add-restaurant-textbox" TextMode="Number"></asp:TextBox>
                </div>

                <div class="add-item-info">
                    <asp:Label ID="lblImageUrl" runat="server" Text="Image URL:" CssClass="add-item-label"></asp:Label>
                    <asp:TextBox ID="txtImageUrl" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>

                <asp:Button ID="btnAddItem" runat="server" Text="Add Item" OnClick="btnAddItem_Click" CssClass="add-restaurant-button" />
            </div>

            <div class="existing-restaurants">
                <h2 class="existing-restaurants-header">Existing Items</h2>
                <table class="restaurant-table">
                    <asp:Repeater ID="rptItems" runat="server">
                        <HeaderTemplate>
                            <tr>
                                <th>Restaurant Name</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("RestaurantName") %></td>
                                <td><%# Eval("Name") %></td>
                                <td><%# Eval("Description") %></td>
                                <td>Rs. <%# Eval("Price") %></td>
                                <td>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnCommand="btnDelete_Command" CommandName="DeleteItem" CommandArgument='<%# Eval("ID") %>' CssClass="delete-restaurant-button" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
