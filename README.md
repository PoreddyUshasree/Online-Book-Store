# 📚 Online Bookstore Data Analysis using SQL



## 📌 Overview  
This project analyzes an **Online Bookstore dataset** using SQL to uncover insights about customer behavior, sales trends, revenue generation, and inventory management. The queries help answer key business problems such as identifying top-selling books, customer purchase patterns, revenue performance, and stock availability.  

This project demonstrates my ability to design relational databases, write optimized SQL queries, and generate meaningful business insights.  


## 🎯 Objectives  

- Retrieve and analyze book, customer, and order data.  
- Track **sales trends** by genre, author, and time period.  
- Identify **top customers** and **best-selling books**.  
- Compute **total revenue** and **remaining stock**.  
- Analyze **customer demographics** (location, order history).  
- Provide **advanced insights** for business decision-making.  


## 🗂 Database Schema  

```sql
CREATE DATABASE OnlineBookstore;

-- Books Table
CREATE TABLE Books (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10, 2),
    Stock INT
);

-- Customers Table
CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- Orders Table
CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);
```


## 🛠 Business Problems & SQL Solutions

### 1. Retrieve all books in the "Fiction" genre
```sql
SELECT * FROM Books WHERE Genre = 'Fiction';
```

### 2. Find books published after 1950
```sql
SELECT * FROM Books WHERE Published_Year > 1950;
```

### 3. List all customers from Canada
```sql
SELECT * FROM Customers WHERE Country = 'Canada';
```

### 4. Show orders placed in November 2023
```sql
SELECT * FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';
```

### 5. Retrieve the total stock of books available
```sql
SELECT SUM(Stock) AS Total_Stock FROM Books;
```

### 6. Find the details of the most expensive book:
```sql
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;
```

### 7. Show customers who ordered more than 1 quantity of a book
```sql
SELECT * FROM Orders WHERE Quantity > 1;
```

### 8. Retrieve all orders where total amount > $20
```sql
SELECT * FROM Orders WHERE Total_Amount > 20;
```

### 9. List all genres available
```sql
SELECT DISTINCT Genre AS Genres_Available FROM Books;
```

### 10. Find the book with the lowest stock
```sql
SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;
```

### 11. Calculate total revenue generated
```sql
SELECT SUM(Total_Amount) AS total_revenue FROM Orders;
```

## 🔍 Advanced Analysis

### 1. Total books sold per genre
```sql
SELECT b.Genre, SUM(o.Quantity) AS total_books_for_each_genre
FROM Books b 
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY Genre;
```

### 2. Average price of Fantasy books
```sql
SELECT AVG(Price) AS avg_price 
FROM Books 
WHERE Genre = 'Fantasy';
```

### 3. Customers with at least 2 orders
```sql
SELECT c.Name, COUNT(o.Order_ID) AS no_of_orders
FROM Customers c 
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY Name
HAVING COUNT(o.Order_ID) > 1;
```

### 4. Most frequently ordered book
```sql
SELECT b.Title, COUNT(o.Order_ID) AS no_of_orders
FROM Books b 
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY no_of_orders DESC
LIMIT 1;
```

### 5. Top 3 expensive Fantasy books
```sql
SELECT * FROM Books 
WHERE Genre = 'Fantasy' 
ORDER BY Price DESC 
LIMIT 3;
```

### 6. Total quantity of books sold by each author
```sql
SELECT b.Author, SUM(o.Quantity) AS total_quantity
FROM Books b 
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY Author;
```

### 7. Cities where customers spent over $30
```sql
SELECT DISTINCT c.City, o.Total_Amount
FROM Customers c 
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;
```

### 8. Customer who spent the most
```sql
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS total_spent
FROM Customers c 
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY total_spent DESC
LIMIT 1;
```

### 9. Remaining stock after fulfilling all orders
```sql
SELECT b.Book_ID, b.Title, SUM(b.Stock) - COALESCE(SUM(o.Quantity), 0) AS remaining_books
FROM Books b 
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY b.Book_ID;
```

## 📊 Findings & Conclusion

- **Sales Trends**: Fiction and Fantasy genres are the most popular.  
- **Top Customers**: Some customers consistently place high-value orders, contributing most to revenue.  
- **Revenue Insights**: Significant revenue is generated from recurring customers and bulk orders.  
- **Inventory Management**: Identifying books with low stock helps prevent stockouts.  
- **Customer Demographics**: Cities with higher spending can be targeted for promotions.  
- **Authors**: Tracking sales by authors helps optimize marketing campaigns.  


## 👩‍💻 Author – Poreddy Ushasree  

This project is part of my portfolio to showcase **SQL skills** relevant for data analysis, business insights, and database management roles.  


