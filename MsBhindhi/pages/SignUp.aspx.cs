using System;
using System.Diagnostics;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lab_6.DAL;

namespace Lab_6.Pages
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if session exists and user is logged in
            if (Session["UserEmail"] != null)
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string phoneNumber = txtPhoneNumber.Text.Trim();
            string address = txtAddress.Text.Trim();

            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) ||
                string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(phoneNumber) || string.IsNullOrEmpty(address) ||
                !IsValidEmail(email) || !IsPhoneNumber(phoneNumber))
            {
                string errorMessage = "Please fill in all fields in a valid manner.";
                ClientScript.RegisterStartupScript(this.GetType(), "ValidationScript", $"showError('{errorMessage}'); ", true);
                return;
            }

            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            int error = dalManager.RegisterUser($"{firstName} {lastName}", email, password, phoneNumber, address);
            if (error == -1)
            {
                string errorMessage = "This email is already in use.";
                ClientScript.RegisterStartupScript(this.GetType(), "ValidationScript", $"showError('{errorMessage}');", true);
                return;
            }

            FormsAuthentication.SetAuthCookie(email, true); // Set authentication cookie
            Session["UserEmail"] = email; // Store user email in session
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

        private bool IsPhoneNumber(string phoneNumber)
        {
            foreach (char character in phoneNumber)
            {
                if (character < '0' || character > '9')
                {
                    return false;
                }
            }

            return true;
        }
    }
}
