using Lab_6.DAL;
using System;
using System.Data;
using System.Web.UI;

namespace Lab_6
{
    public partial class Settings : Page
    {
        private const string DEFAULT_PASS = "*******";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load user settings data
                LoadProfileInfo(Session["UserEmail"].ToString());
            }
        }

        protected void btnUpdateSettings_Click(object sender, EventArgs e)
        {
            string userEmail = Session["UserEmail"].ToString();
            string fullName = txtFullName.Text.Trim();
            string phoneNumber = txtPhoneNumber.Text.Trim();
            string password = txtPassword.Text.Trim();
            string address = txtAddress.Text.Trim();

            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            dalManager.UpdateUserSettings(userEmail, fullName, password, phoneNumber, address, password != DEFAULT_PASS);

            string message = "Updated settings!";
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationScript", $"alert('{message}'); ", true);
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
                txtPassword.Text = DEFAULT_PASS;
                txtAddress.Text = row["Address"].ToString();
                txtPhoneNumber.Text = row["PhoneNumber"].ToString();
                txtEmail.Text = row["Email"].ToString();
            }
        }

    }
}
