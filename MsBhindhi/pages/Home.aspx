<%@ Page Title="" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Lab_6.Home" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">

    <div class="main">
        <div class="recommendation-container">
            <h3 style="text-align: left" class="rec-title">Recommendations</h3>
            <div class="food-cards">
                <asp:Repeater runat="server" ID="repeaterRecommendations">
                    <ItemTemplate>
                        <div class="rec-food">
                            <asp:Image runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                            <div class="food-info">
                                <h5><%# Eval("Name") %></h5>
                                <p>Rs. <%# Eval("Price") %></p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <div class="menu-filter">
            <h4 class="menu-title">Menu Category</h4>
            <asp:Repeater runat="server" ID="repeaterMenuCategories">
                <ItemTemplate>
                    <a href="Restaurants.aspx">
                        <div class="filter-card">
                            <div class="filter-icon">
                                    <ion-icon name='<%# Eval("IconName") %>'></ion-icon>
                            </div>
                            <p><%# Eval("CategoryName") %></p>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="line"></div>

        <div class="menu-filter">
            <div class="menu-row">
                <div class="menu-grid">
                    <asp:Repeater runat="server" ID="repeaterMenuItems">
                        <ItemTemplate>
                            <div class="menu-card" style="max-width: calc(25% - 20px); margin: 10px;">
                                <div class="menu-img">
                                    <asp:Image runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                                </div>
                                <div class="menu-food-info">
                                    <p><strong><%#Eval("Name")%></strong></p>
                                    <p style="font-size:x-small"><%# Eval("Description") %></p>
                                    <ion-icon name="bookmark-outline"></ion-icon>
                                </div>
                                <p>Rs. <%# Eval("Price") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
