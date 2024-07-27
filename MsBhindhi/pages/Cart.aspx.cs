using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Lab_6.DAL;
using static Lab_6.Home;

namespace Lab_6
{
    public partial class Cart : System.Web.UI.Page
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
                    LoadItems();

                }
            }
        }

        protected void LoadItems()
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            DataTable itemsData = dalManager.GetCartItems(Session["UserEmail"].ToString());

            rptCartItems.DataSource = itemsData;
            rptCartItems.DataBind();

            if (itemsData.Rows.Count == 0)
            {
                btnCheckout.Enabled = false;
                btnClearCart.Enabled = false;
            }
            else
            {
                btnCheckout.Enabled = true;
                btnClearCart.Enabled = true;
            }
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            dalManager.ClearCart(Session["UserEmail"].ToString());

            rptCartItems.DataSource = null;
            rptCartItems.DataBind();

            btnCheckout.Enabled = false;
            btnClearCart.Enabled = false;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            dalManager.CreateOrder(Session["UserEmail"].ToString());
            dalManager.AddLoyaltyPoints(Session["UserEmail"].ToString());

            Response.Redirect("Orders.aspx");
        }
    }
}
