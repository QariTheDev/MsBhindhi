<%@ Page Title="Restaurant Management" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="RestaurantManagement.aspx.cs" Inherits="Lab_6.RestaurantManagement" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="restaurant-management-container">
            <h1 class="restaurant-management-title">Restaurant Management</h1>

            <div class="add-restaurant-form">
                <h2 class="add-restaurant-header">Add New Restaurant</h2>
                <div class="add-restaurant-info">
                    <asp:Label ID="lblRestaurantName" runat="server" Text="Name:" CssClass="add-restaurant-label"></asp:Label>
                    <asp:TextBox ID="txtRestaurantName" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>
                <div class="add-restaurant-info">
                    <asp:Label ID="lblCuisineType" runat="server" Text="Cuisine Type:" CssClass="add-restaurant-label"></asp:Label>
                    <asp:TextBox ID="txtCuisineType" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>
                <div class="add-restaurant-info">
                    <asp:Label ID="lblLocation" runat="server" Text="Location:" CssClass="add-restaurant-label"></asp:Label>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>
                <div class="add-restaurant-info">
                    <asp:Label ID="lblRating" runat="server" Text="Rating:" CssClass="add-restaurant-label"></asp:Label>
                    <asp:TextBox ID="txtRating" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>
                <div class="add-restaurant-info">
                    <asp:Label ID="lblLocationUrl" runat="server" Text="Location URL:" CssClass="add-restaurant-label"></asp:Label>
                    <asp:TextBox ID="txtLocationUrl" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>
                <div class="add-restaurant-info">
                    <asp:Label ID="lblImageUrl" runat="server" Text="Image URL:" CssClass="add-restaurant-label"></asp:Label>
                    <asp:TextBox ID="txtImageUrl" runat="server" CssClass="add-restaurant-textbox" TextMode="SingleLine"></asp:TextBox>
                </div>
                <asp:Button ID="btnAddRestaurant" runat="server" Text="Add Restaurant" OnClick="btnAddRestaurant_Click" CssClass="add-restaurant-button" />
            </div>

            <div class="existing-restaurants">
                <h2 class="existing-restaurants-header">Existing Restaurants</h2>
                <table class="restaurant-table">
                    <asp:Repeater ID="rptRestaurants" runat="server">
                        <HeaderTemplate>
                            <tr>
                                <th>Name</th>
                                <th>Location</th>
                                <th>Rating</th>
                                <th>Actions</th>
                            </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Name") %></td>
                                <td><%# Eval("Location") %></td>
                                <td><%# Eval("Rating") %></td>
                                <td>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnCommand="btnDelete_Command" CommandName="DeleteRestaurant" CommandArgument='<%# Eval("ID") %>' CssClass="delete-restaurant-button" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
