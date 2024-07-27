using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lab_6.DAL;

namespace MsBhindhi.pages
{
    public partial class notis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("SignIn.aspx"); // Redirect to sign in if not logged in
            }
            else
            {
                LoadNotis();
            }
        }

        protected void LoadNotis()
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();

            rptNotis.DataSource = dalManager.AddNotification();
            rptNotis.DataBind();
        }
    }
}