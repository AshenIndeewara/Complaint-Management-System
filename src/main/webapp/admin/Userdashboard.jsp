<%--
  Created by IntelliJ IDEA.
  User: User_101
  Date: 6/18/2025
  Time: 10:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.complaintmanagment.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Admin Panel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #198754;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
            --card-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --admin-accent: #198754;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, var(--admin-accent) 0%, var(--primary-color) 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.5rem;
        }

        .stats-card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-left: 4px solid;
        }

        .stats-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        .stats-card.total-users {
            border-left-color: var(--secondary-color);
        }

        .stats-card.admin-users {
            border-left-color: var(--admin-accent);
        }

        .stats-card.employee-users {
            border-left-color: var(--success-color);
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0;
        }

        .stats-label {
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0;
        }

        .stats-icon {
            font-size: 2rem;
            opacity: 0.7;
        }

        .filter-card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
        }

        .table-card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .table thead th {
            background-color: var(--admin-accent);
            color: white;
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: background-color 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(25, 135, 84, 0.05);
        }

        .badge {
            font-size: 0.75rem;
            padding: 0.5em 0.75em;
        }

        .btn-action {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 6px;
            margin: 0 2px;
        }

        .search-box {
            position: relative;
        }

        .search-box .bi-search {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .search-box input {
            padding-left: 2.5rem;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .alert-custom {
            border-radius: 8px;
            border: none;
            box-shadow: var(--card-shadow);
        }

        .admin-badge {
            background: linear-gradient(135deg, var(--admin-accent) 0%, var(--primary-color) 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }

        .form-floating .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-floating .form-control:focus {
            border-color: var(--admin-accent);
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--admin-accent) 0%, var(--primary-color) 100%);
            border: none;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 135, 84, 0.3);
        }

        .role-badge {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-admin {
            background-color: #198754;
            color: white;
        }

        .role-employee {
            background-color: #28a745;
            color: white;
        }

        @media (max-width: 768px) {
            .stats-number {
                font-size: 2rem;
            }

            .table-responsive {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
<%
    List<User> users = (List<User>) request.getAttribute("userList");
    String message = (String) request.getAttribute("message");
    String errorMessage = (String) request.getAttribute("errorMessage");

    // Calculate statistics
    int totalUsers = 0;
    int adminCount = 0;
    int employeeCount = 0;

    if (users != null) {
        totalUsers = users.size();
        for (User user : users) {
            String role = user.getRole() != null ? user.getRole().toUpperCase() : "EMPLOYEE";
            switch (role) {
                case "ADMIN":
                    adminCount++;
                    break;
                case "EMPLOYEE":
                    employeeCount++;
                    break;
            }
        }
    }
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard">
            <i class="bi bi-people-fill me-2"></i>
            User Management System
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link btn btn-outline-light btn-sm me-2" href="dashboard">
                <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
            </a>
            <span class="admin-badge">
                    <i class="bi bi-shield-check me-1"></i>Admin Panel
                </span>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="page-header">
        <h2 class="fw-bold text-dark mb-1">User Management</h2>
        <p class="text-muted mb-0">Manage system users, roles, and permissions</p>
    </div>

    <!-- Success/Error Messages -->
    <% if (message != null && !message.trim().isEmpty()) { %>
    <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
    <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle me-2"></i>
        <%= errorMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-xl-4 col-md-6 mb-3">
            <div class="stats-card total-users p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="stats-number text-primary"><%= totalUsers %></p>
                        <p class="stats-label">Total Users</p>
                    </div>
                    <i class="bi bi-people stats-icon text-primary"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6 mb-3">
            <div class="stats-card admin-users p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="stats-number text-success"><%= adminCount %></p>
                        <p class="stats-label">Administrators</p>
                    </div>
                    <i class="bi bi-shield-check stats-icon text-success"></i>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6 mb-3">
            <div class="stats-card employee-users p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="stats-number text-success"><%= employeeCount %></p>
                        <p class="stats-label">Employees</p>
                    </div>
                    <i class="bi bi-person-badge stats-icon text-success"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Filters and Actions -->
    <div class="filter-card p-4">
        <div class="row align-items-center">
            <div class="col-md-4">
                <h5 class="mb-3 fw-semibold">
                    <i class="bi bi-funnel me-2"></i>Search & Filter
                </h5>
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" class="form-control" id="searchInput"
                           placeholder="Search users..." onkeyup="filterUsers()">
                </div>
            </div>
            <div class="col-md-4">
                <label for="roleFilter" class="form-label fw-semibold">Filter by Role</label>
                <select class="form-select" id="roleFilter" onchange="filterUsers()">
                    <option value="all">All Roles</option>
                    <option value="admin">Admin</option>
                    <option value="employee">Employee</option>
                </select>
            </div>
            <div class="col-md-2">
            </div>
            <div class="col-md-2 d-flex align-items-end">
                <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="bi bi-person-plus me-1"></i>Add User
                </button>
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="table-card">
        <div class="p-4 border-bottom">
            <h5 class="mb-0 fw-semibold">
                <i class="bi bi-table me-2"></i>User Management
            </h5>
        </div>
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="usersTableBody">
                <% if (users != null && !users.isEmpty()) {
                    for (User user : users) {
                        String role = user.getRole() != null ? user.getRole().toUpperCase() : "EMPLOYEE";

                        String roleBadgeClass = "";
                        switch (role) {
                            case "ADMIN":
                                roleBadgeClass = "role-admin";
                                break;
                            case "EMPLOYEE":
                            default:
                                roleBadgeClass = "role-employee";
                        }
                %>
                <tr>
                    <td><span class="fw-semibold">#<%= user.getId() %></span></td>
                    <td>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-person-fill me-2 text-muted"></i>
                            <%= user.getName() %>
                        </div>
                    </td>
                    <td><span class="badge role-badge <%= roleBadgeClass %>"><%= user.getRole() != null ? user.getRole() : "EMPLOYEE" %></span></td>
                    <td>
                        <a href="manageusers?action=edit&userid=<%= user.getId() %>&username=<%= user.getName() %>&role=<%= user.getRole() != null ? user.getRole() : "EMPLOYEE" %>"
                           class="btn btn-primary btn-action" title="Edit User">
                            <i class="bi bi-pencil-square"></i>
                        </a>
                        <% if (!role.equals("ADMIN") || adminCount > 1) { %>
                        <a href="manageusers?action=delete&userid=<%= user.getId() %>"
                           class="btn btn-danger btn-action" title="Delete User"
                           onclick="return confirm('Are you sure you want to delete user <%= user.getName() %>? This action cannot be undone.')">
                            <i class="bi bi-trash3"></i>
                        </a>
                        <% } %>
                        <% if (!role.equals("ADMIN")) { %>
                        <a href="manageusers?action=makeadmin&userid=<%= user.getId() %>"
                           class="btn btn-warning btn-action" title="Make Admin"
                           onclick="return confirm('Are you sure you want to make <%= user.getName() %> an administrator? This will grant them full system access.')">
                            <i class="bi bi-person-fill-gear"></i>
                        </a>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4" class="text-center py-5">
                        <i class="bi bi-people display-4 text-muted d-block mb-3"></i>
                        <h5 class="text-muted">No users found</h5>
                        <p class="text-muted mb-3">Start by adding your first user</p>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="bi bi-person-plus-fill me-1"></i>Add New User
                        </button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg, var(--admin-accent) 0%, var(--primary-color) 100%); color: white;">
                <h5 class="modal-title" id="addUserModalLabel">
                    <i class="bi bi-person-plus me-2"></i>Add New User
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="manageusers" method="post" id="addUserForm">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="addUsername" name="username"
                                       placeholder="Username" required pattern="[a-zA-Z0-9_]{3,20}"
                                       title="Username must be 3-20 characters long and contain only letters, numbers, and underscores">
                                <label for="addUsername">Username</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <select class="form-select" id="addRole" name="role" required>
                                    <option value="">Select Role</option>
                                    <option value="EMPLOYEE">Employee</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                                <label for="addRole">Role</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="addPassword" name="password"
                                       placeholder="Password" required minlength="8">
                                <label for="addPassword">Password</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-person-plus me-1"></i>Add User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg, var(--admin-accent) 0%, var(--primary-color) 100%); color: white;">
                <h5 class="modal-title" id="editUserModalLabel">
                    <i class="bi bi-pencil me-2"></i>Edit User
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="manageusers" method="post" id="editUserForm">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userid" id="editUserId">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="editUsername" name="username"
                                       placeholder="Username" required pattern="[a-zA-Z0-9_]{3,20}"
                                       title="Username must be 3-20 characters long and contain only letters, numbers, and underscores">
                                <label for="editUsername">Username</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <select class="form-select" id="editRole" name="role" required>
                                    <option value="EMPLOYEE">Employee</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                                <label for="editRole">Role</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="editPassword" name="password"
                                       placeholder="New Password (leave blank to keep current)" minlength="8">
                                <label for="editPassword">New Password (Optional)</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-lg me-1"></i>Update User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script>
    // Filter users function
    function filterUsers() {
        const searchInput = document.getElementById('searchInput').value.toLowerCase();
        const roleFilter = document.getElementById('roleFilter').value.toLowerCase();
        const tableBody = document.getElementById('usersTableBody');
        const rows = tableBody.getElementsByTagName('tr');

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const cells = row.getElementsByTagName('td');

            if (cells.length > 1) {
                const username = cells[1].textContent.toLowerCase();
                const role = cells[2].textContent.toLowerCase();

                const matchesSearch = username.includes(searchInput);
                const matchesRole = roleFilter === 'all' || role.includes(roleFilter);

                if (matchesSearch && matchesRole) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
    }

    // Check if we need to show edit modal based on URL parameters
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('action') === 'edit') {
            const userid = urlParams.get('userid');
            const username = urlParams.get('username');
            const role = urlParams.get('role');

            if (userid && username && role) {
                document.getElementById('editUserId').value = userid;
                document.getElementById('editUsername').value = username;
                document.getElementById('editRole').value = role;
                document.getElementById('editPassword').value = '';

                const modal = new bootstrap.Modal(document.getElementById('editUserModal'));
                modal.show();
            }
        }
    };
</script>
</body>
</html>