--1.Hiển thị Title, FirstName, MiddleName, LastName từ bảng Person.Person

SELECT Title, FirstName, MiddleName, LastName FROM Person.Person

--2.Hiển thị Title, FirstName, LastName như là một chuỗi nối nhằm dễ đọc và cung cấp tiêu đề cho cột tên (PersonName). 

SELECT Title + ' ' + FirstName + ' ' + LastName as PersonName FROM Person.Person

--3.Hiển thị chi tiết địa chỉ của tất cả các nhân viên trong bảng Person.Address 

SELECT AddressLine1 + ', ' + City FROM Person.Address

--4.Liệt kê tên của các thành phố từ bảng Person.Address và bỏ đi phần lặp lại. 

SELECT DISTINCT City FROM Person.Address

--5.Hiển thị chi tiết của 10 bảng ghi đầu tiên của bảng Person.Address.

SELECT TOP 10 * FROM Person.Address

--6.Hiển thị trung bình của tỷ giá (Rate) từ bảng HumanResources.EmployeePayHistory. 

SELECT AVG(Rate) FROM HumanResources.EmployeePayHistory

--7.Hiển thị tổng số nhân viên từ bảng HumanResources.Employee 

SELECT COUNT(BusinessEntityID) FROM HumanResources.Employee

--8.Đưa ra danh sách các khách hàng có trên 10 đơn hàng



SELECT * FROM Sales.Customer
WHERE CustomerID IN(SELECT CustomerID
					FROM Sales.SalesOrderHeader
					GROUP BY CustomerID
					HAVING COUNT(SalesOrderID) > 10)

--9.Đưa ra danh sách các mặt hàng chưa từng được đặt hàng

SELECT * FROM Production.Product
WHERE ProductID NOT IN (SELECT ProductID 
						FROM Purchasing.PurchaseOrderDetail
						GROUP BY ProductID)

--10.Sử dụng tool Execution Plan để giải thích các bước xử lý của các câu truy vấn trên



--11.Sử dụng index trên 1 bảng nào đấy, xem xét hiệu năng thực thi các câu truy vấn trên bảng đấy.

Select ListPrice from Production.Product
where ListPrice = 539.99

--Lệnh tạo index cho Product.ListPrice
CREATE NONCLUSTERED INDEX [AK_Product_ListPrice] ON [Production].[Product]
(
	[ListPrice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

--12.Sử dụng câu truy vấn 10, hãy viết ra 2 đến 3 câu lệnh SQL, đánh giá hiệu năng thực thi giữa các câu lệnh SQL trên

SELECT ListPrice FROM Production.Product
SELECT DISTINCT ListPrice FROM  Production.Product

--clone table
SELECT *INTO Sales.Customer_NoIndex FROM Sales.Customer
SELECT *INTO Sales.Customer_Clustered_Index FROM Sales.Customer
SELECT *INTO Sales.Customer_NonClustered_Index FROM Sales.Customer

--create index
CREATE INDEX Idx_Customer_Index_CustomerID ON Sales.Customer_NonClustered_Index(CustomerID)
CREATE CLUSTERED INDEX Idx_Customer_Index_CustomerID ON Sales.Customer_Clustered_Index(CustomerID)

--query
SELECT * FROM Sales.Customer_NoIndex where CustomerID = 100
SELECT * FROM Sales.Customer_NonClustered_Index where CustomerID = 100
SELECT * FROM Sales.Customer_Clustered_Index where CustomerID = 100