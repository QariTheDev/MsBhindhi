using Lab_6.DAL;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.UI.WebControls;
using static Lab_6.Home;
using static Lab_6.Pages.Restaurants;
using MenuItem = Lab_6.Home.MenuItem;

namespace Lab_6.Pages
{
    public partial class RestaurantInfo : System.Web.UI.Page
    {
        private int RestaurantID { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            // Fetch restaurant info and menu items
            if (!string.IsNullOrEmpty(Request.QueryString["RestaurantID"]))
            {
                if (int.TryParse(Request.QueryString["RestaurantID"], out int restaurantID))
                {
                    RestaurantID = restaurantID;
                    if (!IsPostBack)
                    {
                        PopulateRestaurantInfo(RestaurantID);
                        PopulateMenuItems(RestaurantID);
                    }

                }
                else
                {
                    Response.Redirect("Error.aspx");
                }
            }
            else
            {
                Response.Redirect("Error.aspx");
            }
        }

        // Method to populate restaurant information
        private void PopulateRestaurantInfo(int restaurantID)
        {
            DataAccessLayerManager restaurantDAL = new DataAccessLayerManager();
            Restaurant restaurant = restaurantDAL.GetRestaurantByID(restaurantID);
            if (restaurant == null)
            {
                Response.Redirect("Error.aspx");
                return;
            }

            // Populate controls with restaurant info
            imgRestaurant.ImageUrl = restaurant.ImageUrl;
            litRestaurantName.Text = restaurant.Name;
            litRating.Text = GenerateStars(restaurant.Rating);
            litLocation.Text = restaurant.Location;
            hypLocationUrl.NavigateUrl = restaurant.LocationUrl;
        }

        // Method to populate menu items
        private void PopulateMenuItems(int restaurantID)
        {
            DataAccessLayerManager restaurantDAL = new DataAccessLayerManager();
            List<MenuItem> menuItems = restaurantDAL.GetMenuItemsByRestaurantID(restaurantID);

            // Bind menu items to repeater
            repeaterMenuItems.DataSource = menuItems;
            repeaterMenuItems.DataBind();
        }

        protected string GenerateStars(object rating)
        {
            double ratingValue = Convert.ToDouble(rating);
            int fullStars = (int)ratingValue;
            bool hasHalfStar = ratingValue - fullStars >= 0.5;

            string starsHtml = string.Empty;

            // Full stars
            for (int i = 0; i < fullStars; i++)
            {
                starsHtml += "<span class='fa fa-star checked'></span>";
            }

            // Half star
            if (hasHalfStar)
            {
                starsHtml += "<span class='fa fa-star-half-full'></span>";
            }

            return starsHtml;
        }

        // Event handler for when a MenuItem is clicked
        protected void MenuItem_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (int.TryParse(btn.CommandArgument, out int menuItemId))
            {
                DataAccessLayerManager restaurantDAL = new DataAccessLayerManager();
                List<MenuItem> menuItems = restaurantDAL.GetMenuItemsByRestaurantID(RestaurantID);

                MenuItem menuItem = menuItems.Find(item => item.ID == menuItemId);
                restaurantDAL.AddCartItem(Session["UserEmail"].ToString(), menuItem.ID, 1);
            }
        }
    }
}
