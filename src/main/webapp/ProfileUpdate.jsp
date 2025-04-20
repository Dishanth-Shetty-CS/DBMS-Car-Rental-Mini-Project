<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Profile</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
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

.profile-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
	width: 90%;
	max-width: 500px;
}

.profile-container h2 {
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

	<%
    String customerID = (String) session.getAttribute("customerID");
    if (customerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = "";
    String address = "";
    String phone = "";
    String email = "";

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

        String sql = "SELECT Cust_Name, Cust_Address, Cust_Phone, Cust_Email FROM CUSTOMER WHERE Cust_ID = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, customerID);

        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            name = resultSet.getString("Cust_Name");
            address = resultSet.getString("Cust_Address");
            phone = resultSet.getString("Cust_Phone");
            email = resultSet.getString("Cust_Email");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (resultSet != null) resultSet.close(); } catch (SQLException e) {}
        try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) {}
        try { if (connection != null) connection.close(); } catch (SQLException e) {}
    }
%>

	<div class="profile-container">
		<h2>Customer Profile</h2>
		<form action="ProfileServlet" method="post" id="profile">
			<div class="mb-3">
				<label for="Cust_Name" class="form-label">Name</label> <input
					type="text" id="Cust_Name" name="Cust_Name" class="form-control"
					value="<%= name %>" required>
				<div id="name_error" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="Cust_Address" class="form-label">Address</label> <input
					type="text" id="Cust_Address" name="Cust_Address"
					class="form-control" value="<%= address %>" required>
				<div id="address_error" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="Cust_Phone" class="form-label">Phone</label> <input
					type="tel" id="Cust_Phone" name="Cust_Phone" class="form-control"
					value="<%= phone %>" required>
				<div id="phone_error" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="Cust_Email" class="form-label">Email</label> <input
					type="email" id="Cust_Email" name="Cust_Email" class="form-control"
					value="<%= email %>" required>
				<div id="email_error" class="error-message"></div>
			</div>
			<input type="hidden" name="Cust_ID" value="<%= customerID %>">
			<button type="submit" class="btn btn-primary">Update Profile</button>
		</form>
	</div>
	<script>
const profileForm = document.getElementById("profile");
const nameInput = document.getElementById("Cust_Name");
const addressInput = document.getElementById("Cust_Address");
const phoneInput = document.getElementById("Cust_Phone");
const emailInput = document.getElementById("Cust_Email");

const nameError = document.getElementById("name_error");
const addressError = document.getElementById("address_error");
const phoneError = document.getElementById("phone_error");
const emailError = document.getElementById("email_error");


function validateName() {
    const nameValue = nameInput.value.trim();
    if (nameValue === "") {
        nameError.textContent = "Name is required";
        nameInput.classList.add("error-border");
        return false;
    } else if (!/^[a-zA-Z\s]+$/.test(nameValue)) {
        nameError.textContent = "Name must contain only letters and spaces";
        nameInput.classList.add("error-border");
        return false;
    } else {
        nameError.textContent = "";
        nameInput.classList.remove("error-border");
        return true;
    }
}

function validateAddress() {
    const addressValue = addressInput.value.trim();
    if (addressValue === "") {
        addressError.textContent = "Address is required";
        addressInput.classList.add("error-border");
        return false;
    } else if (addressValue.length < 1) {
        addressError.textContent = "Address must contain at least one character";
        addressInput.classList.add("error-border");
        return false;
    } else if (/\d/.test(addressValue)) {
        addressError.textContent = "Address contains only characters";
        addressInput.classList.add("error-border");
        return false;
    } else {
        addressError.textContent = "";
        addressInput.classList.remove("error-border");
        return true;
    }
}

function validatePhone() {
    const phoneValue = phoneInput.value.trim();
    if (phoneValue === "") {
        phoneError.textContent = "Phone number is required";
        phoneInput.classList.add("error-border");
        return false;
    } else if (!/^\d{10}$/.test(phoneValue)) {
        phoneError.textContent = "Invalid phone number format (10 digits required)";
        phoneInput.classList.add("error-border");
        return false;
    } else {
        phoneError.textContent = "";
        phoneInput.classList.remove("error-border");
        return true;
    }
}

function validateEmail() {
    const emailValue = emailInput.value.trim();
    if (emailValue === "") {
        emailError.textContent = "Email is required";
        emailInput.classList.add("error-border");
        return false;
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailValue)) {
        emailError.textContent = "Invalid email format";
        emailInput.classList.add("error-border");
        return false;
    } else {
        emailError.textContent = "";
        emailInput.classList.remove("error-border");
        return true;
    }
}

nameInput.addEventListener("input", validateName);
addressInput.addEventListener("input", validateAddress);
phoneInput.addEventListener("input", validatePhone);
emailInput.addEventListener("input", validateEmail);


profileForm.addEventListener("submit", function(event) {
    event.preventDefault();

    const isNameValid = validateName();
    const isAddressValid = validateAddress();
    const isPhoneValid = validatePhone();
    const isEmailValid = validateEmail();

    if (isNameValid && isAddressValid && isPhoneValid && isEmailValid) {
        const formData = new FormData(this);
        const params = new URLSearchParams(formData);

        fetch("ProfileServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: params
        })
        .then(response => response.text())
        .then(result => {
            if (result.includes("Updated")) {
                Swal.fire({
                    title: "Profile Successfully Updated!",
                    text: "Your profile has been updated.",
                    icon: "success",
                    confirmButtonText: "OK"
                }).then(() => {
                    window.location.href = "customer-dashboard.jsp";
                });
            } else {
                Swal.fire({
                    title: "Profile Updation Failed!",
                    text: "Failed to update profile. Please try again.",
                    icon: "error",
                    confirmButtonText: "OK"
                });
            }
        })
        .catch(error => {
            Swal.fire({
                title: "Error!",
                text: "An error occurred: " + error,
                icon: "error",
                confirmButtonText: "OK"
            });
            console.error("Error:", error);
        });
    }
});
</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
