CREATE DATABASE OnlineBookstore;

CREATE TABLE Books (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

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

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books where Genre='Fiction';


-- 2) Find books published after the year 1950:
select * from books where Published_Year>1950;

-- 3) List all customers from the Canada:
select * from customers where Country='Canada';

-- 4) Show orders placed in November 2023:
select * from orders where Order_Date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_Stock from books;

-- 6) Find the details of the most expensive book:
select * from books order by Price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
-- select c.Customer_ID,c.Name,o.Quantity from customers c inner join orders o on c.Customer_ID=o.Customer_ID where o.Quantity>1;
select * from orders where Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where Total_Amount>20;

-- 9) List all genres available in the Books table:
select distinct Genre as Genres_available from books;

-- 10) Find the book with the lowest stock:
select * from books order by Stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as total_revenue from orders;


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select b.Genre,sum(o.Quantity) as total_books_for_each_genre from books b inner join orders o on b.Book_ID=o.Book_ID group by Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
select avg(Price) as avg_price from books where Genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
select c.Name,count(o.Order_ID) as no_of_orders from customers c inner join orders o on c.Customer_ID=o.Customer_ID group by Name having count(o.Order_ID)>1;

-- 4) Find the most frequently ordered book:
select b.Title,count(o.Order_ID) as no_of_orders from books b inner join orders o on b.Book_ID=o.Book_ID group by b.Title order by count(o.Order_ID) desc limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where Genre='Fantasy' order by Price Desc limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
select b.Author,sum(o.Quantity) as total_Quantity from books b join orders o on b.Book_ID=o.Book_ID group by Author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.City,o.Total_Amount from customers c join orders o on c.Customer_ID=o.Customer_ID where o.Total_Amount>30;

-- 8) Find the customer who spent the most on orders:
select c.Customer_ID,c.Name,sum(o.Total_Amount) as total_spent from customers c join orders o on c.Customer_ID=o.Customer_ID group by c.Customer_ID,c.Name order by sum(o.Total_Amount) desc limit 1; 


-- 9) Calculate the stock remaining after fulfilling all orders:
select b.Book_ID,b.Title,sum(b.Stock) - COALESCE(SUM(o.quantity),0) as remaining_books from books b left join orders o on b.Book_ID=o.Book_ID group by Book_ID,Title order by Book_ID;

