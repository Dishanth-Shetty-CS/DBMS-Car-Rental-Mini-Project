<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Form</title>
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

.payment-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 500px;
}

.payment-container h2 {
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

	<div class="payment-container">
		<h2 class="text-center">Payment Form</h2>

		<form id="paymentForm" action="processPayment" method="post">
			<div class="mb-3">
				<label for="payMethod" class="form-label">Payment Method</label> <select
					name="payMethod" id="payMethod" class="form-control">
					<option value="">Select One</option>
					<option value="Credit Card">Credit Card</option>
					<option value="UPI">UPI</option>
					<option value="Debit Card">Debit Card</option>
					<option value="Net Banking">Net Banking</option>
					<option value="Cash">Cash</option>
				</select>
				<div id="payMethod-error" class="error-message"></div>
			</div>

			<div class="mb-3">
				<label for="rentalID" class="form-label">Rental ID</label> <input
					type="text" name="rentalID" id="rentalID" class="form-control">
				<div id="rentalID-error" class="error-message"></div>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>

	<script>
    const paymentForm = document.getElementById("paymentForm");
    const payMethodInput = document.getElementById("payMethod");
    const rentalIDInput = document.getElementById("rentalID");

    const payMethodError = document.getElementById("payMethod-error");
    const rentalIDError = document.getElementById("rentalID-error");



    function validatePayMethod() {
        const payMethodValue = payMethodInput.value.trim();
        if (payMethodValue === "") {
            payMethodError.textContent = "Please select a payment method";
            payMethodInput.classList.add("error-border");
            return false;
        } else {
            payMethodError.textContent = "";
            payMethodInput.classList.remove("error-border");
            return true;
        }
    }

    function validateRentalID() {
        const rentalIDValue = rentalIDInput.value.trim();
        if (rentalIDValue === "") {
            rentalIDError.textContent = "Rental ID is required";
            rentalIDInput.classList.add("error-border");
            return false;
        } else if (!/^\d+$/.test(rentalIDValue)) {
            rentalIDError.textContent = "Rental ID must contain only numbers";
            rentalIDInput.classList.add("error-border");
            return false;
        } else {
            rentalIDError.textContent = "";
            rentalIDInput.classList.remove("error-border");
            return true;
        }
    }


    payMethodInput.addEventListener("input", validatePayMethod);
    rentalIDInput.addEventListener("input", validateRentalID);


    paymentForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const isPayMethodValid = validatePayMethod();
        const isRentalIDValid = validateRentalID();


        if (isPayMethodValid && isRentalIDValid) {
            const formData = new FormData(this);
            const params = new URLSearchParams(formData);

            fetch("processPayment", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: params
            })
            .then(response => response.text())
            .then(result => {
                if (result.includes("Payment successful")) {
                    Swal.fire({
                        title: "Payment Successful!",
                        text: "Payment details have been recorded.",
                        icon: "success"
                    }).then(() => {
                        window.location.href = "customer-dashboard.jsp";
                    });
                } else {
                    Swal.fire({
                        title: "Payment Failed!",
                        text: "Failed to process payment. Please try again.",
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

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
