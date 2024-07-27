using Lab_6.DAL;
using System;
using System.Web.Security;
using System.Web.UI;

namespace Lab_6.Pages
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if session exists and user is logged in
            if (Session["UserEmail"] != null)
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                // Hide the intro splash if it's a postback (e.g., due to login attempt)
                if (IsPostBack)
                {
                    splash.Visible = false;
                }
            }
        }


        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) || !IsValidEmail(email))
            {
                string errorMessage = "Please enter your valid email and password.";
                ClientScript.RegisterStartupScript(this.GetType().GetType(), "ValidationScript", $"showError('{errorMessage}');", true);
                return;
            }

            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            string userEmail = dalManager.SignIn(email, password);

            if (string.IsNullOrEmpty(userEmail))
            {
                string errorMessage = "Invalid email or password.";
                ClientScript.RegisterStartupScript(this.GetType().GetType(), "ValidationScript", $"showError('{errorMessage}');", true);
                return;
            }

            FormsAuthentication.SetAuthCookie(email, true); 
            Session["UserEmail"] = userEmail; 
            Response.Redirect("Home.aspx");
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}