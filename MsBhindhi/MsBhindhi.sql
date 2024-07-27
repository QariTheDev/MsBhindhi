USE MsBhindhi


-- Table: Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);

-- Table: Restaurants
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) NOT NULL,
    CuisineType VARCHAR(100),
    Location VARCHAR(255),
    Rating DECIMAL(3, 2)
);

-- Add LocationUrl column
ALTER TABLE Restaurants
ADD LocationUrl VARCHAR(1024);

-- Add ImageUrl column
ALTER TABLE Restaurants
ADD ImageUrl VARCHAR(1024);

-- Table: Items
CREATE TABLE Items (
    ItemID INT PRIMARY KEY IDENTITY,
    RestaurantID INT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(6, 2) NOT NULL,
    Inventory INT NOT NULL,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) ON DELETE CASCADE
);

ALTER TABLE Items
ADD ImageUrl VARCHAR(1024);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,
    UserID INT,
    RestaurantID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'placed',
    Total DECIMAL(8, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) ON DELETE CASCADE
);

CREATE TABLE OrderItems (
    OrderID INT,
    ItemID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE NO ACTION,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID) ON DELETE NO ACTION
);


-- Table: Feedback
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY IDENTITY,
    UserID INT,
    RestaurantID INT,
    Rating INT,
    Comment TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) ON DELETE CASCADE
);

-- Table: Coupons
CREATE TABLE Coupons (
    CouponID INT PRIMARY KEY IDENTITY,
    Code VARCHAR(20) UNIQUE NOT NULL,
    Discount DECIMAL(5, 2),
    ExpiryDate DATE
);

-- Table: LoyaltyPoints
CREATE TABLE LoyaltyPoints (
    UserID INT,
    Points INT,
    PRIMARY KEY (UserID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Table: Admins
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY IDENTITY,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL
);

CREATE TABLE Notiifications (
	NotisID INT PRIMARY KEY,
	NotisText VARCHAR(28)
);

CREATE TRIGGER NotifyOrderCreated
ON Orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OrderId INT;

    SELECT @OrderId = OrderID FROM inserted;

    INSERT INTO Notifications (NotisID, NotisText)
    VALUES (@OrderId, 'Order created with ID: ' + CAST(@OrderId AS VARCHAR(10)));
END;


CREATE PROCEDURE registerUser
    @Username VARCHAR(100),
    @Email VARCHAR(100),
    @Password VARCHAR(255),
    @PhoneNumber VARCHAR(20),
    @Address VARCHAR(255),
    @Result INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Users WHERE LOWER(Email) = LOWER(@Email))
    BEGIN
        INSERT INTO Users (Username, Email, Password, PhoneNumber, Address)
        VALUES (@Username, @Email, @Password, @PhoneNumber, @Address);
        SET @Result = 1; -- Success
    END
    ELSE
    BEGIN
        SET @Result = -1; -- User already exists
    END
END


CREATE PROCEDURE signInUser
    @Email VARCHAR(100),
    @Password VARCHAR(255),
    @UserEmail VARCHAR(100) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @UserEmail = ISNULL(Email, '')
    FROM Users
    WHERE Email = @Email AND Password = @Password;
END

CREATE PROCEDURE GetUserByEmail
    @Email VARCHAR(100)
AS
BEGIN
    SELECT UserID, Username, Password, Email, PhoneNumber, Address
    FROM Users
    WHERE Email = @Email;
END

CREATE PROCEDURE UpdateUserSettings
    @UserEmail VARCHAR(100),
    @FullName VARCHAR(100),
    @PhoneNumber VARCHAR(20),
    @Password VARCHAR(255),
    @Address VARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET 
        Username = @FullName,
        PhoneNumber = @PhoneNumber,
        Password = @Password,
        Address = @Address
    WHERE Email = @UserEmail;
END

-- Insert statement for Cheezious restaurant
INSERT INTO Restaurants (Name, CuisineType, Location, Rating, LocationUrl, ImageUrl)
VALUES ('Cheezious', NULL, 'F97R+R2W, Sector FF Dha Phase 4, Lahore, Punjab, Pakistan', 4.5, 'https://www.google.com/maps/place/Cheezious+-+DHA+Phase+4,+Lahore/@31.4646212,74.387495,17z/data=!3m1!4b1!4m6!3m5!1s0x391907752ae96157:0x865438e49891425f!8m2!3d31.4646212!4d74.3900699!16s%2Fg%2F11sk7hchlf?entry=ttu', 'https://i.imgur.com/VpbrmhH.jpeg');

INSERT INTO Items (RestaurantID, Name, Description, Price, Inventory, ImageUrl)
VALUES
    (1, 'Cheeseburger', 'Juicy beef patty topped with melted cheese, lettuce, tomato, and special sauce, served on a toasted bun.', 8.99, 50, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (1, 'Fries', 'Crispy golden fries served hot and seasoned to perfection.', 3.99, 100, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (1, 'Cheese Pizza', 'Classic cheese pizza with a thin crust and gooey mozzarella cheese.', 10.99, 30, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (1, 'Chicken Nuggets', 'Crispy breaded chicken nuggets served with your choice of dipping sauce.', 6.99, 40, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (1, 'Milkshake', 'Creamy vanilla milkshake made with real ice cream and topped with whipped cream.', 4.99, 20, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg');

-- Insert statement for Burger Lab restaurant
INSERT INTO Restaurants (Name, CuisineType, Location, Rating, LocationUrl, ImageUrl)
VALUES ('Burger Lab', NULL, '16M Abdul Haque Rd, Trade Centre Commercial Area Phase 2 Johar Town, Lahore, Punjab 54000, Pakistan', 4.0, 'https://www.google.com/maps/dir/31.4321498,74.2766182/16M+Abdul+Haque+Rd,+Trade+Centre+Commercial+Area+Phase+2+Johar+Town,+Lahore,+Punjab+54000/@31.4509248,74.2494631,14z/am=t/data=!4m9!4m8!1m1!4e1!1m5!1m1!1s0x3919035caa2d2f33:0x52107e7495873cf5!2m2!1d74.2649472!2d31.4672413?entry=ttu', 'https://i.imgur.com/o9AxxEf.jpeg');

INSERT INTO Items (RestaurantID, Name, Description, Price, Inventory, ImageUrl)
VALUES
    (8, 'Classic Burger', 'Juicy beef patty topped with lettuce, tomato, onion, and special sauce, served on a sesame seed bun.', 9.99, 50, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (8, 'Cheeseburger Deluxe', 'Classic burger with an extra layer of melted cheese, served with crispy fries.', 11.99, 40, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (8, 'Spicy Chicken Burger', 'Crispy breaded chicken fillet with spicy mayo, lettuce, and pickles, served on a brioche bun.', 10.99, 30, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (8, 'Vegetarian Burger', 'Grilled veggie patty topped with avocado, roasted red peppers, and hummus, served on a whole grain bun.', 8.99, 35, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (8, 'Mushroom Swiss Burger', 'Beef patty topped with sautéed mushrooms, melted Swiss cheese, and garlic aioli, served on a pretzel bun.', 12.99, 25, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg');


-- Insert statement for Novu restaurant
INSERT INTO Restaurants (Name, CuisineType, Location, Rating, LocationUrl, ImageUrl)
VALUES ('Novu', NULL, '942 J/2، Nazria-e Pakistan Road, Block J 2 Phase 2 Johar Town, Lahore, Punjab 54782', 4.0, 'https://www.google.com/maps/dir/31.4321498,74.2766182/942+J%2F2%D8%8C+Nazria-e+Pakistan+Road,+Block+J+2+Phase+2+Johar+Town,+Lahore,+Punjab+54782%E2%80%AD/@31.4540032,74.2719488,12z/data=!4m9!4m8!1m1!4e1!1m5!1m1!1s0x3919022ecfffffff:0xdb6c0e95299317bb!2m2!1d74.2504838!2d31.4680877?entry=ttu', 'https://i.imgur.com/ESacZ5U.jpeg');

INSERT INTO Items (RestaurantID, Name, Description, Price, Inventory, ImageUrl)
VALUES
    (9, 'Dragon Roll', 'A popular sushi roll made with shrimp tempura, avocado, and cucumber, topped with eel and avocado slices.', 14.99, 40, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (9, 'General Tso''s Chicken', 'Crispy chicken pieces tossed in a sweet and tangy sauce made with soy sauce, garlic, and chili peppers.', 12.99, 35, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (9, 'Szechuan Beef', 'Tender slices of beef stir-fried with bell peppers, onions, and Szechuan sauce, served with steamed rice.', 15.99, 30, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (9, 'Crunchy Mantis Shrimp', 'Deep-fried mantis shrimp coated in a crunchy batter, served with a spicy dipping sauce.', 18.99, 25, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (9, 'Silkworm Larvae Fried Rice', 'Fried rice cooked with silkworm larvae, mixed vegetables, and soy sauce, a delicacy in Chinese cuisine.', 13.99, 20, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg');


-- Insert statement for Forks n Knives restaurant
INSERT INTO Restaurants (Name, CuisineType, Location, Rating, LocationUrl, ImageUrl)
VALUES ('Forks N Knives Pizza Kitchen', NULL, 'Abdul Haque Rd, Block G Phase 1 Johar Town, Lahore, Punjab 54782, Pakistan', 4.0, 'https://www.google.com/maps/place/Forks+N+Knives+Pizza+Kitchen/@31.471952,74.2603263,15.41z/am=t/data=!4m20!1m13!4m12!1m4!2m2!1d74.2766182!2d31.4321498!4e1!1m6!1m2!1s0x3919035caa2d2f33:0x52107e7495873cf5!2s16M+Abdul+Haque+Rd,+Trade+Centre+Commercial+Area+Phase+2+Johar+Town,+Lahore,+Punjab+54000!2m2!1d74.2649472!2d31.4672413!3m5!1s0x391903c4a5ff9457:0x808b71cd2a828b62!8m2!3d31.4780408!4d74.2820225!16s%2Fg%2F11dzw7sxbv?entry=ttu', 'https://www.forks-n-knives.com/wp-content/uploads/2023/05/320474524_5907834682664182_8035640990782393030_n-3-1024x768.jpg');

INSERT INTO Items (RestaurantID, Name, Description, Price, Inventory, ImageUrl)
VALUES
    (10, 'Margherita Pizza', 'Classic Italian pizza topped with tomato sauce, fresh mozzarella cheese, basil leaves, and a drizzle of olive oil.', 9.99, 30, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (10, 'Pepperoni Pizza', 'Traditional pizza topped with marinara sauce, generous slices of pepperoni, and melted mozzarella cheese.', 11.99, 25, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (10, 'Vegetarian Supreme Pizza', 'Loaded with assorted vegetables such as bell peppers, onions, mushrooms, and olives, along with marinara sauce and mozzarella cheese.', 12.99, 20, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (10, 'BBQ Chicken Pizza', 'Barbecue sauce base topped with grilled chicken pieces, red onions, cilantro, and a blend of mozzarella and cheddar cheese.', 13.99, 15, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
    (10, 'Supreme Pizza', 'The ultimate pizza loaded with pepperoni, sausage, bell peppers, onions, mushrooms, and black olives, smothered in marinara sauce and mozzarella cheese.', 14.99, 10, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg');

-- Insert statement for Jinnah Hospital restaurant
INSERT INTO Restaurants (Name, CuisineType, Location, Rating, LocationUrl, ImageUrl)
VALUES ('Jinnah Hospital', NULL, 'Ahmed, Usmani Rd, Faisal Town, Lahore, Punjab 54550, Pakistan', 2.0, 'https://www.google.com/maps/place/Jinnah+Hospital/@31.4092117,74.1025746,11z/data=!4m10!1m2!2m1!1sjinnah+hospital!3m6!1s0x391903ee86619e19:0x1df20c73e9c6c4f3!8m2!3d31.484267!4d74.296861!15sCg9qaW5uYWggaG9zcGl0YWySAQhob3NwaXRhbOABAA!16s%2Fm%2F03d05zd?hl=en&entry=ttu', 'https://arynews.tv/wp-content/uploads/2020/09/Jinnah-Hospital.jpg');

INSERT INTO Items (RestaurantID, Name, Description, Price, Inventory, ImageUrl) 
VALUES 
	(11, 'Surgical Salad', 'A healthy mix of greens served in a sterile container with scalpel-shaped salad tongs.', 9.99, 50, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
	(11, 'Stethoscope Sandwich', 'A delicious sandwich filled with assorted meats and cheeses, served with a stethoscope-shaped breadstick.', 8.49, 40, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
	(11, 'Syringe Sliders', 'Miniature burgers served with fries, accompanied by ketchup and mustard in syringe-shaped condiment dispensers.', 7.99, 60, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
	(11, 'Band-Aid Brownies', 'Decadent chocolate brownies topped with creamy frosting and garnished with edible band-aid decorations.', 5.99, 30, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg'),
	(11, 'Speculum Spaghetti', 'Al dente spaghetti noodles tossed in a savory marinara sauce, served with garlic breadsticks shaped like medical speculums.', 10.49, 35, 'https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/d5/24/d5243019-e0fc-4b3c-8cdb-48e22f38bff2/istock-183380744.jpg');

UPDATE Items SET Price = Price + 0.99;

CREATE PROCEDURE GetRestaurants
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Restaurants;
END; 



--Selects--
SELECT * FROM Users
SELECT * FROM Restaurants
SELECT * FROM Items
SELECT * FROM Orders
SELECT * FROM OrderItems
SELECT * FROM Feedback
SELECT * FROM Coupons
SELECT * FROM LoyaltyPoints
SELECT * FROM Admins
SELECT * FROM Notiifications