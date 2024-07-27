<%@ Page Title="Restaurant Management" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="Lab_6.Orders" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="restaurant-management-container">
            <h1 class="restaurant-management-title">Orders</h1>
            <div class="existing-restaurants">
                <table class="restaurant-table">
                    <asp:Repeater ID="rptOrders" runat="server">
                        <HeaderTemplate>
                            <tr>
                                <th>Restaurant</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Items</th>
                                <th>Total</th>
                            </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("RestaurantName") %></td>
                                <td><%# Eval("OrderDate") %></td>
                                <td><%# Eval("Status") %></td>
                                <td><%# Eval("Items") %></td>
                                <td>Rs. <%# Eval("Total") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
