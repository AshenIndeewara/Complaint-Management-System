<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Complaint Management System</title>
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
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            display: flex;
            min-height: 500px;
        }

        .login-left {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
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

        .login-left::before {
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

        .login-left-content {
            position: relative;
            z-index: 2;
        }

        .login-left h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .login-left p {
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

        .login-right {
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            flex: 1;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .login-header p {
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
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .form-floating .form-control:hover {
            border-color: var(--secondary-color);
        }

        .form-floating label {
            color: #6c757d;
            font-weight: 500;
        }

        .btn-login {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
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

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
            color: white;
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .register-user {
            text-align: center;
            margin-top: 1rem;
        }

        .register-user a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .register-user a:hover {
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

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                max-width: 400px;
                border-radius: 15px;
            }

            .login-left {
                padding: 2rem;
                min-height: 200px;
            }

            .login-left h1 {
                font-size: 1.8rem;
            }

            .feature-list {
                display: none;
            }

            .login-right {
                padding: 2rem;
            }

            .login-header h2 {
                font-size: 1.5rem;
            }
        }

        .system-info {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1.5rem;
            text-align: center;
            border-left: 4px solid var(--secondary-color);
        }

        .system-info h6 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .system-info p {
            color: #6c757d;
            font-size: 0.875rem;
            margin: 0;
        }
    </style>
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<div class="login-container">
    <!-- Left Side - Branding -->
    <div class="login-left">
        <div class="login-left-content">
            <i class="bi bi-clipboard-check display-1 mb-3"></i>
            <h1>Welcome Back!</h1>
            <p>Access your complaint management dashboard</p>
        </div>
    </div>

    <!-- Right Side - Login Form -->
    <div class="login-right">
        <div class="login-header">
            <h2>Sign In</h2>
            <p>Enter your credentials to access your account</p>
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

        <!-- Login Form -->
        <form method="post" action="login">
            <div class="form-floating position-relative">
                <i class="bi bi-person input-icon"></i>
                <input type="text" class="form-control with-icon" id="username" name="username"
                       placeholder="Username" required autocomplete="username">
                <label for="username" class="with-icon">Username</label>
            </div>

            <div class="form-floating position-relative">
                <i class="bi bi-lock input-icon"></i>
                <input type="password" class="form-control with-icon" id="password" name="password"
                       placeholder="Password" required autocomplete="current-password">
                <label for="password" class="with-icon">Password</label>
            </div>

            <button type="submit" class="btn btn-login">
                <i class="bi bi-box-arrow-in-right me-2"></i>
                Sign In
            </button>

            <div class="register-user">
                <a href="register.jsp">
                    <i class="bi bi-pencil-square me-2"></i>
                    Don't have an account? Register here
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>