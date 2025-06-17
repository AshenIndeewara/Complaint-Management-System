<%--
  Created by IntelliJ IDEA.
  User: User_101
  Date: 6/14/2025
  Time: 2:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Complaint Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
            --card-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }

        body {
            background: linear-gradient(135deg, var(--success-color) 0%, var(--secondary-color) 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            display: flex;
            min-height: 600px;
        }

        .register-left {
            background: linear-gradient(135deg, var(--success-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            flex: 1;
            position: relative;
            overflow: hidden;
        }

        .register-left::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"/></svg>') repeat;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% { transform: translateY(0px) rotate(0deg); }
            100% { transform: translateY(-100px) rotate(360deg); }
        }

        .register-left-content {
            position: relative;
            z-index: 2;
        }

        .register-left h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .register-left p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
        }

        .feature-list {
            list-style: none;
            padding: 0;
            text-align: left;
        }

        .feature-list li {
            padding: 0.5rem 0;
            display: flex;
            align-items: center;
        }

        .feature-list i {
            margin-right: 0.75rem;
            font-size: 1.2rem;
        }

        .register-right {
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            flex: 1;
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .register-header p {
            color: #6c757d;
            margin: 0;
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-floating .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem 0.75rem;
            height: auto;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-floating .form-control:focus {
            border-color: var(--success-color);
            box-shadow: 0 0 0 0.2rem rgba(39, 174, 96, 0.25);
        }

        .form-floating .form-control:hover {
            border-color: var(--success-color);
        }

        .form-floating label {
            color: #6c757d;
            font-weight: 500;
        }

        .btn-register {
            background: linear-gradient(135deg, var(--success-color) 0%, var(--secondary-color) 100%);
            border: none;
            padding: 1rem 2rem;
            font-weight: 600;
            border-radius: 12px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            width: 100%;
            margin-bottom: 1rem;
            color: white;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
            color: white;
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: 1rem;
        }

        .login-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: var(--primary-color);
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
            margin-bottom: 1.5rem;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 5;
        }

        .form-floating .form-control.with-icon {
            padding-left: 2.5rem;
        }

        .form-floating label.with-icon {
            padding-left: 2.5rem;
        }

        .password-requirements {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--success-color);
        }

        .password-requirements h6 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .password-requirements ul {
            margin: 0;
            padding-left: 1.2rem;
            color: #6c757d;
            font-size: 0.875rem;
        }

        .password-requirements li {
            margin-bottom: 0.25rem;
        }

        @media (max-width: 768px) {
            .register-container {
                flex-direction: column;
                max-width: 400px;
                border-radius: 15px;
            }

            .register-left {
                padding: 2rem;
                min-height: 200px;
            }

            .register-left h1 {
                font-size: 1.8rem;
            }

            .feature-list {
                display: none;
            }

            .register-right {
                padding: 2rem;
            }

            .register-header h2 {
                font-size: 1.5rem;
            }
        }

        .terms-notice {
            background-color: #e3f2fd;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            text-align: center;
            border-left: 4px solid var(--secondary-color);
        }

        .terms-notice p {
            color: #1976d2;
            font-size: 0.875rem;
            margin: 0;
        }

        .terms-notice a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .terms-notice a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<div class="register-container">
    <!-- Left Side - Branding -->
    <div class="register-left">
        <div class="register-left-content">
            <i class="bi bi-person-plus display-1 mb-3"></i>
            <h1>Join Us Today!</h1>
            <p>Create your account to start managing complaints efficiently</p>
        </div>
    </div>

    <!-- Right Side - Register Form -->
    <div class="register-right">
        <div class="register-header">
            <h2>Create Account</h2>
            <p>Fill in your details to get started</p>
        </div>

        <!-- Error/Success Messages -->
        <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
        <div class="alert alert-danger alert-custom" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <%= errorMessage %>
        </div>
        <% } %>

        <% if (successMessage != null && !successMessage.trim().isEmpty()) { %>
        <div class="alert alert-success alert-custom" role="alert">
            <i class="bi bi-check-circle me-2"></i>
            <%= successMessage %>
        </div>
        <% } %>

        <!-- Register Form -->
        <form method="post" action="register">
            <div class="form-floating position-relative">
                <i class="bi bi-person input-icon"></i>
                <input type="text" class="form-control with-icon" id="username" name="username"
                       placeholder="Username" required autocomplete="username"
                       pattern="[a-zA-Z0-9_]{3,20}"
                       title="Username must be 3-20 characters long and contain only letters, numbers, and underscores">
                <label for="username" class="with-icon">Username</label>
            </div>

            <div class="form-floating position-relative">
                <i class="bi bi-lock input-icon"></i>
                <input type="password" class="form-control with-icon" id="password" name="password"
                       placeholder="Password" required autocomplete="new-password"
                       minlength="8"
                       title="Password must be at least 8 characters long">
                <label for="password" class="with-icon">Password</label>
            </div>

            <div class="form-floating position-relative">
                <i class="bi bi-lock-fill input-icon"></i>
                <input type="password" class="form-control with-icon" id="password2" name="password2"
                       placeholder="Confirm Password" required autocomplete="new-password"
                       minlength="8"
                       title="Please confirm your password">
                <label for="password2" class="with-icon">Confirm Password</label>
            </div>

            <button type="submit" class="btn btn-register">
                <i class="bi bi-person-plus me-2"></i>
                Create Account
            </button>

            <div class="login-link">
                <span class="text-muted">Already have an account? </span>
                <a href="login.jsp">
                    <i class="bi bi-box-arrow-in-right me-1"></i>
                    Sign In Here
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

