<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="Lab_6.Pages.SignIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ms Bhindhi - Sign In</title>
    <link rel="stylesheet" type="text/css" href="~/styles/loginStyles.css" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
    <script type="text/javascript">
        function showError(message) {
            var errorBalloon = document.getElementById('errorBalloon');

            errorBalloon.innerText = message;
            errorBalloon.style.display = 'block';
        }

        document.addEventListener('DOMContentLoaded', (e) => {
            const splash = document.querySelector('.splash');
            setTimeout(() => {
                splash.classList.add('display-none');
            }, 2000);
        });
    </script>
</head>
<body>
    <div id="splash" class="splash" runat="server">
        <h1 class="fade-in">Welcome To Ms Bhindhi

        </h1>
<%--        <h5 class="fade-in">Group Members</h5>
        <p class="fade-in">M. Talha Iqbal <br />Umair Munir <br />Daniyal Malik <br />Talal Afzal</p>--%>
    </div>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="wrapper">
            <h1>Sign In</h1>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtEmail" placeholder="Email" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-envelope"></i>
            </div>
            <div class="input-box">
                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" placeholder="Password" CssClass="form-control"></asp:TextBox>
                <i class="bx bxs-lock-alt"></i>
            </div>
            <asp:Button runat="server" ID="btnSignIn" Text="Sign In" CssClass="btn" OnClick="btnSignIn_Click" />
            <div id="errorBalloon" class="error-balloon" style="display: none;">An error occurred during sign in. Please check your credentials and try again.</div>
            <div class="login-link">
                <p>Don't have an account? <a href="SignUp.aspx">Sign Up</a></p>
            </div>
        </div>
    </form>
</body>
</html>
