<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rental Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
   	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #e3f2fd;
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 30px;
        }
        .rentals-container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.1);
            text-align: left;
            width: 100%;
            max-width: 1600px; 
            overflow-x: auto;
        }
        h3 {
            color: #1e88e5; 
            margin-bottom: 30px;
            text-align: center;
            font-size: 2.2em;
            font-weight: 600;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.08);
            border-radius: 8px;
            overflow: hidden;
        }
        .table thead {
            background-color: #1976d2; 
            color: white;
            font-weight: 500;
        }
        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            vertical-align: middle;
            border-bottom: 1px solid #e0e0e0;
        }
        .table th {
            font-size: 0.95em;
        }
        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .table tbody tr:hover {
            background-color: #f0f8ff; 
        }
        .status-cell {
            width: 120px;
            text-align: center;
        }
        .badge {
            border-radius: 20px;
            padding: 8px 12px;
            font-size: 0.85em;
            font-weight: 400;
            color: white !important;
        }
        .completed-status {
            background-color: #6c757d !important;
            width: 120px; 
            padding: 10px;
        }
        .available-status {
            background-color: #28a745 !important; 
            width: 120px; 
            padding: 10px;
        }
        .ongoing-status {
            background-color: #ffc107 !important; 
            color: #fff !important; 
            width: 120px; 
            padding: 10px;
        }
        .cancelled-status {
            background-color: #dc3545 !important; 
            width: 120px; 
            padding: 10px;
        }
        .error-message {
            color: #f44336;
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="rentals-container">
        <h3><i class="fas fa-car-rental me-2"></i> My Rentals</h3>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th><i class="fas fa-hashtag me-1"></i> Rental ID</th>
                    <th><i class="fas fa-signature me-1"></i> Rental Name</th>
                    <th><i class="fas fa-calendar-alt me-1"></i> Start Date</th>
                    <th><i class="fas fa-calendar-check me-1"></i> End Date</th>
                    <th class="status-cell"><i class="fas fa-info-circle me-1"></i> Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String customerID = (String) session.getAttribute("customerID");
                    if (customerID == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

                        String query = "SELECT Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status FROM RENTAL WHERE Cust_ID = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, customerID);
                        rs = stmt.executeQuery();

                        boolean hasRentals = false;
                        while (rs.next()) {
                            hasRentals = true;
                            int rentalID = rs.getInt("Rental_ID");
                            String rentalName = rs.getString("Rental_Name");
                            String startDate = rs.getString("Rent_Start_Date");
                            String endDate = rs.getString("Rent_End_Date");
                            String status = rs.getString("Rental_Status");
                %>
                <tr>
                    <td><%= rentalID %></td>
                    <td><%= rentalName == null || rentalName.isEmpty() ? "<i class='fas fa-minus-circle text-muted'></i> No Name" : rentalName %></td>
                    <td><%= startDate %></td>
                    <td><%= endDate %></td>
                    <td class="status-cell">
                        <% if ("Completed".equalsIgnoreCase(status)) { %>
                            <span class="badge completed-status"><i class="fas fa-check-circle me-1"></i> Completed</span>
                        <% } else if ("Available".equalsIgnoreCase(status)) { %>
                            <span class="badge available-status"><i class="fas fa-check me-1"></i> Available</span>
                        <% } else if ("Ongoing".equalsIgnoreCase(status)) { %>
                            <span class="badge ongoing-status"><i class="fas fa-play-circle me-1"></i> Ongoing</span>
                        <% } else if ("Cancelled".equalsIgnoreCase(status)) { %>
                            <span class="badge cancelled-status"><i class="fas fa-ban me-1"></i> Cancelled</span>
                        <% } else { %>
                            <span class="badge bg-warning"><i class="fas fa-question-circle me-1"></i> <%= status %></span>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                        if (!hasRentals) {
                            out.println("<tr><td colspan='5' class='text-center text-muted'><i class='fas fa-box-open me-2'></i> No rentals found.</td></tr>");
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='text-danger error-message'><i class='fas fa-exclamation-triangle me-2'></i> Error fetching data!</td></tr>");
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>