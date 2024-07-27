using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using static Lab_6.Cart;
using static Lab_6.Home;
using static Lab_6.Pages.Restaurants;

namespace Lab_6.DAL
{
    public class DataAccessLayerManager
    {

        private static readonly string connString = System.Configuration.ConfigurationManager.ConnectionStrings["sqlCon1"].ConnectionString;

        public int RegisterUser(string username, string email, string password, string phoneNumber, string address)
        {
            int result = 0;
            using (SqlConnection connection = new SqlConnection(connString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("registerUser", connection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Username", username);
                    sqlCommand.Parameters.AddWithValue("@Email", email);
                    sqlCommand.Parameters.AddWithValue("@Password", HashPassword(password));
                    sqlCommand.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    sqlCommand.Parameters.AddWithValue("@Address", address);
                    sqlCommand.Parameters.Add("@Result", SqlDbType.Int).Direction = ParameterDirection.Output;

                    sqlCommand.ExecuteNonQuery();

                    result = Convert.ToInt32(sqlCommand.Parameters["@Result"].Value);
                }
            }

            return result;
        }
        
        public string SignIn(string email, string password)
        {
            string userEmail = "";
            using (SqlConnection connection = new SqlConnection(connString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("signInUser", connection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Email", email);
                    sqlCommand.Parameters.AddWithValue("@Password", HashPassword(password));
                    sqlCommand.Parameters.Add("@UserEmail", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

                    sqlCommand.ExecuteNonQuery();

                    userEmail = sqlCommand.Parameters["@UserEmail"].Value.ToString();
                }
            }

            return userEmail;
        }

        public void GetUserByEmail(string email, ref DataTable dataTable)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("GetUserByEmail", connection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Email", email);

                    using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                    {
                        sqlDataAdapter.Fill(dataTable);
                    }
                }
            }
        }

        public void UpdateUserSettings(string userEmail, string fullName, string password, string phoneNumber, string address, bool hashPassword)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                using (SqlCommand command = new SqlCommand("UpdateUserSettings", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserEmail", userEmail);
                    command.Parameters.AddWithValue("@FullName", fullName);
                    command.Parameters.AddWithValue("@Password", hashPassword ? HashPassword(password) : password);
                    command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    command.Parameters.AddWithValue("@Address", address);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public List<Restaurant> GetRestaurants()
        {
            List<Restaurant> restaurants = new List<Restaurant>();

            using (SqlConnection connection = new SqlConnection(connString))
            {
                using (SqlCommand command = new SqlCommand("GetRestaurants", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        Restaurant restaurant = new Restaurant
                        {
                            ID = Convert.ToInt32(reader["RestaurantID"]),
                            ImageUrl = reader["ImageUrl"].ToString(),
                            Name = reader["Name"].ToString(),
                            Rating = Convert.ToDouble(reader["Rating"]),
                            LocationUrl = reader["LocationUrl"].ToString(),
                            Location = reader["Location"].ToString()
                        };

                        restaurants.Add(restaurant);
                    }
                }
            }

            return restaurants;
        }

        public Restaurant GetRestaurantByID(int restaurantID)
        {
            Restaurant restaurant = new Restaurant();
            string query = "SELECT * FROM Restaurants WHERE RestaurantID = @RestaurantID";

            using (SqlConnection connection = new SqlConnection(connString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@RestaurantID", restaurantID);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    restaurant.ID = Convert.ToInt32(reader["RestaurantID"]);
                    restaurant.Name = reader["Name"].ToString();
                    restaurant.ImageUrl = reader["ImageUrl"].ToString();
                    restaurant.Rating = Convert.ToDouble(reader["Rating"]);
                    restaurant.Location = reader["Location"].ToString();
                    restaurant.LocationUrl = reader["LocationUrl"].ToString();
                }
                else
                {
                    reader.Close();
                    return null;
                }

                reader.Close();
            }

            return restaurant;
        }

        // Method to fetch menu items for a restaurant by ID
        public List<MenuItem> GetMenuItemsByRestaurantID(int restaurantID)
        {
            List<MenuItem> menuItems = new List<MenuItem>();
            string query = "SELECT * FROM Items WHERE RestaurantID = @RestaurantID";

            using (SqlConnection connection = new SqlConnection(connString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@RestaurantID", restaurantID);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    MenuItem menuItem = new MenuItem();
                    menuItem.ID = Convert.ToInt32(reader["ItemID"]);
                    menuItem.Name = reader["Name"].ToString();
                    menuItem.ImageUrl = reader["ImageUrl"].ToString();
                    menuItem.Description = reader["Description"].ToString();
                    menuItem.Price = Convert.ToDecimal(reader["Price"]).ToString("C", CultureInfo.CreateSpecificCulture("ur-PK"));
                    menuItems.Add(menuItem);
                }

                reader.Close();
            }

            return menuItems;
        }

        public DataTable GetOrders(string userEmail)
        {
            DataTable dataTable = new DataTable();
            string query = @"SELECT R.Name AS RestaurantName,
                                    O.OrderDate,
                                    O.Status,
                                    O.Total,
                                    (SELECT COUNT(*) FROM OrderItems WHERE OrderID = O.OrderID) AS Items
                                FROM Orders O
                                INNER JOIN Users U ON O.UserID = U.UserID
                                INNER JOIN Restaurants R ON O.RestaurantID = R.RestaurantID
                                WHERE U.Email = @UserEmail;
                            ";

            using (SqlConnection connection = new SqlConnection(connString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@UserEmail", userEmail);
                connection.Open();

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dataTable);
                }
            }

            return dataTable;
        }

        public void AddRestaurant(string name, string cuisineType, string location, decimal rating, string locationUrl, string imageUrl)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("AddRestaurant", connection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Name", name);
                    sqlCommand.Parameters.AddWithValue("@CuisineType", cuisineType);
                    sqlCommand.Parameters.AddWithValue("@Location", location);
                    sqlCommand.Parameters.AddWithValue("@Rating", rating);
                    sqlCommand.Parameters.AddWithValue("@LocationUrl", locationUrl);
                    sqlCommand.Parameters.AddWithValue("@ImageUrl", imageUrl);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        public void DeleteRestaurant(int restaurantID)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("DeleteRestaurant", connection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@RestaurantID", restaurantID);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        public DataTable GetItems()
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"SELECT i.ItemID as ID, r.Name AS RestaurantName, i.Name, i.Description, i.Price, i.Inventory, i.ImageUrl
                             FROM Items i
                             INNER JOIN Restaurants r ON i.RestaurantID = r.RestaurantID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            return dataTable;
        }

        public DataTable GetRandomItems(int count)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"SELECT i.ItemID as ID, r.Name AS RestaurantName, i.Name, i.Description, i.Price, i.Inventory, i.ImageUrl
                             FROM Items i
                             INNER JOIN Restaurants r ON i.RestaurantID = r.RestaurantID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }

            while(dataTable.Rows.Count > count)
            {
                dataTable.Rows.RemoveAt(new Random().Next(dataTable.Rows.Count - 1));
            }

            return dataTable;
        }

        public void CreateOrder(string userEmail)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("CreateOrderFromCart", connection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@UserEmail", userEmail);

                    //AddLoyaltyPoints(userID);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }

        public DataTable GetCartItems(string userEmail)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"SELECT i.ItemID AS ID, i.Name, i.Price, i.ImageUrl, c.Quantity
                                FROM Cart c
                                INNER JOIN Users u ON c.UserID = u.UserID
                                INNER JOIN Items i ON c.ItemID = i.ItemID
                                WHERE u.Email = @UserEmail;";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserEmail", userEmail);

                    connection.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            return dataTable;
        }

        public int IsUserAdmin(string userEmail)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"SELECT Admin
                                FROM Users u
                                WHERE u.Email = @UserEmail;";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserEmail", userEmail);

                    connection.Open();
                    return (int)command.ExecuteScalar();
                }
            }
        }

        public void AddCartItem(string userEmail, int itemId, int quantity)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string checkQuery = @"SELECT COUNT(*) FROM Cart WHERE UserID = (SELECT UserID FROM Users WHERE Email = @UserEmail) AND ItemID = @ItemID";
                string insertQuery = @"INSERT INTO Cart (UserID, ItemID, Quantity) VALUES ((SELECT UserID FROM Users WHERE Email = @UserEmail), @ItemID, @Quantity)";
                string updateQuery = @"UPDATE Cart SET Quantity = Quantity + @Quantity WHERE UserID = (SELECT UserID FROM Users WHERE Email = @UserEmail) AND ItemID = @ItemID";

                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@UserEmail", userEmail);
                    checkCommand.Parameters.AddWithValue("@ItemID", itemId);

                    connection.Open();
                    int existingCount = (int)checkCommand.ExecuteScalar();

                    if (existingCount > 0)
                    {
                        // If the record already exists, update the quantity
                        using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                        {
                            updateCommand.Parameters.AddWithValue("@UserEmail", userEmail);
                            updateCommand.Parameters.AddWithValue("@ItemID", itemId);
                            updateCommand.Parameters.AddWithValue("@Quantity", quantity);
                            updateCommand.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        // If the record doesn't exist, insert a new record
                        using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                        {
                            insertCommand.Parameters.AddWithValue("@UserEmail", userEmail);
                            insertCommand.Parameters.AddWithValue("@ItemID", itemId);
                            insertCommand.Parameters.AddWithValue("@Quantity", quantity);
                            insertCommand.ExecuteNonQuery();
                        }
                    }
                }
            }
        }


        public void ClearCart(string userEmail)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"DELETE FROM Cart WHERE UserID = (SELECT UserID FROM Users WHERE Email = @UserEmail)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserEmail", userEmail);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void AddItem(string restaurantName, string name, string description, decimal price, int inventory, string imageUrl)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"INSERT INTO Items (RestaurantID, Name, Description, Price, Inventory, ImageUrl)
                             VALUES ((SELECT RestaurantID FROM Restaurants WHERE Name = @RestaurantName), @Name, @Description, @Price, @Inventory, @ImageUrl)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@RestaurantName", restaurantName);
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@Description", description);
                    command.Parameters.AddWithValue("@Price", price);
                    command.Parameters.AddWithValue("@Inventory", inventory);
                    command.Parameters.AddWithValue("@ImageUrl", imageUrl);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void DeleteItem(int itemID)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = "DELETE FROM Items WHERE ItemID = @ItemID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ItemID", itemID);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void AddLoyaltyPoints(string userEmail)
        {
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"UPDATE Users
                                SET LoyaltyPoints = LoyaltyPoints + (
                                    SELECT SUM(0.01 * oi.Quantity * i.Price)
                                    FROM OrderItems oi
                                    INNER JOIN Items i ON oi.ItemID = i.ItemID
                                    INNER JOIN Orders o ON oi.OrderID = o.OrderID
                                    WHERE o.UserID = (SELECT UserID FROM Users WHERE Email = @UserEmail)
                                    GROUP BY o.UserID
                                )
                                WHERE Email = @UserEmail;";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserEmail", userEmail);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public int GetLoyaltyPoints(string Email)
        {
            int loyaltyPoints = 0;
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = "SELECT LoyaltyPoints FROM Users WHERE Email = @Email";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", Email);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        loyaltyPoints = Convert.ToInt32(result);
                    }
                }
            }
            return loyaltyPoints;
        }

        public DataTable AddNotification()
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(connString))
            {
                string query = @"SELECT NotisText FROM Notiifications;";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }
                }
            }
            return dataTable;
        }


        // Function to hash password using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in hashedBytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}