<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Lab_6.Pages.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ms Bhindhi - Sign Up</title>
    <link rel="stylesheet" type="text/css" href="~/styles/loginStyles.css" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
    <script type="text/javascript">
        function showError(message) {
            // Get the errorBalloon element
            var errorBalloon = document.getElementById('errorBalloon');

            // Set the text of the errorBalloon
            errorBalloon.innerText = message;

            // Make the errorBalloon visible
            errorBalloon.style.display = 'block';
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="wrapper">
            <h1>Sign Up</h1>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtFirstName" placeholder="First Name" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-user"></i>
            </div>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtLastName" placeholder="Last Name" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-user"></i>
            </div>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtEmail" placeholder="Email" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-envelope"></i>
            </div>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" placeholder="Password" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-lock-alt"></i>
            </div>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtPhoneNumber" placeholder="Phone Number" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-phone"></i>
            </div>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtAddress" placeholder="Address" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-map"></i>
            </div>
            <asp:Button runat="server" ID="btnSignUp" Text="Sign Up" CssClass="btn" OnClick="btnSignUp_Click" />
            <div id="errorBalloon" class="error-balloon" style="display: none;">An error occurred during registration. Please check your inputs and try again.</div>
            <div class="login-link">
                <p>Already have an account? <a href="SignIn.aspx">Sign In</a></p>
            </div>
        </div>
    </form>
</body>
</html>
