using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Lab_6
{
    public partial class Lab6 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is not logged in
            if (Session["UserEmail"] == null)
            {
                // Redirect to the Sign in page
                Response.Redirect("SignIn.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.Abandon();

            Response.Redirect("SignIn.aspx");
        }
    }
}