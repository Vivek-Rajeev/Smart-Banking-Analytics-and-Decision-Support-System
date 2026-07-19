-- Database: Smart Banking Analytics

Table: Customers
------------------------------------
CustomerID
CustomerName
Gender
Age
City
Occupation

Table: Accounts
------------------------------------
AccountID
CustomerID
AccountType
Balance
OpenDate

Table: Loans
------------------------------------
LoanID
CustomerID
LoanType
LoanAmount
LoanStatus

Table: Transactions
------------------------------------
TransactionID
CustomerID
Amount
TransactionDate
TransactionType
