-- PART ONE

-- 1. List all countries in South America.
SELECT Name FROM country WHERE Region = "South America";

-- 2. Find the population of 'Germany'.
SELECT Name, Population FROM country WHERE Code = "DEU";

-- 3. Retrieve all cities in the country 'Japan'.
SELECT Name FROM city WHERE CountryCode = "JPN";

-- 4. Find the 3 most populated countries in the 'Africa' region.
SELECT Name, Population FROM country 
WHERE Region = "Eastern Africa" ORDER BY Population DESC LIMIT 3;

-- 5. Retrieve the country and its life expectancy where the population is between 1 and 5 million.
SELECT Name, LifeExpectancy FROM country 
WHERE Population < 5000000 AND Population > 1000000;

-- 6. List countries with an official language of 'French'.
SELECT Name FROM country 
JOIN countrylanguage ON country.code = countrylanguage.CountryCode 
WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T";

-- 7. Retrieve all album titles by the artist 'AC/DC'.
SELECT Title FROM Album 
WHERE ArtistID = (SELECT ArtistID FROM Artist WHERE Name = "AC/DC");

-- 8. Find the name and email of customers located in 'Brazil'.
SELECT FirstName, LastName, Email FROM Customer 
WHERE Country = "Brazil";

-- 9. List all playlists in the database.
SELECT Name FROM Playlist;

-- 10. Find the total number of tracks in the 'Rock' genre.
SELECT Genre.Name, COUNT(Track.TrackID) AS TrackCount FROM Genre 
JOIN Track ON Track.GenreID = Genre.GenreId WHERE Genre.Name = "Rock";

-- 11. List all employees who report to 'Nancy Edwards'.
SELECT LastName, FirstName FROM Employee WHERE ReportsTo = 
(SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards');

-- 12. Calculate the total sales per customer by summing the total amount in invoices.
SELECT FirstName, LastName, SUM(Invoice.Total) FROM Customer 
JOIN Invoice ON Customer.CustomerID = Invoice.CustomerID 
GROUP BY Customer.CustomerID;

-- PART TWO

-- 2. **Create the Tables:** Write SQL statements to create the tables for your database. Ensure that each table has a primary key and relationships where appropriate. 
CREATE TABLE Items(ItemID int NOT NULL AUTO_INCREMENT, Item varchar(60) NOT NULL, UnitCost real, PRIMARY KEY(ItemID) );
CREATE TABLE Invoice(InvoiceID int NOT NULL AUTO_INCREMENT,  DateSale date, PaymentMethod varchar(60), Total real, PRIMARY KEY(InvoiceID));
CREATE TABLE InvoiceLine(InvoiceLineID int NOT NULL AUTO_INCREMENT, InvoiceID int NOT NULL, ItemID int NOT NULL, Quantity int, FOREIGN KEY (ItemID) REFERENCES Items(ItemID), FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID), PRIMARY KEY(InvoiceLineID));

-- 3. **Insert Data:** Insert at least 5 rows of data into each of the tables you created.
INSERT INTO Items (Item, UnitCost) VALUES ("Hoodie", 59.99), ("Sweatpants", 24.99), ("T-Shirt", 34.99), ("Hat", 19.99), ("Blanket", 19.99);
INSERT INTO InvoiceLine(InvoiceID, ItemID, Quantity) VALUES (1, 1, 2), (1, 2, 1), (1, 4, 1), (2, 5, 2), (3, 3, 3), (4, 1, 1), (5, 4, 2);
INSERT INTO Invoice (DateSale, Total, PaymentMethod) VALUES (DATE '2015-12-17', 164.96, "Card"), (DATE '2015-12-17', 39.98, "Card"), (DATE '2015-12-18', 104.97, "Cash"), (DATE '2015-12-19', 59.99, "Check"), (DATE '2015-12-21', 39.98, "Card");

-- 4. **Write Queries:** Write at least 3 queries to extract data from your new database.
-- Calculate the total value of sales in the database
SELECT SUM(Total) AS "Total Sales" FROM Invoice;

-- Find the count of each payment method
SELECT PaymentMethod, COUNT(PaymentMethod) FROM Invoice GROUP BY PaymentMethod;

-- Calculate quantity of sales of each item
SELECT Item, SUM(Quantity) FROM Items JOIN InvoiceLine ON InvoiceLine.ItemID = Items.ItemID GROUP BY Items.ItemID;
