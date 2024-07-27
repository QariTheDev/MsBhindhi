<%@ Page Title="" Language="C#" MasterPageFile="Layout.Master" AutoEventWireup="true" CodeBehind="Cheezious.aspx.cs" Inherits="Lab_6.Cheezious" %>

<asp:Content ID="PageArea" ContentPlaceHolderID="PageArea" runat="server">
    <div class="main">
        <div class="header">
            <div class="header-info" style="">
                <asp:Image ID="Image1" runat="server" ImageUrl="https://d2s742iet3d3t1.cloudfront.net/restaurants/restaurant-4790000000000000/banner_1667927387.jpg?size=medium" />
                <h1 class="header-text" style="position: absolute; top: 20px; left: 550px; font-size: 25px; color: white; z-index: 1; text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;">Cheezious</h1>
            </div>
        </div>

        <div class="featured">
            <h1>Featured Items</h1>
            <div class="featured-items">
                <div class="featured-item">
                    <asp:Image ID="Image2" runat="server" ImageUrl="https://d2s742iet3d3t1.cloudfront.net/restaurants/restaurant-4790000000000000/menu/items/6/item-227398096_1678482735.jpg?size=large" />
                    <div class="featured-item-info">
                        <h3>Two Step</h3>
                        <h5>Price: Rs 2250</h5>
                        <h6>Pick 2 Meats <strong>(1/4 lb portions)</strong> and <strong>2 Sides (5oz)</strong>
                            <br />
                            - with complementary toast & pickles.</h6>
                    </div>
                </div>
                <div class="featured-item">
                    <asp:Image ID="Image3" runat="server" ImageUrl="https://d2s742iet3d3t1.cloudfront.net/restaurants/restaurant-4790000000000000/menu/items/9/item-227397629_1678481822.jpg?size=large" />
                    <div class="featured-item-info">
                        <h3>Smoked Wings</h3>
                        <h5>Price: Rs 600</h5>
                        <h6>Dry rubbed and smoked jumbo party wings</h6>
                    </div>
                </div>
            </div>

            <h1 style="margin-top: 2.5rem;">Pizza</h1>
            <div class="featured-items">
                <div class="featured-item">
                    <asp:Image ID="Image4" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2Frestaurant_new%2F54946%2F54946%2Fdish%2F16129648331142483410.jpg&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Behari Kabab</h3>
                        <h5>Price: Rs 1400</h5>
                        <h6>Pick 2 Meats <strong>(1/4 lb portions)</strong> and <strong>2 Sides (5oz)</strong>
                            <br />
                            - with complementary toast & pickles.</h6>
                    </div>
                </div>
                <div class="featured-item">
                    <asp:Image ID="Image5" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2Frestaurant_new%2F54946%2F54946%2Fdish%2F1600197963480430153.png&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Crown Crust</h3>
                        <h5>Price: Rs 1400</h5>
                        <h6>Yummy Blend of Grilled Chicken, Olives, Onion, Capsicum<br />
                            and Special Sauce</h6>
                    </div>
                </div>
                <div class="featured-item">
                    <asp:Image ID="Image6" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2Frestaurant_new%2F54946%2F54946%2Fdish%2F16129654997952468.jpg&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Stuff Crust</h3>
                        <h5>Price: Rs 1500</h5>
                        <h6>Special Chicken, Green Olives, Mushroom, Edges Filled With Cheese Or Kabab</h6>
                    </div>
                </div>
            </div>
            <div class="featured-items">
                <div class="featured-item">
                    <asp:Image ID="Image7" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2Frestaurant_new%2F54946%2F54946%2Fdish%2F1612956575722870824.jpg&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Cheezy Lover</h3>
                        <h5>Price: Rs 750</h5>
                        <h6>Yummiest Blend of Cheese and Pizza Sauce</h6>
                    </div>
                </div>
                <div class="featured-item">
                    <asp:Image ID="Image8" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2Frestaurant_new%2F54946%2F54946%2Fdish%2F16129664171069619674.jpg&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Chicken Pepperoni</h3>
                        <h5>Price: Rs 600</h5>
                        <h6>Chicken Pepperoni, pizza sauce & cheese</h6>
                    </div>
                </div>
            </div>

            <h1 style="margin-top: 2.5rem;">Burgerz</h1>
            <div class="featured-items">
                <div class="featured-item">
                    <asp:Image ID="Image9" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2F54946%2Fdish_image%2F1628885791.png&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Bazinga Supreme</h3>
                        <h5>Price: Rs 750</h5>
                        <h6>2 Crispy Fried Boneless Thigh with Signature Sauce, Lettuce and A Cheese Slice.</h6>
                    </div>
                </div>
                <div class="featured-item">
                    <asp:Image ID="Image10" runat="server" ImageUrl="https://www.cheezious.com/_next/image?url=https%3A%2F%2Fem-cdn.eatmubarak.pk%2Frestaurant_new%2F%2F%2Fdish%2F16044237781581702297.png&w=256&q=90" />
                    <div class="featured-item-info">
                        <h3>Reggy Burger</h3>
                        <h5>Price: Rs 400</h5>
                        <h6>Perfectly Fried Chicken Patty  With Fresh Lettuce & Sauce in a Sesame Seed Bun</h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
