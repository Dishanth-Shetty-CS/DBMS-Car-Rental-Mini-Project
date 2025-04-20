<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Rental</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(135deg, #e3f2fd, #bbdefb);
	font-family: 'Poppins', sans-serif;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
	margin: 0;
}

.container {
	background-color: #fff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	width: 90%;
	max-width: 600px;
}

h2 {
	color: #1976d2;
	text-align: center;
	margin-bottom: 30px;
	font-weight: bolder;
	letter-spacing: 0.5px;
}

.table {
	margin-bottom: 20px;
	border-collapse: separate;
	border-spacing: 0;
	width: 100%;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.table thead th {
	background-color: #1976d2;
	color: #fff;
	font-weight: 500;
	text-align: left;
	padding: 14px 18px;
	border-bottom: 2px solid #1565c0;
}

.table tbody td {
	padding: 12px 18px;
	border-bottom: 1px solid #e0e0e0;
}

.table tbody tr:last-child td {
	border-bottom: none;
}

.form-label {
	display: block;
	margin-bottom: 10px;
	color: #424242;
	font-size: 0.95rem;
	font-weight: 500;
}

.form-control {
	width: 100%;
	padding: 10px 12px;
	border: 1px solid #90caf9;
	border-radius: 6px;
	font-size: 1rem;
	color: #333;
	box-sizing: border-box;
	transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.form-control:focus {
	border-color: #1976d2;
	outline: none;
	box-shadow: 0 0 0 0.2rem rgba(25, 118, 210, 0.25);
}

.btn-primary {
	background-color: #1976d2;
	color: #fff;
	border: none;
	padding: 14px 22px;
	border-radius: 6px;
	font-size: 1.05rem;
	cursor: pointer;
	transition: background-color 0.2s ease-in-out, transform 0.1s ease;
	width: 100%;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.btn-primary:hover {
	background-color: #1565c0;
	transform: translateY(-1px);
	box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
}

.error-message {
	color: red;
	font-size: 0.9rem;
	margin-top: 5px;
	display: none;
}

.input-error {
	border-color: red !important;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Update Rental</h2>
		<form action="UpdateRentalActionServlet" method="post"
			id="updateRentalForm">
			<input type="hidden" name="rentalId" value="${rentalId}">

			<table class="table">
				<thead>
					<tr>
						<th>Field</th>
						<th>Value</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><label for="rentalName" class="form-label">Rental
								Name</label></td>
						<td><input type="text" class="form-control" id="rentalName"
							name="rentalName" value="${rentalName}">
							<div id="rentalNameError" class="error-message"></div></td>
					</tr>

					<tr>
						<td><label for="rentStartDate" class="form-label">Rent
								Start Date</label></td>
						<td><input type="date" class="form-control"
							id="rentStartDate" name="rentStartDate" value="${rentStartDate}">
							<div id="rentStartDateError" class="error-message"></div></td>
					</tr>

					<tr>
						<td><label for="rentEndDate" class="form-label">Rent
								End Date</label></td>
						<td><input type="date" class="form-control" id="rentEndDate"
							name="rentEndDate" value="${rentEndDate}">
							<div id="rentEndDateError" class="error-message"></div></td>
					</tr>

					<tr>
						<td><label for="rentalStatus" class="form-label">Rental
								Status</label></td>
						<td><input type="text" class="form-control" id="rentalStatus"
							name="rentalStatus" value="${rentalStatus}">
							<div id="rentalStatusError" class="error-message"></div></td>
					</tr>

					<tr>
						<td><label for="custId" class="form-label">Customer
								ID</label></td>
						<td><input type="text" class="form-control" id="custId"
							name="custId" value="${custId}">
							<div id="custIdError" class="error-message"></div></td>
					</tr>

					<tr>
						<td><label for="carRegno" class="form-label">Car Reg
								No</label></td>
						<td><input type="text" class="form-control" id="carRegno"
							name="carRegno" value="${carRegno}">
							<div id="carRegnoError" class="error-message"></div></td>
					</tr>
				</tbody>
			</table>

			<button type="submit" class="btn btn-primary">Update Rental</button>
		</form>
	</div>
	<script>
        const rentalNameInput = document.getElementById('rentalName');
        const rentStartDateInput = document.getElementById('rentStartDate');
        const rentEndDateInput = document.getElementById('rentEndDate');
        const rentalStatusInput = document.getElementById('rentalStatus');
        const custIdInput = document.getElementById('custId');
        const carRegnoInput = document.getElementById('carRegno');

        const rentalNameError = document.getElementById('rentalNameError');
        const rentStartDateError = document.getElementById('rentStartDateError');
        const rentEndDateError = document.getElementById('rentEndDateError');
        const rentalStatusError = document.getElementById('rentalStatusError');
        const custIdError = document.getElementById('custIdError');
        const carRegnoError = document.getElementById('carRegnoError');

        function validateRentalName() {
            if (!/^[a-zA-Z\s]+$/.test(rentalNameInput.value)) {
                rentalNameInput.classList.add('input-error');
                rentalNameError.textContent = "Rental name must contain only letters and spaces";
                rentalNameError.style.display = 'block';
                return false;
            } else {
                rentalNameInput.classList.remove('input-error');
                rentalNameError.textContent = '';
                rentalNameError.style.display = 'none';
                return true;
            }
        }

        function validateRentStartDate() {
            const today = new Date().toISOString().split('T')[0];
            if (rentStartDateInput.value < today) {
                rentStartDateInput.classList.add('input-error');
                rentStartDateError.textContent = "Start date cannot be in the past";
                rentStartDateError.style.display = 'block';
                return false;
            } else {
                rentStartDateInput.classList.remove('input-error');
                rentStartDateError.textContent = '';
                rentStartDateError.style.display = 'none';
                return true;
            }
        }

        function validateRentEndDate() {
            const today = new Date().toISOString().split('T')[0];
            if (rentEndDateInput.value < today) {
                rentEndDateInput.classList.add('input-error');
                rentEndDateError.textContent = "End date cannot be in the past";
                rentEndDateError.style.display = 'block';
                return false;
            } else if (rentEndDateInput.value < rentStartDateInput.value) {
                rentEndDateInput.classList.add('input-error');
                rentEndDateError.textContent = "End date cannot be earlier than start date";
                rentEndDateError.style.display = 'block';
                return false;
            } else {
                rentEndDateInput.classList.remove('input-error');
                rentEndDateError.textContent = '';
                rentEndDateError.style.display = 'none';
                return true;
            }
        }

        function validateRentalStatus() {
            if (!/^[a-zA-Z\s]+$/.test(rentalStatusInput.value)) {
                rentalStatusInput.classList.add('input-error');
                rentalStatusError.textContent = "Rental status must contain only letters and spaces";
                rentalStatusError.style.display = 'block';
                return false;
            } else {
                rentalStatusInput.classList.remove('input-error');
                rentalStatusError.textContent = '';
                rentalStatusError.style.display = 'none';
                return true;
            }
        }

        function validateCustId() {
            if (!/^\d+$/.test(custIdInput.value)) {
                custIdInput.classList.add('input-error');
                custIdError.textContent = "Customer ID must contain only numbers";
                custIdError.style.display = 'block';
                return false;
            } else {
                custIdInput.classList.remove('input-error');
                custIdError.textContent = '';
                custIdError.style.display = 'none';
                return true;
            }
        }

        function validateCarRegno() {
            if (!/^[a-zA-Z0-9]{10}$/.test(carRegnoInput.value)) {
                carRegnoInput.classList.add('input-error');
                carRegnoError.textContent = "Car Reg No must be 10 characters with letters and numbers";
                carRegnoError.style.display = 'block';
                return false;
            } else {
                carRegnoInput.classList.remove('input-error');
                carRegnoError.textContent = '';
                carRegnoError.style.display = 'none';
                return true;
            }
        }

        rentalNameInput.addEventListener('input', validateRentalName);
        rentStartDateInput.addEventListener('input', validateRentStartDate);
        rentEndDateInput.addEventListener('input', validateRentEndDate);
        rentalStatusInput.addEventListener('input', validateRentalStatus);
        custIdInput.addEventListener('input', validateCustId);
        carRegnoInput.addEventListener('input', validateCarRegno);

        document.getElementById('updateRentalForm').addEventListener('submit', function(event) {
            let hasErrors = false;

            if (!validateRentalName()) hasErrors = true;
            if (!validateRentStartDate()) hasErrors = true;
            if (!validateRentEndDate()) hasErrors = true;
            if (!validateRentalStatus()) hasErrors = true;
            if (!validateCustId()) hasErrors = true;
            if (!validateCarRegno()) hasErrors = true;

            if (hasErrors) {
                event.preventDefault();
            }
        });
    </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
