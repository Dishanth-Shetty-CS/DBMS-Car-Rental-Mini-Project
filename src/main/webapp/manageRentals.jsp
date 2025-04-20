<%-- manageRentals.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Rentals</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            font-family: 'Poppins', sans-serif;
        }
        .container {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            margin-top: 20px;
        }
        .table-container {
            overflow-y: auto; 
            border-radius: 8px;
            scrollbar-width: thin;
            scrollbar-color: #007bff #f8f9fa;
            max-height: 500px; 
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        .table {
            min-width: 1200px; 
            border-collapse: collapse;
        }
        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }
        .table tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }
        .table tbody tr:hover {
            background-color: #e9ecef;
            transition: 0.3s;
        }
        .table td, .table th {
            padding: 12px;
            border: 1px solid #dee2e6;
            text-align: center;
        }
        .btn-action {
            margin: 5px;
            padding: 8px 12px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
        .btn-danger {
            background: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background: #c82333;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center text-primary fw-bold mb-3">Manage Rentals</h2>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Rental ID</th>
                        <th>Rental Name</th>
                        <th>Rent Start Date</th>
                        <th>Rent End Date</th>
                        <th>Rental Status</th>
                        <th>Customer ID</th>
                        <th>Car Reg No</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% Connection connection = null;
                       PreparedStatement preparedStatement = null;
                       ResultSet resultSet = null;
                       try {
                           Class.forName("com.mysql.cj.jdbc.Driver");
                           connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
                           String query = "SELECT Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_ID, Car_Regno FROM Rental";
                           preparedStatement = connection.prepareStatement(query);
                           resultSet = preparedStatement.executeQuery();
                           while (resultSet.next()) { %>
                    <tr>
                        <td><%= resultSet.getInt("Rental_ID") %></td>
                        <td><%= resultSet.getString("Rental_Name") %></td>
                        <td><%= resultSet.getDate("Rent_Start_Date") %></td>
                        <td><%= resultSet.getDate("Rent_End_Date") %></td>
                        <td><%= resultSet.getString("Rental_Status") %></td>
                        <td><%= resultSet.getInt("Cust_ID") %></td>
                        <td><%= resultSet.getString("Car_Regno") %></td>
                        <td>
                            <button class="btn btn-primary btn-action btn-sm" onclick="window.location.href='UpdateRentalServlet?id=<%= resultSet.getInt("Rental_ID") %>'">Update</button>
                            <button class="btn btn-danger btn-action btn-sm" onclick="confirmDelete('<%= resultSet.getInt("Rental_ID") %>')">Delete</button>
                        </td>
                    </tr>
                    <% } } catch (Exception e) { e.printStackTrace();
                       } finally {
                           try { if (resultSet != null) resultSet.close(); } catch (Exception e) {}
                           try { if (preparedStatement != null) preparedStatement.close(); } catch (Exception e) {}
                           try { if (connection != null) connection.close(); } catch (Exception e) {}
                       } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function confirmDelete(rentalId) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    deleteRental(rentalId);
                }
            });
        }

        function deleteRental(rentalId) {
            fetch('DeleteRentalServlet?id=' + rentalId)
                .then(response => response.text())
                .then(text => {
                    if (text === "success") {
                        Swal.fire(
                            'Deleted!',
                            'Rental has been deleted.',
                            'success'
                        ).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire(
                            'Error!',
                            'Failed to delete rental.',
                            'error'
                        );
                    }
                })
                .catch(error => {
                    Swal.fire(
                        'Error!',
                        error.message,
                        'error'
                    );
                });
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>