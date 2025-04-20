<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Registration</title>
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

.registration-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
	width: 90%;
	max-width: 500px;
}

.registration-container h2 {
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

	<div class="registration-container">
		<h2>Customer Registration</h2>
		<form id="customerForm" action="CustomerServlet" method="post">
			<div class="mb-3">
				<label for="Cust_Name" class="form-label">Full Name</label> <input
					type="text" id="Cust_Name" name="Cust_Name" class="form-control">
				<div id="cust_name_error" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="Cust_Address" class="form-label">Address</label> <input
					type="text" id="Cust_Address" name="Cust_Address"
					class="form-control">
				<div id="cust_address_error" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="Cust_Phone" class="form-label">Phone Number</label> <input
					type="tel" id="Cust_Phone" name="Cust_Phone" class="form-control">
				<div id="cust_phone_error" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="Cust_Email" class="form-label">Email Address</label> <input
					type="email" id="Cust_Email" name="Cust_Email" class="form-control">
				<div id="cust_email_error" class="error-message"></div>
			</div>
			<button type="submit" class="btn btn-primary">Register</button>
		</form>
		<div class="link-text">
			<p>
				Already have an account? <a href="login.jsp">Login</a>
			</p>
		</div>
	</div>

	<script>
    const customerForm = document.getElementById("customerForm");
    const custNameInput = document.getElementById("Cust_Name");
    const custAddressInput = document.getElementById("Cust_Address");
    const custPhoneInput = document.getElementById("Cust_Phone");
    const custEmailInput = document.getElementById("Cust_Email");

    const custNameError = document.getElementById("cust_name_error");
    const custAddressError = document.getElementById("cust_address_error");
    const custPhoneError = document.getElementById("cust_phone_error");
    const custEmailError = document.getElementById("cust_email_error");

    function validateName() {
        const nameValue = custNameInput.value.trim();
        if (nameValue === "") {
            custNameError.textContent = "Name is required";
            custNameInput.classList.add("error-border");
            return false;
        } else if (!/^[a-zA-Z\s]+$/.test(nameValue)) {
            custNameError.textContent = "Name must contain only letters and spaces";
            custNameInput.classList.add("error-border");
            return false;
        } else {
            custNameError.textContent = "";
            custNameInput.classList.remove("error-border");
            return true;
        }
    }

    function validateAddress() {
        const addressValue = custAddressInput.value.trim();
         if (addressValue === "") {
            custAddressError.textContent = "Address is required";
            custAddressInput.classList.add("error-border");
            return false;
        } else if (!/^[a-zA-Z\s,-./#]+$/.test(addressValue)) {
            custAddressError.textContent = "Address must contain only characters";
            custAddressInput.classList.add("error-border");
            return false;
        } else {
            custAddressError.textContent = "";
            custAddressInput.classList.remove("error-border");
            return true;
        }
    }

    function validatePhone() {
        const phoneValue = custPhoneInput.value.trim();
        if (phoneValue === "") {
            custPhoneError.textContent = "Phone number is required";
            custPhoneInput.classList.add("error-border");
            return false;
        } else if (!/^\d{10}$/.test(phoneValue)) {
            custPhoneError.textContent = "Phone number must be 10 digits";
            custPhoneInput.classList.add("error-border");
            return false;
        } else {
            custPhoneError.textContent = "";
            custPhoneInput.classList.remove("error-border");
            return true;
        }
    }

    function validateEmail() {
        const emailValue = custEmailInput.value.trim();
        if (emailValue === "") {
            custEmailError.textContent = "Email is required";
            custEmailInput.classList.add("error-border");
            return false;
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailValue)) {
            custEmailError.textContent = "Invalid email format";
            custEmailInput.classList.add("error-border");
            return false;
        } else {
            custEmailError.textContent = "";
            custEmailInput.classList.remove("error-border");
            return true;
        }
    }

    custNameInput.addEventListener("input", validateName);
    custAddressInput.addEventListener("input", validateAddress);
    custPhoneInput.addEventListener("input", validatePhone);
    custEmailInput.addEventListener("input", validateEmail);

    customerForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const isNameValid = validateName();
        const isAddressValid = validateAddress();
        const isPhoneValid = validatePhone();
        const isEmailValid = validateEmail();

        if (isNameValid && isAddressValid && isPhoneValid && isEmailValid) {
            const formData = new FormData(this);
            const params = new URLSearchParams(formData);

            fetch("CustomerServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: params
            })
            .then(response => response.json()) 
            .then(data => {
                if (data.status === 'success') {
                    const customerId = data.customerId;
                    Swal.fire({
                        title: "Registration Successful!",
                        text: "Customer successfully inserted! Your Customer ID is: " + customerId,
                        icon: "success"
                    }).then(() => {
                        window.location.href = "login.jsp?customerId=" + customerId;
                    });
                } else {
                    Swal.fire({
                        title: "Registration Failed!",
                        text: data.message,
                        icon: "error"
                    });
                }
            })
            .catch(error => {
                Swal.fire({
                    title: "Error!",
                    text: "An error occurred: " + error.message, 
                    icon: "error"
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
