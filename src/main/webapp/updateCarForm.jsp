<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% ResultSet car = (ResultSet) request.getAttribute("car"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Car</title>
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
	max-width: 550px;
}

h2 {
	color: #1976d2;
	text-align: center;
	margin-bottom: 30px;
	font-weight: bolder;
	letter-spacing: 0.5px;
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
	padding: 12px 15px;
	border: 1px solid #90caf9;
	border-radius: 6px;
	font-size: 1rem;
	color: #333;
	box-sizing: border-box;
	margin-bottom: 20px;
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
	font-size: 17px;
	transition: background-color 0.2s ease-in-out, transform 0.1s ease;
	width: 100%;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.btn-primary:hover {
	background-color: #1565c0;
	transform: translateY(-1px);
	box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
}

.mb-3 {
	margin-bottom: 25px !important;
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
		<h2>Update Car</h2>
		<form action="UpdateCarActionServlet" method="post" id="updateCarForm">
			<input type="hidden" name="carRegno"
				value="<%= car.getString("Car_Regno") %>">
			<div class="mb-3">
				<label for="carModel" class="form-label">Car Model</label> <input
					type="text" class="form-control" id="carModel" name="carModel"
					value="<%= car.getString("Car_Model") %>" required>
				<div id="carModelError" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="carYear" class="form-label">Car Year</label> <input
					type="text" class="form-control" id="carYear" name="carYear"
					value="<%= car.getInt("Car_Year") %>" required>
				<div id="carYearError" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="carColor" class="form-label">Car Color</label> <input
					type="text" class="form-control" id="carColor" name="carColor"
					value="<%= car.getString("Car_Color") %>" required>
				<div id="carColorError" class="error-message"></div>
			</div>
			<div class="mb-3">
				<label for="carStatus" class="form-label">Car Status</label> <input
					type="text" class="form-control" id="carStatus" name="carStatus"
					value="<%= car.getString("Car_Status") %>" required>
				<div id="carStatusError" class="error-message"></div>
			</div>
			<button type="submit" class="btn btn-primary">Update Car</button>
		</form>
	</div>
	<script>
        const carModelInput = document.getElementById('carModel');
        const carYearInput = document.getElementById('carYear');
        const carColorInput = document.getElementById('carColor');
        const carStatusInput = document.getElementById('carStatus');


        const carModelError = document.getElementById('carModelError');
        const carYearError = document.getElementById('carYearError');
        const carColorError = document.getElementById('carColorError');
        const carStatusError = document.getElementById('carStatusError');


        carModelInput.addEventListener('input', () => {
            if (!/^[a-zA-Z\s]+$/.test(carModelInput.value)) {
                carModelInput.classList.add('input-error');
                carModelError.textContent = "Car model must contain only letters and spaces";
                carModelError.style.display = 'block';
            } else {
                carModelInput.classList.remove('input-error');
                carModelError.textContent = '';
                carModelError.style.display = 'none';
            }
        });

        carYearInput.addEventListener('input', () => {
            if (!/^\d{4}$/.test(carYearInput.value)) {
                carYearInput.classList.add('input-error');
                carYearError.textContent = "Car year must be a 4-digit number";
                carYearError.style.display = 'block';
            } else {
                carYearInput.classList.remove('input-error');
                carYearError.textContent = '';
                carYearError.style.display = 'none';
            }
        });

        carColorInput.addEventListener('input', () => {
            if (!/^[a-zA-Z\s]+$/.test(carColorInput.value)) {
                carColorInput.classList.add('input-error');
                carColorError.textContent = "Car color must contain only letters and spaces";
                carColorError.style.display = 'block';
            } else {
                carColorInput.classList.remove('input-error');
                carColorError.textContent = '';
                carColorError.style.display = 'none';
            }
        });

        carStatusInput.addEventListener('input', () => {
            if (!/^[a-zA-Z\s]+$/.test(carStatusInput.value)) {
                carStatusInput.classList.add('input-error');
                carStatusError.textContent = "Car status must contain only letters and spaces";
                carStatusError.style.display = 'block';
            } else {
                carStatusInput.classList.remove('input-error');
                carStatusError.textContent = '';
                carStatusError.style.display = 'none';
            }
        });


        document.getElementById('updateCarForm').addEventListener('submit', function(event) {
            let hasErrors = false;

            if (carModelError.textContent !== '') {
                hasErrors = true;
            }
            if (carYearError.textContent !== '') {
                hasErrors = true;
            }
             if (carColorError.textContent !== '') {
                hasErrors = true;
            }
             if (carStatusError.textContent !== '') {
                hasErrors = true;
            }


            if (hasErrors) {
                event.preventDefault();
            }
        });
    </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
