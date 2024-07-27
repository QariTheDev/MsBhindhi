<%@ Page Title="" Language="C#" MasterPageFile="~/pages/Layout.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="MsBhindhi.pages.notis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageArea" runat="server">

    <div class="main">
        <!-- Notifications will be displayed here -->
        <h2>Notifications</h2>
         <table class="restaurant-table">
             <asp:Repeater ID="rptNotis" runat="server">
                 <ItemTemplate>
                     <tr>
                         <td><%# Eval("NotisText") %></td>
                     </tr>
                 </ItemTemplate>
             </asp:Repeater>
        </table>
    </div>
</asp:Content>
