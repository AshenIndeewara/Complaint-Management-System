
# Complaint Management System - JSP Based (Jakarta EE Project 2025)

## 🔎 Overview
A web-based Complaint Management System (CMS) developed using JSP and Jakarta EE technologies. The system allows municipal employees to submit and manage complaints, while administrators can monitor, update, and resolve them. 

This project strictly uses synchronous HTTP form submissions (GET/POST) with **no AJAX** and follows the **MVC architecture** using JSP, Servlets, JavaBeans, and DAOs.

## 💡 Features

### 🧑 Employee
- Login with secure bcrypt-encrypted credentials
- Submit a new complaint
- View personal complaints
- Edit or delete personal complaints (if status is not "RESOLVED")

### 🛠️ Admin
- Login with secure bcrypt-encrypted credentials
- View all submitted complaints
- Update complaint status and add remarks
- Delete any complaint
- Manage all users:
  - View user list
  - Change user roles (EMPLOYEE / ADMIN)
  - Update user passwords
  - Delete users

## 🔐 Authentication & Security
- Passwords are securely stored using **bcrypt hashing**
- Session-based authentication
- Role-based access control (Admin & Employee)

## 🧱 Technology Stack
- **Frontend**: JSP, HTML, CSS (Bootstrap), JavaScript (only for client-side validation)
- **Backend**: Jakarta EE (Servlets), JavaBeans, DBCP Connection Pooling
- **Database**: MySQL
- **Deployment**: Apache Tomcat
- **Password Security**: bcrypt hashing via `org.mindrot.jbcrypt.BCrypt`

## 🗂️ Project Structure

```
/src
  /controller     --> Servlets (e.g., LoginServlet, ComplaintServlet)
  /dao            --> DAO classes for DB operations
  /model          --> JavaBeans (User, Complaint)
  /util           --> Utilities like DataSource.java
  /dto            --> Data Transfer Objects (if needed)

/web
  /jsp            --> JSP views (login.jsp, dashboard.jsp, etc.)

/db
  schema.sql      --> MySQL schema dump

README.md
```

## 🛠️ Setup Guide

1. **Clone the repository**:
   ```bash
   git clone https://github.com/AshenIndeewara/Complaint-Management-System.git
   ```

2. **Database Setup**:
   - Create a MySQL database (e.g., `cms`)
   - Import the SQL dump:
     ```sql
     SOURCE db/schema.sql;
     ```

3. **Configure DB credentials**:
   - Update `DBCPDataSource.java` with your DB URL, username, and password.

4. **Run on Apache Tomcat**:
   - Import project into your IDE
   - Deploy on Tomcat server
   - Visit: `http://localhost:8080/cms/`


The demo video includes:
- System features (Login, Complaint Flow, User Management)
- Architecture overview (MVC)
- Explanation of form-based GET/POST flows

## 🛡️ Academic Integrity

This project is 100% original and developed individually, as per the IJSE academic integrity policy.
