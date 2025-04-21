# 📚 Library Management System using MYSQL

This project demonstrates the creation and management of a **Library Management System** using structured query language (**MYSQL**). The database simulates a real-time library scenario where books, borrowers, library branches, publishers, and loan data are efficiently stored and managed.

---

## 🧠 Project Objective

To design and implement a **relational database** for a library that can:
- Store book, author, publisher, and borrower information.
- Track book copies in different branches.
- Manage the borrowing and returning of books.
- Enable insightful reporting using SQL queries.

---

## 📐 ER Diagram (Conceptual)

The system is based on the following entities:

- **Book**
- **Author**
- **Publisher**
- **Library Branch**
- **Book Copies**
- **Book Loans**
- **Borrower**

Relationships:
- Each book is published by one publisher.
- A book can have multiple authors.
- A library branch can have multiple copies of the same book.
- Borrowers can borrow books from any branch.

---

## 🗃️ Database Name: `library_data`

### 🔧 Tables & Attributes

#### 1. `tbl_publisher`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| PublisherName | VARCHAR | Primary Key |
| PublisherAddress | VARCHAR | Address |
| PublisherPhone | VARCHAR | Contact |

#### 2. `tbl_book`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| BookID | INT | Primary Key |
| Title | VARCHAR | Title of Book |
| PublisherName | VARCHAR | Foreign Key from `tbl_publisher` |

#### 3. `tbl_book_authors`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| BookID | INT | Foreign Key from `tbl_book` |
| AuthorName | VARCHAR | Name of Author |

#### 4. `tbl_library_branch`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| BranchID | INT | Primary Key |
| BranchName | VARCHAR | Name of Branch |
| BranchAddress | VARCHAR | Address |

#### 5. `tbl_book_copies`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| BookID | INT | Foreign Key |
| BranchID | INT | Foreign Key |
| No_Of_Copies | INT | Number of Copies |

#### 6. `tbl_borrower`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| CardNo | INT | Primary Key |
| BorrowerName | VARCHAR | Name |
| BorrowerAddress | VARCHAR | Address |
| BorrowerPhone | VARCHAR | Contact |

#### 7. `tbl_book_loans`
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| BookID | INT | Foreign Key |
| BranchID | INT | Foreign Key |
| CardNo | INT | Foreign Key |
| DateOut | VARCHAR | Date Book Taken |
| DueDate | VARCHAR | Due Date for Return |

---

## 🔍 Important SQL Queries

Here are some example queries solved in this project:

1️⃣ **Find how many copies of "The Lost Tribe" are available in the Sharpstown branch.**  
2️⃣ **Find how many copies of "The Lost Tribe" are in all branches.**  
3️⃣ **Find all borrowers who haven’t borrowed any books.**  
4️⃣ **Find the books issued from "Sharpstown" branch with due date 2/3/18.**  
5️⃣ **Branch-wise count of issued books.**  
6️⃣ **Find borrowers who borrowed more than 5 books.**  
7️⃣ **List books written by Stephen King along with their available copies in "Central" branch.**

_All queries use joins, subqueries, and aggregate functions._

---

## 💡 Key Learnings

- Designing relational databases with **normalized structure** (3NF)
- Working with **Primary and Foreign Keys**
- Writing **complex queries using Joins, Group By, Having**
- Applying **real-time data constraints and integrity**
- Understanding **data relationships in libraries**

---

## ⚙️ Tools Used

- MySQL (Workbench or CLI)
- GitHub for version control

---

## 🧪 Sample Output Screens

> 📸 Add screenshots of your SQL query outputs or console logs here for visual demonstration.

---

## 📌 Notes

- This project is **beginner-friendly** and designed for academic learning and practice.
- Sample data is used to mimic real-world library records.
- Date formats are in `VARCHAR` for simplicity, but can be improved using `DATE` data type.

---

## 👨‍💻 Developed By

**Kathi Vishnuvardhan Reddy**  
Intern - Data Science with GenAI @ Innomatics Research Labs  

---

## 📎 License

This project is open-source and free to use for learning purposes.

---

