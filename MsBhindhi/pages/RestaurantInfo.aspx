<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Layout.Master" AutoEventWireup="true" CodeBehind="RestaurantInfo.aspx.cs" Inherits="Lab_6.Pages.RestaurantInfo" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="restaurant-info">
            <div class="restaurant-header">
                <asp:Image runat="server" ID="imgRestaurant" CssClass="restaurant-info-image" />
                <div class="restaurant-details">
                    <h2>
                        <asp:Literal runat="server" ID="litRestaurantName"></asp:Literal></h2>
                    <div style="flex-direction: row">
                        <!-- Add star icons dynamically based on rating -->
                        <asp:Literal runat="server" ID="litRating" Text='<%# GenerateStars(Eval("Rating")) %>'></asp:Literal>
                    </div>
                    <p class="restaurant-info-location">
                        <asp:Literal runat="server" ID="litLocation"></asp:Literal>
                    </p>
                    <asp:HyperLink runat="server" ID="hypLocationUrl" Text="Location" CssClass="restaurant-info-location-url" Target="_blank" />
                </div>
            </div>
            <div class="menu">
                <h3 class="restaurant-info-menu-title">Menu</h3>
                <div class="restaurant-info-menu-filter">
                    <div class="restaurant-info-menu-row">
                        <div class="restaurant-info-menu-grid">
                            <asp:Repeater runat="server" ID="repeaterMenuItems">
                                <ItemTemplate>
                                    <div class="restaurant-info-menu-card">
                                        <div class="restaurant-info-menu-img">
                                            <asp:Image runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                                        </div>
                                        <div class="restaurant-info-menu-food-info">
                                            <p><%# Eval("Name") %></p>
                                            <p><%# Eval("Description") %></p>
                                            <ion-icon name="bookmark-outline"></ion-icon>
                                        </div>
                                        <p><%# Eval("Price", "{0:C}") %></p>
                                        <asp:Button runat="server" Text="Add to Cart" CssClass="button" OnClick="MenuItem_Click" CommandArgument='<%# Eval("ID") %>' />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
