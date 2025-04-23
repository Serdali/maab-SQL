--1.1 Define the following terms: data, database, relational database, and table.
--Data: Data refers to raw facts, figures, or information that can be stored, processed, and analyzed. It can be in the form of numbers, text, images, audio, or any other format that represents a piece of information.

--Database: A database is an electronically stored, systematic collection of data that can include words, numbers, images, videos, and other types of files. A database is usually controlled by a DBMS.

--Relational Database: A relational database defines database relationships in the form of tables. The tables are related to each other - based on data common to each.

--Table: In a relational database, a table is a structured set of data organized into rows and columns. Tables are related to each other through keys (e.g., primary keys and foreign keys) to establish relationships.

--1.2 List five key features of SQL Server.
--High Performance & Scalability, Advanced Security, Business Intelligence & Analytics, High Availability & Disaster Recovery, Cloud Integration & Hybrid Support

--1.3 What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--1) Windows Authentication (Integrated Security)
---Uses the Windows user credentials of the logged-in user to authenticate with SQL Server.
---Relies on Active Directory (AD) or local Windows accounts for identity management.
---More secure because it avoids storing passwords in connection strings and leverages Windows security policies
--2) SQL Server Authentication
---Requires a username and password explicitly created in SQL Server (not tied to a Windows account).
---Used when Windows Authentication isn’t feasible
---Passwords are stored in SQL Server and must be managed securely

--1.4 Create a new database in SSMS named SchoolDB.
CREATE DATABASE SchoolDB

--1.5 Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
CREATE TABLE Students (
	StudentID (INT, PRIMARY KEY),
	Name (VARCHAR(50)),
	Age (INT)
)

--1.6 Describe the differences between SQL Server, SSMS, and SQL.
--SQL Server is a relational database management system (RDBMS) developed by Microsoft. It is used to store, retrieve, and manage data for enterprise-level applications.
--SQL Server Management Studio (SSMS) is an integrated environment for managing any SQL infrastructure. Use SSMS to access, configure, manage, administer, and develop all components of SQL Server
--Structured query language (SQL) is a programming language for storing and processing information in a relational database. 

--1.7 Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--DQL - Data Query Language. Commands SELECT
--DML - Data Manipulation Language. Commands INSERT, UPDATE, DELETE
--DDL - Data Definition Language. Commands CREATE, DROP, ALTER, TRUNCATE, RENAME
--DCL - Data Control Language. Commands GRAND, REVOKE, DENY
--TCL - Transaction Control Language. Commands COMMIT, SAVEPOINT, ROLLBACK

--1.8 Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID, Name, Age)
VALUES
	(101, 'John', 31),
	(102, 'Alex', 28),
	(103, 'Craig', 35)

--1.9 Create a backup of your SchoolDB database and restore it. (write its steps to submit)
