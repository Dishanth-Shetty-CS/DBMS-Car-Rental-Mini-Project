<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%
HttpSession currentSession = request.getSession(false);
if (currentSession == null) {
	response.sendRedirect("AdminLogin.jsp");
	return;
}

String adminID = (String) currentSession.getAttribute("adminID");
if (adminID == null) {
	response.sendRedirect("AdminLogin.jsp");
	return;
}

Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;

int totalCars = 0;
int totalCustomers = 0;
int totalRentals = 0;
int activeRentals = 0;
int pendingReturns = 0;
double totalRevenue = 0.0;
String adminName = (String) currentSession.getAttribute("adminName"); //changed

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

	// Get Total Cars
	String totalCarsQuery = "SELECT COUNT(*) FROM CAR";
	preparedStatement = connection.prepareStatement(totalCarsQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		totalCars = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	// Get Total Customers
	String totalCustomersQuery = "SELECT COUNT(*) FROM Customer";
	preparedStatement = connection.prepareStatement(totalCustomersQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		totalCustomers = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	// Get Total Rentals
	String totalRentalsQuery = "SELECT COUNT(*) FROM Rental";
	preparedStatement = connection.prepareStatement(totalRentalsQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		totalRentals = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	// Get Active Rentals (Assuming 'Ongoing' status)
	String activeRentalsQuery = "SELECT COUNT(*) FROM Rental WHERE Rental_Status = 'Ongoing'";
	preparedStatement = connection.prepareStatement(activeRentalsQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		activeRentals = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	// Get Pending Returns (Assuming a status like 'Out' and end date passed)
	String pendingReturnsQuery = "SELECT COUNT(*) FROM Rental WHERE Rental_Status = 'Out' AND Rent_End_Date < CURDATE()";
	preparedStatement = connection.prepareStatement(pendingReturnsQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		pendingReturns = resultSet.getInt(1);
	}
	if (resultSet != null)
		resultSet.close();
	if (preparedStatement != null)
		preparedStatement.close();

	String totalRevenueQuery = "SELECT SUM(Amount_Paid) FROM Payment WHERE Payment_Status = 'Successful'";
	preparedStatement = connection.prepareStatement(totalRevenueQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		totalRevenue = resultSet.getDouble(1);
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
<title>Admin Dashboard - Car Rental</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
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
			<a class="navbar-brand" href="#">Admin Dashboard</a>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link" href="ManageCars.jsp">Manage
							Cars</a></li>
					<li class="nav-item"><a class="nav-link"
						href="manageRentals.jsp">Manage Rentals</a></li>
					<li class="nav-item"><a class="nav-link"
						href="ManageCustomers.jsp">Manage Customers</a></li>
					<li class="nav-item"><a class="nav-link"
						href="ManageLocations.jsp">Manage Locations</a></li>
					<li class="nav-item"><a class="nav-link logout-button"
						id="lbtn">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<section class="hero-section">
		<div class="container">
			<h1>
				Welcome Back
				<%= adminName %>!
			</h1>
			<p>Manage all aspects of your car rental business efficiently.</p>
		</div>
	</section>

	<div class="container dashboard-container">
		<div class="row g-4">
			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-car"></i>
					<h3>Total Cars</h3>
					<p><%=totalCars%></p>
				</div>
			</div>
			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-users"></i>
					<h3>Total Customers</h3>
					<p><%=totalCustomers%></p>
				</div>
			</div>
			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-chart-line"></i>
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
					<i class="fas fa-exclamation-triangle"></i>
					<h3>Pending Returns</h3>
					<p><%=pendingReturns%></p>
				</div>
			</div>
			<div class="col-md-4">
				<div class="dashboard-card">
					<i class="fas fa-dollar-sign"></i>
					<h3>Total Revenue</h3>
					<p>
						&#8377;
						<%=String.format("%,.2f", totalRevenue)%></p>
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
			event.preventDefault(); // Prevent the default behavior of the link

			Swal.fire({
				title : "Are you sure you want to logout?",
				icon : "warning",
				showCancelButton : true,
				confirmButtonColor : "#3085d6",
				cancelButtonColor : "#d33",
				confirmButtonText : "Yes, logout!",
				cancelButtonText : "No, cancel",
			}).then((result) => {
				if (result.isConfirmed) {
					window.location.replace("AdminLogin.jsp");
				}
			});
		});
	</script>
</body>
</html>
