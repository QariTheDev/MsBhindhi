using Lab_6.DAL;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace Lab_6
{
    public partial class Home : Page
    {
        protected List<Recommendation> Recommendations { get; set; } = new List<Recommendation>()
        {
            new Recommendation { ImageUrl = "https://e0.pxfuel.com/wallpapers/967/420/desktop-wallpaper-chicken-wing-chicken-wings.jpg", Name = "Hot Wings Bucket", Price = "Rs 550" },
            new Recommendation { ImageUrl = "https://i.ytimg.com/vi/bYMv0hXGfd0/maxresdefault.jpg", Name = "Anday Wala Burger", Price = "Rs 250" },
            new Recommendation { ImageUrl = "https://c4.wallpaperflare.com/wallpaper/435/472/996/sandwich-4k-for-desktop-wallpaper-preview.jpg", Name = "Ham Sandwich", Price = "Rs 400" },
            new Recommendation { ImageUrl = "https://thumbs.dreamstime.com/b/pina-colada-cocktail-beach-palm-tree-ocean-background-vacation-consept-273300428.jpg", Name = "Pina Colada", Price = "Rs 200" }
        };

        protected List<MenuCategory> MenuCategories { get; set; } = new List<MenuCategory>()
        {
            new MenuCategory { IconName = "logo-foursquare", CategoryName = "All Menus" },
            new MenuCategory { IconName = "fast-food-outline", CategoryName = "Burgers" },
            new MenuCategory { IconName = "pizza-outline", CategoryName = "Pizza" },
            new MenuCategory { IconName = "fast-food-outline", CategoryName = "Chinese" },
            new MenuCategory { IconName = "ice-cream-outline", CategoryName = "Ice Cream" },
            new MenuCategory { IconName = "wine-outline", CategoryName = "Drinks" }
        };

        protected List<MenuItem> MenuItems { get; set; } = new List<MenuItem>()
        {
            new MenuItem { ImageUrl = "https://images.pexels.com/photos/539451/pexels-photo-539451.jpeg", Name = "Tomato Soup", Price = "Rs 200" },
            new MenuItem { ImageUrl = "https://images.pexels.com/photos/539451/pexels-photo-539451.jpeg", Name = "Tomato Soup", Price = "Rs 200" },
            new MenuItem { ImageUrl = "https://images.pexels.com/photos/539451/pexels-photo-539451.jpeg", Name = "Tomato Soup", Price = "Rs 200" }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataAccessLayerManager dal = new DataAccessLayerManager();

                // Bind recommendations data to repeater
                repeaterRecommendations.DataSource = dal.GetRandomItems(4);
                repeaterRecommendations.DataBind();

                // Bind menu categories data to repeater
                repeaterMenuCategories.DataSource = MenuCategories;
                repeaterMenuCategories.DataBind();

                // Bind menu items data to repeater
                repeaterMenuItems.DataSource = dal.GetRandomItems(10);
                repeaterMenuItems.DataBind();
            }
        }

        public class Recommendation
        {
            public string ImageUrl { get; set; }
            public string Name { get; set; }
            public string Price { get; set; }
        }

        public class MenuCategory
        {
            public string IconName { get; set; }
            public string CategoryName { get; set; }
        }

        public class MenuItem
        {
            public int ID { get; set; }
            public string ImageUrl { get; set; }
            public string Name { get; set; }
            public string Price { get; set; }
            public string Description { get; set; }
        }
    }
}
