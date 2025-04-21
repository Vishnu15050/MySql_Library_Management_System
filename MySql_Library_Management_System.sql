create database library_data;
use library_data;
-- creating table publisher
create table tbl_publisher(
publisher_PublisherName varchar(255) primary key not null,
publisher_PublisherAddress varchar(255) not null,
publisher_PublisherPhone varchar(20) not null);

select * from tbl_publisher;


-- creating table borrower
create table tbl_borrower(
borrower_CardNo int primary key not null,
borrower_BorrowerName varchar(255),
borrower_BorrowerAddress varchar(255),
borrower_BorrowerPhone varchar(20));

select * from tbl_borrower;

-- creating library branch table
create table tbl_library_branch(
library_branch_BranchID int primary key,
library_branch_BranchName  varchar(20),
library_branch_BranchAddress varchar(255));

select * from tbl_library_branch;

-- creating books table
create table tbl_book(
book_BookID int primary key,
book_Title varchar(255),
book_PublisherName  varchar(255),
foreign key (book_PublisherName) references tbl_publisher(publisher_PublisherName));

select * from tbl_book;

-- creating authors table
create table tbl_book_authors(
book_authors_BookID int,
book_authors_AuthorName varchar(255),
foreign key (book_authors_BookID) references tbl_book(book_BookID));

select * from tbl_book_authors;


-- creating book copies table
create table tbl_book_copies(
book_copies_BookID int,
book_copies_BranchID int,
book_copies_No_Of_Copies int,
foreign key (book_copies_BranchID) references tbl_library_branch(library_branch_BranchID));

select * from tbl_book_copies;

-- creating loans book table
create table tbl_book_loans(
book_loans_BookID int,
book_loans_BranchID int,
book_loans_CardNo int,
book_loans_DateOut varchar(255),
book_loans_DueDate varchar(255),
foreign key (book_loans_BookID) references tbl_book(book_BookID),
foreign key (book_loans_BranchID) references tbl_library_branch(library_branch_BranchID),
foreign key (book_loans_CardNo) references tbl_borrower(borrower_CardNo));


/*

1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?
3. Retrieve the names of all borrowers who do not have any books checked out.
4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 
5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
7. For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

*/


use library_data;

-- 1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

select tlb.library_branch_branchname as branch_name,tb.book_title as title_book,book_copies_no_of_copies as copies_count
from tbl_book_copies as tbc
join tbl_book as tb
on tb.book_bookid=tbc.book_copies_bookid
join tbl_library_branch as tlb
on tlb.library_branch_branchid=tbc.book_copies_branchid
where tb.book_title='the lost tribe' 
and tlb.library_branch_branchname='sharpstown';


-- 2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select tlb.library_branch_branchname as branch_name,tb.book_title as title_book,book_copies_no_of_copies as copies_count
from tbl_book_copies as tbc
join tbl_book as tb
on tb.book_bookid=tbc.book_copies_bookid
join tbl_library_branch as tlb
on tlb.library_branch_branchid=tbc.book_copies_branchid
where tb.book_title='the lost tribe';

-- 3.  Retrieve the names of all borrowers who do not have any books checked out.
select tbo.borrower_borrowername
from tbl_borrower as tbo
left join tbl_book_loans as tbl
on tbo.borrower_cardno=tbl.book_loans_cardno
where tbl.book_loans_cardno is null;

-- 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 
select tlb.library_branch_branchname as branch_name,tb.book_title,tbo.borrower_borrowername as borrow_name,tbo.borrower_borroweraddress as borrow_addr,tbl.book_loans_duedate as duedate
from tbl_library_branch as tlb
join tbl_book_loans as tbl
on tlb.library_branch_branchid=tbl.book_loans_branchid
join tbl_borrower as tbo
on tbo.borrower_cardno=tbl.book_loans_cardno
join tbl_book as tb
on tb.book_bookid=tbl.book_loans_bookid
where tlb.library_branch_branchname='sharpstown'
and tbl.book_loans_duedate='2/3/18';

-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

select tlb.library_branch_branchname as branch_name ,count(tbl.book_loans_dateout) as booksloaned_out,sum(tbc.book_copies_no_of_copies) as copies_number
from tbl_library_branch as tlb
join tbl_book_loans as tbl
on tlb.library_branch_branchid=tbl.book_loans_branchid
join tbl_book_copies as tbc
on tlb.library_branch_branchid=tbc.book_copies_branchid
group by tlb.library_branch_branchname;

-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
select tbo.borrower_borrowername  as borrower_name,tbo.borrower_borroweraddress as borrower_address,count(tbl.book_loans_dateout) as checked_out,sum(tbc.book_copies_no_of_copies) as numbercopies
from tbl_borrower as tbo
join tbl_book_loans as tbl
on tbo.borrower_cardno=tbl.book_loans_cardno
join tbl_book_copies as tbc
on tbc.book_copies_bookid=tbl.book_loans_bookid
group by tbo.borrower_borrowername ,tbo.borrower_borroweraddress
having count(tbl.book_loans_dateout)>5;

-- 7. For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
select tba.book_authors_authorname,tb.book_title,tbc.book_copies_no_of_copies,tlb.library_branch_branchname
from tbl_book_authors as tba
join tbl_book as tb
on tba.book_authors_bookid=tb.book_bookid
join tbl_book_copies as tbc
on tb.book_bookid=tbc.book_copies_bookid
join tbl_library_branch as tlb
on tlb.library_branch_branchid=tbc.book_copies_branchid
where tba.book_authors_authorname='stephen king'
and tlb.library_branch_branchname='central';

select * from Tbl_book;

use library_data;

select* from tbl_book;
select* from tbl_book_authors;
select* from tbl_book_copies;
select* from tbl_book_loans;
select* from tbl_borrower;
select* from tbl_library_branch;
select * from tbl_publisher;

SELECT COUNT(*) FROM tbl_book;
SELECT COUNT(*) FROM tbl_borrower;

use library_data;

select * from tbl_book;

