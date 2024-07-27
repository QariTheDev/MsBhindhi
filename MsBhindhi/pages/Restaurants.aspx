<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Layout.Master" AutoEventWireup="true" CodeBehind="Restaurants.aspx.cs" Inherits="Lab_6.Pages.Restaurants" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="top-bar">
            <input style="width: 25rem" type="text" placeholder="Search for restaurants, dishes, or cuisines" />
            <asp:Button CssClass="searchButton" ID="searchButton" Text="Search" runat="server" />
        </div>

        <!-- "Restaurants" heading placed above the grid -->
        <h2 class="menu-title">Restaurants</h2>

        <div class="restaurant-menu">
            <asp:Repeater runat="server" ID="repeaterRestaurants" OnItemCommand="repeaterRestaurants_ItemCommand">
                <ItemTemplate>
                    <div class="menu-wrapper">
                        <div class="menu-row">
                            <div class="menu-card">
                                <div class="menu-img">
                                    <asp:Image runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                                </div>
                                <div class="restaurant-info">
                                    <p><%# Eval("Name") %></p>
                                    <div style="flex-direction: row">
                                        <!-- Add star icons dynamically based on rating -->
                                        <asp:Literal runat="server" Text='<%# GenerateStars(Eval("Rating")) %>'></asp:Literal>
                                    </div>
                                    <a class="restaurant-loc" target="_blank" href='<%# Eval("LocationUrl") %>'>Location: <%# Eval("Location") %></a>
                                    <asp:Button runat="server" CssClass="button" Text="View Details" CommandName="ViewDetails" CommandArgument='<%# Eval("ID") %>' />
                                    <!-- Use a button to trigger redirection and pass the restaurant ID -->
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
