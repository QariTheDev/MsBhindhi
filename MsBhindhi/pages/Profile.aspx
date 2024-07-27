<%@ Page Title="" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Lab_6.Profile" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="profile-body">
            <div class="profile-container">
                <h1 class="profile-title">Profile</h1>
                <div class="profile-info">
                    <asp:Image ID="userImage" runat="server" ImageUrl="~/images/user-profile.png" CssClass="profile-rounded-image" />
                </div>

                <div class="profile-info">
                    <asp:Label ID="lblFullName" runat="server" Text="Full Name:" AssociatedControlID="txtFullName" CssClass="profile-label"></asp:Label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="profile-custom-textbox" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="profile-info">
                    <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail" CssClass="profile-label"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="profile-custom-textbox" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="profile-info">
                    <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone Number:" AssociatedControlID="txtPhoneNumber" CssClass="profile-label"></asp:Label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="profile-custom-textbox" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="profile-info">
                    <asp:Label ID="lblAddress" runat="server" Text="Address:" AssociatedControlID="txtAddress" CssClass="profile-label"></asp:Label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="profile-custom-textbox" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="profile-info">
                    <asp:Label ID="lblLoyaltyPoints" runat="server" Text="Loyalty Points:" AssociatedControlID="txtLoyaltyPoints" CssClass="profile-label"></asp:Label>
                    <asp:TextBox ID="txtLoyaltyPoints" runat="server" CssClass="profile-custom-textbox" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
