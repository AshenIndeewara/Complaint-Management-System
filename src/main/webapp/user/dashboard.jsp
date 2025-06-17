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
    <style>
        .modal-header {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }
        .form-floating .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="bg-light">
<%
    List<Complain> complaints = (List<Complain>) request.getAttribute("complaintList");
    String message = (String) request.getAttribute("message");
    StatusCount statusCount = (StatusCount) request.getAttribute("statusCount");
%>

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h1">
            <i class="fas fa-clipboard-list me-2"></i>
            Complaint Management System
        </span>
        <div class="d-flex">
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
                            <h3 class="card-title text-warning"><%= statusCount != null ? statusCount.getPENDING() : 0 %></h3>
                            <p class="card-text text-muted">Pending</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-info">
                        <div class="card-body">
                            <i class="fas fa-spinner text-info fa-2x mb-2"></i>
                            <h3 class="card-title text-info"><%= statusCount != null ? statusCount.getIN_PROGRESS() : 0 %></h3>
                            <p class="card-text text-muted">In Progress</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-success">
                        <div class="card-body">
                            <i class="fas fa-check-circle text-success fa-2x mb-2"></i>
                            <h3 class="card-title text-success"><%= statusCount != null ? statusCount.getRESOLVED() : 0 %></h3>
                            <p class="card-text text-muted">Resolved</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card text-center border-primary">
                        <div class="card-body">
                            <i class="fas fa-list text-primary fa-2x mb-2"></i>
                            <h3 class="card-title text-primary"><%= statusCount != null ? statusCount.getTotalCount() : 0 %></h3>
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
                        <div class="col-md-6 d-flex justify-content-end">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addComplaintModal">
                                <i class="fas fa-plus me-1"></i>Add New Complaint
                            </button>
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
                                <th>Subject</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Incident Date</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="complaintsTableBody">
                            <% if (complaints != null && !complaints.isEmpty()) {
                                for (Complain c : complaints) { %>
                            <tr>
                                <td>#<%= c.getId() %></td>
                                <td><%= c.getTitle() != null ? c.getTitle() : "" %></td>
                                <td>
                                    <%
                                        String description = c.getDescription();
                                        if (description != null && description.length() > 50) {
                                            description = description.substring(0, 50) + "...";
                                        } else if (description == null) {
                                            description = "";
                                        }
                                    %>
                                    <%= description %>
                                </td>
                                <td>
                                    <% String status = c.getStatus() != null ? c.getStatus().toLowerCase() : "";
                                        String badgeClass = "secondary";
                                        if (status.equals("pending")) badgeClass = "warning";
                                        else if (status.equals("in-progress") || status.equals("in_progress")) badgeClass = "info";
                                        else if (status.equals("resolved")) badgeClass = "success"; %>
                                    <span class="badge bg-<%= badgeClass %>"><%= c.getStatus() != null ? c.getStatus() : "" %></span>
                                </td>
                                <td><%= c.getCreated_at() != null ? c.getCreated_at() : "" %></td>
                                <td>
                                    <button class="btn btn-primary btn-sm me-1"
                                            onclick="editComplaint('<%= c.getId() %>', '<%= escapeJs(c.getTitle()) %>', '<%= escapeJs(c.getDescription()) %>', '<%= c.getStatus() != null ? c.getStatus() : "" %>', '<%= c.getCreated_at() != null ? c.getCreated_at() : "" %>', '<%= escapeJs(c.getRemarks()) %>')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn btn-info btn-sm"
                                            onclick="viewComplaint('<%= c.getId() %>', '<%= escapeJs(c.getTitle()) %>', '<%= escapeJs(c.getDescription()) %>', '<%= c.getStatus() != null ? c.getStatus() : "" %>', '<%= c.getCreated_at() != null ? c.getCreated_at() : "" %>', '<%= escapeJs(c.getRemarks()) %>')">
                                        <i class="fas fa-eye"></i> View
                                    </button>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
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

<!-- Add Complaint Modal -->
<div class="modal fade" id="addComplaintModal" tabindex="-1" aria-labelledby="addComplaintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addComplaintModalLabel">
                    <i class="fas fa-plus me-2"></i>Add New Complaint
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="addComplaint" method="post" id="addComplaintForm">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="subject" name="subject"
                                       placeholder="Subject" required>
                                <label for="subject">Subject</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="date" class="form-control" id="incidentDate" name="incidentDate"
                                       placeholder="Incident Date" required>
                                <label for="incidentDate">Incident Date</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <select class="form-select" id="status" name="status">
                                    <option value="PENDING" selected>Pending</option>
                                    <option value="IN_PROGRESS">In Progress</option>
                                    <option value="RESOLVED">Resolved</option>
                                </select>
                                <label for="status">Status</label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="form-floating">
                            <textarea class="form-control" id="description" name="description"
                                      placeholder="Description" style="height: 120px" required></textarea>
                            <label for="description">Description</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>Save Complaint
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Complaint Modal -->
<div class="modal fade" id="editComplaintModal" tabindex="-1" aria-labelledby="editComplaintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editComplaintModalLabel">
                    <i class="fas fa-edit me-2"></i>Edit Complaint
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="addComplaint" method="post" id="editComplaintForm">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="complainID" id="editComplainID">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="editSubject" name="subject"
                                       placeholder="Subject" required>
                                <label for="editSubject">Subject</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="date" class="form-control" id="editIncidentDate" name="incidentDate"
                                       placeholder="Incident Date" required>
                                <label for="editIncidentDate">Incident Date</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <div class="form-floating">
                                <select class="form-select" id="editStatus" name="status">
                                    <option value="PENDING">Pending</option>
                                    <option value="IN_PROGRESS">In Progress</option>
                                    <option value="RESOLVED">Resolved</option>
                                </select>
                                <label for="editStatus">Status</label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="form-floating">
                            <textarea class="form-control" id="editDescription" name="description"
                                      placeholder="Description" style="height: 120px" required></textarea>
                            <label for="editDescription">Description</label>
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="form-floating">
                            <textarea class="form-control" id="editRemark" name="remark"
                                      placeholder="Remark" style="height: 80px" disabled></textarea>
                            <label for="editRemark">Remark</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i>Update Complaint
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View Complaint Modal -->
<div class="modal fade" id="viewComplaintModal" tabindex="-1" aria-labelledby="viewComplaintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewComplaintModalLabel">
                    <i class="fas fa-eye me-2"></i>View Complaint Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="viewComplaintDetails">
                <!-- Complaint details will be loaded here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<%!
    // Helper method for JavaScript string escaping
    private String escapeJs(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                .replace("'", "\\'")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
%>

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

    function editComplaint(id, subject, description, status, incidentDate, remark) {
        document.getElementById('editComplainID').value = id;
        document.getElementById('editSubject').value = subject;
        document.getElementById('editDescription').value = description;
        document.getElementById('editStatus').value = status;
        document.getElementById('editIncidentDate').value = incidentDate;
        document.getElementById('editRemark').value = remark;

        const modal = new bootstrap.Modal(document.getElementById('editComplaintModal'));
        modal.show();
    }

    function escapeHtml(text) {
        if (!text) return '';
        return text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function viewComplaint(id, subject, description, status, incidentDate, remark) {
        const safeId = escapeHtml(id);
        const safeSubject = escapeHtml(subject);
        const safeDescription = escapeHtml(description);
        const safeStatus = escapeHtml(status);
        const safeIncidentDate = escapeHtml(incidentDate || 'Not specified');
        const safeRemark = escapeHtml(remark || 'No remarks');

        const badgeClass = {
            'pending': 'warning',
            'resolved': 'success',
            'rejected': 'danger',
            'in_progress': 'info',
            'in-progress': 'info'
        }[safeStatus.toLowerCase()] || 'secondary';

        var detailsHtml =
            '<div class="row">' +
            '<div class="col-md-6 mb-3">' +
            '<strong>Complaint ID:</strong> #' + safeId +
            '</div>' +
            '<div class="col-md-6 mb-3">' +
            '<strong>Status:</strong>' +
            '<span class="badge bg-' + badgeClass + '">' + safeStatus + '</span>' +
            '</div>' +
            '<div class="col-12 mb-3">' +
            '<strong>Subject:</strong> ' + safeSubject +
            '</div>' +
            '<div class="col-12 mb-3">' +
            '<strong>Incident Date:</strong> ' + safeIncidentDate +
            '</div>' +
            '<div class="col-12 mb-3">' +
            '<strong>Description:</strong>' +
            '<p class="mt-2 p-3 bg-light rounded">' + safeDescription + '</p>' +
            '</div>';

        if (remark && remark.trim() !== '' && remark !== 'No remarks') {
            detailsHtml +=
                '<div class="col-12">' +
                '<strong>Remark:</strong>' +
                '<p class="mt-2 p-3 bg-light rounded">' + safeRemark + '</p>' +
                '</div>';
        }

        detailsHtml += '</div>';

        document.getElementById('viewComplaintDetails').innerHTML = detailsHtml;
        const modal = new bootstrap.Modal(document.getElementById('viewComplaintModal'));
        modal.show();
    }

    // Set today's date as default for incident date
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('incidentDate').value = today;
    });
</script>
</body>
</html>