using Lab_6.DAL;
using System;
using System.Web.UI.WebControls;

namespace Lab_6.Pages
{
    public partial class Restaurants : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataAccessLayerManager dataAccessLayerManager = new DataAccessLayerManager();

                // Bind restaurants data to repeater
                repeaterRestaurants.DataSource = dataAccessLayerManager.GetRestaurants();
                repeaterRestaurants.DataBind();
            }
        }

        protected void repeaterRestaurants_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int restaurantID = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("RestaurantInfo.aspx?RestaurantID=" + restaurantID);
            }
        }

        // Method to generate star icons based on rating
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

        public class Restaurant
        {
            public int ID { get; set; }
            public string ImageUrl { get; set; }
            public string Name { get; set; }
            public double Rating { get; set; }
            public string LocationUrl { get; set; }
            public string Location { get; set; }
        }
    }
}