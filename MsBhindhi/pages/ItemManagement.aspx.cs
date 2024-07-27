using Lab_6.DAL;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace Lab_6
{
    public partial class ItemManagement : System.Web.UI.Page
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

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            string restaurantName = txtRestaurantName.Text.Trim();
            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            decimal price;
            if (!Decimal.TryParse(txtPrice.Text.Trim(), out price))
            {
                // Handle invalid price input
                return;
            }
            int inventory;
            if (!int.TryParse(txtInventory.Text.Trim(), out inventory))
            {
                // Handle invalid inventory input
                return;
            }
            string imageUrl = txtImageUrl.Text.Trim();

            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            dalManager.AddItem(restaurantName, name, description, price, inventory, imageUrl);

            // Clear form fields after adding item
            ClearFormFields();

            // Reload the items list
            LoadItems();
        }

        protected void LoadItems()
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            if (dalManager.IsUserAdmin(Session["UserEmail"].ToString()) == 0)
            {
                btnAddItem.Enabled = false;
                btnAddItem.Text = "You are not an admin";

                return;
            }

            DataTable itemsData = dalManager.GetItems();

            rptItems.DataSource = itemsData;
            rptItems.DataBind();
        }

        protected void ClearFormFields()
        {
            txtRestaurantName.Text = "";
            txtName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtInventory.Text = "";
            txtImageUrl.Text = "";
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                int itemID;
                if (!int.TryParse(e.CommandArgument.ToString(), out itemID))
                {
                    // Handle invalid item ID
                    return;
                }

                DataAccessLayerManager dalManager = new DataAccessLayerManager();
                dalManager.DeleteItem(itemID);

                // Reload the items list
                LoadItems();
            }
        }
    }
}
