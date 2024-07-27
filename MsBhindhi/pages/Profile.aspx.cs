using System;
using System.Data;
using Lab_6.DAL;

namespace Lab_6
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserEmail"] == null)
                {
                    Response.Redirect("SignIn.aspx"); // Redirect to sign in if not logged in
                }
                else
                {
                    // User is logged in, load profile information
                    LoadProfileInfo(Session["UserEmail"].ToString());
                }
            }
        }

        private void LoadProfileInfo(string userEmail)
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            DataTable userData = new DataTable();

            // Call DAL method to get user information based on email
            dalManager.GetUserByEmail(userEmail, ref userData);

            if (userData.Rows.Count > 0)
            {
                // Populate profile fields
                DataRow row = userData.Rows[0];
                txtFullName.Text = row["Username"].ToString();
                txtAddress.Text = row["Address"].ToString();
                txtPhoneNumber.Text = row["PhoneNumber"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtLoyaltyPoints.Text = row["LoyaltyPoints"].ToString();
            }
        }
    }
}
