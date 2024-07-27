using Lab_6.DAL;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace Lab_6
{
    public partial class RestaurantManagement : System.Web.UI.Page
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
                    LoadRestaurants();
                }
            }
        }

        protected void btnAddRestaurant_Click(object sender, EventArgs e)
        {
            string name = txtRestaurantName.Text.Trim();
            string cuisineType = txtCuisineType.Text.Trim();
            string location = txtLocation.Text.Trim();
            decimal rating;
            if (!Decimal.TryParse(txtRating.Text.Trim(), out rating))
            {
                // Handle invalid rating input
                return;
            }
            string locationUrl = txtLocationUrl.Text.Trim();
            string imageUrl = txtImageUrl.Text.Trim();

            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            dalManager.AddRestaurant(name, cuisineType, location, rating, locationUrl, imageUrl);

            // Clear form fields after adding restaurant
            ClearFormFields();

            // Reload the restaurants list
            LoadRestaurants();
        }

        protected void LoadRestaurants()
        {
            DataAccessLayerManager dalManager = new DataAccessLayerManager();
            if (dalManager.IsUserAdmin(Session["UserEmail"].ToString()) == 0)
            {
                btnAddRestaurant.Enabled = false;
                btnAddRestaurant.Text = "You are not an admin";

                return;
            }

            rptRestaurants.DataSource = dalManager.GetRestaurants();
            rptRestaurants.DataBind();
        }

        protected void ClearFormFields()
        {
            txtRestaurantName.Text = "";
            txtCuisineType.Text = "";
            txtLocation.Text = "";
            txtRating.Text = "";
            txtLocationUrl.Text = "";
            txtImageUrl.Text = "";
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "DeleteRestaurant")
            {
                int restaurantID;
                if (!int.TryParse(e.CommandArgument.ToString(), out restaurantID))
                {
                    // Handle invalid restaurant ID
                    return;
                }

                DataAccessLayerManager dalManager = new DataAccessLayerManager();
                dalManager.DeleteRestaurant(restaurantID);

                // Reload the restaurants list
                LoadRestaurants();
            }
        }
    }
}
