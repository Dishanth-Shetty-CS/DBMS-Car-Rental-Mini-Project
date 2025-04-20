<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #e6f7ff;
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 400px;
        }
        .login-container h2 {
            color: #0d6efd;
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 1.8rem;
        }
        .form-control {
            border: 2px solid #a8cfff;
            border-radius: 6px;
            padding: 10px 12px;
            margin-bottom: 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 6px;
            display: block;
            font-size: 14px;
        }
        .link-text {
            text-align: center;
            margin-top: 15px;
        }
        .link-text a {
            color: #0d6efd;
            text-decoration: none;
        }
        .link-text a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 5px;
            display: block;
        }
        .error-border {
            border-color: red !important;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Admin Login</h2>
    <form id="adminLoginForm" action="../AdminLoginServlet" method="post">
        <div class="mb-3">
            <label for="Admin_ID" class="form-label">Admin ID</label>
            <input type="text" id="Admin_ID" name="Admin_ID" class="form-control" >
            <div id="admin_id_error" class="error-message"></div>
        </div>
        <div class="mb-3">
            <label for="Admin_Email" class="form-label">Email Address</label>
            <input type="email" id="Admin_Email" name="Admin_Email" class="form-control" >
             <div id="admin_email_error" class="error-message"></div>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
</div>

<script>
    const adminLoginForm = document.getElementById("adminLoginForm");
    const adminIdInput = document.getElementById("Admin_ID");
    const adminEmailInput = document.getElementById("Admin_Email");

    const adminIdError = document.getElementById("admin_id_error");
    const adminEmailError = document.getElementById("admin_email_error");

    function validateAdminId() {
        const adminIdValue = adminIdInput.value.trim();
        if (adminIdValue === "") {
            adminIdError.textContent = "Admin ID is required";
            adminIdInput.classList.add("error-border");
            return false;
        } else if (!/^\d+$/.test(adminIdValue)) {
            adminIdError.textContent = "Admin ID must contain only numbers";
            adminIdInput.classList.add("error-border");
            return false;
        } else {
            adminIdError.textContent = "";
            adminIdInput.classList.remove("error-border");
            return true;
        }
    }

    function validateAdminEmail() {
        const emailValue = adminEmailInput.value.trim();
        if (emailValue === "") {
            adminEmailError.textContent = "Email is required";
            adminEmailInput.classList.add("error-border");
            return false;
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailValue)) {
            adminEmailError.textContent = "Invalid email format";
            adminEmailInput.classList.add("error-border");
            return false;
        } else {
            adminEmailError.textContent = "";
            adminEmailInput.classList.remove("error-border");
            return true;
        }
    }

    adminIdInput.addEventListener("input", validateAdminId);
    adminEmailInput.addEventListener("input", validateAdminEmail);

    adminLoginForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const isIdValid = validateAdminId();
        const isEmailValid = validateAdminEmail();

        if (isIdValid && isEmailValid) {
            const formData = new FormData(this);
            const params = new URLSearchParams(formData);

            fetch("AdminLoginServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: params
            })
            .then(response => response.text())
            .then(result => {
                if (result.includes("Login successful")) {
                    Swal.fire({
                        title: "Login Successful!",
                        text: "You are now logged in.",
                        icon: "success"
                    }).then(() => {
                        window.location.href = "admin-dashboard.jsp"; 
                    });
                } else {
                    Swal.fire({
                        title: "Login Failed!",
                        text: "Invalid Admin ID or Email.",
                        icon: "error"
                    });
                }
            })
            .catch(error => {
                Swal.fire({
                    title: "Error!",
                    text: "An error occurred: " + error,
                    icon: "error"
                });
                console.error("Error:", error);
            });
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
