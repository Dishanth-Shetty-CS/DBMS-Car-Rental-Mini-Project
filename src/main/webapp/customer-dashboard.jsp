<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%
HttpSession currentSession = request.getSession(false);
if (currentSession == null) {
	response.sendRedirect("login.jsp");
	return;
}

String customerID = (String) currentSession.getAttribute("customerID");
if (customerID == null) {
	response.sendRedirect("login.jsp");
	return;
}

String customerName = "";
int totalRentals = 0;
int activeRentals = 0;
int carsAvailable = 0;

Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

	String nameQuery = "SELECT Cust_Name FROM Customer WHERE Cust_ID = ?";
	preparedStatement = connection.prepareStatement(nameQuery);
	preparedStatement.setString(1, customerID);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		customerName = resultSet.getString("Cust_Name");
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	String totalRentalsQuery = "SELECT COUNT(*) FROM Rental WHERE Cust_ID = ?";
	preparedStatement = connection.prepareStatement(totalRentalsQuery);
	preparedStatement.setString(1, customerID);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		totalRentals = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	String activeRentalsQuery = "SELECT COUNT(*) FROM Rental WHERE Cust_ID = ? AND Rental_Status = 'Ongoing'";
	preparedStatement = connection.prepareStatement(activeRentalsQuery);
	preparedStatement.setString(1, customerID);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		activeRentals = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	String availableCarsQuery = "SELECT COUNT(*) FROM CAR WHERE Car_Status = 'Available'";
	preparedStatement = connection.prepareStatement(availableCarsQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		carsAvailable = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

} catch (Exception e) {
	e.printStackTrace();
} finally {
	try {
		if (resultSet != null)
	resultSet.close();
	} catch (Exception e) {
	}
	try {
		if (preparedStatement != null)
	preparedStatement.close();
	} catch (Exception e) {
	}
	try {
		if (connection != null)
	connection.close();
	} catch (Exception e) {
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Dashboard - Car Rental</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
body {
	background-color: #f4f7f6;
	font-family: 'Poppins', sans-serif;
	color: #333;
}

.navbar {
	background-color: #007bff;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	z-index: 100;
	transition: background-color 0.3s ease;
	position: sticky;
	top: 0;
}

.navbar-scrolled {
	z-index: 1000;
	background-color: rgba(0, 123, 255, 0.95);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.navbar-brand, .nav-link {
	color: white !important;
	font-weight: 600;
	transition: color 0.3s ease, background-color 0.3s ease;
	margin-top: 5px;
}

.nav-link:hover {
	background-color: rgba(255, 255, 255, 0.2);
}

.nav-item.user-profile {
	background-color: #e9ecef;
	border-radius: 10px;
	border: 1px solid grey;
	padding: 1px;
	margin-left: 10px;
	margin-top: 1px;
}

.nav-item.user-profile a {
	color: #007bff !important;
}

.nav-item #lbtn {
	background-color: red;
	border-radius: 10px;
	padding: 10px;
	cursor: pointer;
}

.hero-section {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 100px 0;
	text-align: center;
}

.hero-section h1 {
	font-size: 3.5rem;
	margin-bottom: 25px;
	font-weight: 700;
}

.hero-section p {
	font-size: 1.3rem;
}

.dashboard-container {
	padding: 50px 20px;
}

.dashboard-card {
	background-color: white;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	padding: 40px;
	text-align: center;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.dashboard-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.dashboard-card i {
	font-size: 3.5rem;
	color: #007bff;
	margin-bottom: 25px;
}

.dashboard-card h3 {
	font-size: 1.6rem;
	font-weight: 600;
	margin-bottom: 12px;
	color: #2c3e50;
}

.dashboard-card p {
	font-size: 1.8rem;
	font-weight: 700;
	color: #34495e;
	margin-top: 8px;
}

.footer {
	background-color: #0056b3;
	color: white;
	text-align: center;
	padding: 30px 0;
	margin-top: 60px;
}

.footer p {
	margin: 0;
	font-size: 1rem;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="#">Customer Dashboard</a>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link" href="myRentals.jsp">My
							Rentals</a></li>
					<li class="nav-item"><a class="nav-link"
						href="availableCars.jsp">Available Cars</a></li>
					<li class="nav-item"><a class="nav-link"
						href="ProfileUpdate.jsp">Profile</a></li>
					<li class="nav-item"><a class="nav-link" id="lbtn">Logout</a></li>
					<li class="nav-item user-profile"><a class="nav-link" href="#"><%=customerName%></a></li>
				</ul>
			</div>
		</div>
	</nav>

	<section class="hero-section">
		<div class="container">
			<h1>
				Welcome Back
				<%=customerName%>!
			</h1>
			<p>Experience seamless car rental management.</p>
		</div>
	</section>

	<div class="container dashboard-container">
		<div class="row g-4">
			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-car"></i>
					<h3>Total Rentals</h3>
					<p><%=totalRentals%></p>
				</div>
			</div>
			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-check-circle"></i>
					<h3>Active Rentals</h3>
					<p><%=activeRentals%></p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-car-side"></i>
					<h3>Cars Available</h3>
					<p><%=carsAvailable%></p>
				</div>
			</div>
		</div>
	</div>

	<footer class="footer">
		<p>&copy; 2025 Car Rental Dashboard | All Rights Reserved</p>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
const logoutBtn = document.getElementById("lbtn");

logoutBtn.addEventListener("click", function(event) {
  event.preventDefault(); 

  Swal.fire({
    title: "Are you sure you want to logout?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, logout!",
    cancelButtonText: "No, cancel",
  }).then((result) => {
    if (result.isConfirmed) {
      window.location.replace("login.jsp");
    }
  });
});
</script>
</body>
</html>
