<%@ Page Title="Settings" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Lab_6.Settings" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="settings-body">
            <div class="settings-container">
                <h1 class="settings-title">Settings</h1>
                <div class="settings-info">
                    <asp:Label ID="lblFullName" runat="server" Text="Full Name:" AssociatedControlID="txtFullName" CssClass="settings-label"></asp:Label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="settings-custom-textbox" ReadOnly="false"></asp:TextBox>
                </div>
                <div class="settings-info">
                    <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail" CssClass="settings-label"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="settings-custom-textbox" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="settings-info">
                    <asp:Label ID="lblPassword" runat="server" Text="Password:" AssociatedControlID="txtPassword" CssClass="settings-label"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="settings-custom-textbox" TextMode="Password" ReadOnly="false"></asp:TextBox>
                </div>
                <div class="settings-info">
                    <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone Number:" AssociatedControlID="txtPhoneNumber" CssClass="settings-label"></asp:Label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="settings-custom-textbox" ReadOnly="false"></asp:TextBox>
                </div>
                <div class="settings-info">
                    <asp:Label ID="lblAddress" runat="server" Text="Address:" AssociatedControlID="txtAddress" CssClass="settings-label"></asp:Label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="settings-custom-textbox" ReadOnly="false"></asp:TextBox>
                </div>
                <asp:Button ID="btnUpdateSettings" runat="server" Text="Update Settings" OnClick="btnUpdateSettings_Click" CssClass="settings-update-button" />
            </div>
        </div>
    </div>
</asp:Content>
