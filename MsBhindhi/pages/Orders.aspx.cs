using Lab_6.DAL;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace Lab_6
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] == null)
                {
                    Response.Redirect("SignIn.aspx"); // Redirect to sign in if not logged in
                }
                else
                {
                    LoadOrders();
                }
            }
        }

        protected void LoadOrders()
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();

            rptOrders.DataSource = dalManager.GetOrders(Session["UserEmail"].ToString());
            rptOrders.DataBind();
        }
    }
}
