<%@ Page Title="" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Lab_6.Cart" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="cart-body">
            <div class="cart-container">
                <h1 class="cart-title">Cart</h1>
                <asp:Repeater ID="rptCartItems" runat="server">
                    <ItemTemplate>
                        <div class="cart-item">
                            <asp:Image ID="imgCartItem" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="cart-image" />
                            <div class="cart-details">
                                <div class="cart-name"><%# Eval("Name") %></div>
                                <div class="cart-price"><%# Eval("Price") %></div>
                            </div>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="cart-quantity profile-custom-textbox" Text='<%# Eval("Quantity") %>' type="number" min="1" Enabled="false"></asp:TextBox>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" CssClass="cart-checkout-button" OnClick="btnClearCart_Click" />
                <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="cart-checkout-button" OnClick="btnCheckout_Click" />
            </div>
        </div>
    </div>
</asp:Content>
