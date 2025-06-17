<%@ page import="lk.ijse.complaintmanagment.model.Complain" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.complaintmanagment.dto.StatusCount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%
    List<Complain> complaints = (List<Complain>) request.getAttribute("complaintList");
    String message = (String) request.getAttribute("message");
    StatusCount statusCount = (StatusCount) request.getAttribute("statusCount");
    int id = 0;
%>

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">
                <i class="fas fa-clipboard-list me-2"></i>
                Complaint Management System
            </span>
        <div class="d-flex">
            <a href="addComplaint.jsp" class="btn btn-light me-2">
                <i class="fas fa-plus me-1"></i>Add Complaint
            </a>
            <a href="logout" class="btn btn-light me-2">
                <i class="fas fa-sign-out-alt me-1"></i>Logout
            </a>
            <span class="badge bg-secondary fs-6 d-flex align-items-center">
                    <i class="fas fa-user-shield me-1"></i>Employee Panel
                </span>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4">Dashboard</h2>

            <!-- Success Message -->
            <% if (message != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i><%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-warning">
                        <div class="card-body">
                            <i class="fas fa-clock text-warning fa-2x mb-2"></i>
                            <h3 class="card-title text-warning"><%= statusCount.getPENDING() %></h3>
                            <p class="card-text text-muted">Pending</p>
                        </div>
          zzzzz          </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-info">
                        <div class="card-body">
                            <i class="fas fa-spinner text-info fa-2x mb-2"></i>
                            <h3 class="card-title text-info"><%= statusCount.getIN_PROGRESS() %></h3>
                            <p class="card-text text-muted">In Progress</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-success">
                        <div class="card-body">
                            <i class="fas fa-check-circle text-success fa-2x mb-2"></i>
                            <h3 class="card-title text-success"><%= statusCount.getRESOLVED() %></h3>
                            <p class="card-text text-muted">Resolved</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-primary">
                        <div class="card-body">
                            <i class="fas fa-list text-primary fa-2x mb-2"></i>
                            <h3 class="card-title text-primary"><%= statusCount.getTotalCount() %></h3>
                            <p class="card-text text-muted">Total</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-search me-2"></i>Search Complaints
                    </h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-search"></i>
                                    </span>
                                <input type="text" id="searchInput" class="form-control"
                                       placeholder="Search complaints..." onkeyup="filterComplaints()">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Complaints Table -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <i class="fas fa-table me-2"></i>Complaints Management
                    </h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Created By</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="complaintsTableBody">
                            <% if (complaints != null && !complaints.isEmpty()) {
                                for (Complain c : complaints) { %>
                            <tr>
                                <% id++; %>
                                <td><%= id %></td>
                                <td><%= c.getTitle() %></td>
                                <td><%= c.getDescription() %></td>
                                <td>
                                    <% String status = c.getStatus().toLowerCase();
                                        String badgeClass = "secondary";
                                        if (status.equals("pending")) badgeClass = "warning";
                                        else if (status.equals("in-progress")) badgeClass = "info";
                                        else if (status.equals("resolved")) badgeClass = "success"; %>
                                    <span class="badge bg-<%= badgeClass %>"><%= c.getStatus() %></span>
                                </td>
                                <td><%= c.getCreated_at() %></td>
                                <td>
                                    <a href="addComplaint?complainID=<%= c.getId() %>"
                                       class="btn btn-primary btn-sm me-1">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <i class="fas fa-inbox fa-2x mb-2"></i>
                                    <br>No complaints found.
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    function filterComplaints() {
        const searchInput = document.getElementById('searchInput').value.toLowerCase();
        const tableBody = document.getElementById('complaintsTableBody');
        const rows = tableBody.getElementsByTagName('tr');

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const cells = row.getElementsByTagName('td');
            let found = false;

            for (let j = 0; j < cells.length - 1; j++) {
                if (cells[j].textContent.toLowerCase().includes(searchInput)) {
                    found = true;
                    break;
                }
            }
            row.style.display = found ? '' : 'none';
        }
    }
</script>
</body>
</html>