<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Cars</title>
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
        }
        .table-container {
            overflow-x: auto;
            overflow-y: auto;
            max-height: 500px;
            border-radius: 8px;
            scrollbar-width: thin;
            scrollbar-color: #007bff #f8f9fa;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        .table {
            min-width: 1000px;
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
        <h2 class="text-center text-primary fw-bold mb-3">Manage Cars</h2>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Car Reg No</th>
                        <th>Car Model</th>
                        <th>Car Year</th>
                        <th>Car Color</th>
                        <th>Car Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

                            String query = "SELECT Car_Regno, Car_Model, Car_Year, Car_Color, Car_Status FROM Car";
                            preparedStatement = connection.prepareStatement(query);
                            resultSet = preparedStatement.executeQuery();

                            while (resultSet.next()) {
                                String carRegno = resultSet.getString("Car_Regno");
                                String carModel = resultSet.getString("Car_Model");
                                int carYear = resultSet.getInt("Car_Year");
                                String carColor = resultSet.getString("Car_Color");
                                String carStatus = resultSet.getString("Car_Status");
                    %>
                    <tr>
                        <td><%= carRegno %></td>
                        <td><%= carModel %></td>
                        <td><%= carYear %></td>
                        <td><%= carColor %></td>
                        <td><%= carStatus %></td>
                        <td>
                            <button class="btn btn-primary btn-action" onclick="window.location.href='UpdateCarServlet?id=<%= carRegno %>'">Update</button>
                            <button class="btn btn-danger btn-action" onclick="confirmDelete('<%= carRegno %>')">Delete</button>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (resultSet != null) resultSet.close(); } catch (Exception e) {}
                            try { if (preparedStatement != null) preparedStatement.close(); } catch (Exception e) {}
                            try { if (connection != null) connection.close(); } catch (Exception e) {}
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function confirmDelete(carRegno) {
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
                    deleteCar(carRegno);
                }
            });
        }

        function deleteCar(carRegno) {
            fetch('DeleteCarServlet?id=' + encodeURIComponent(carRegno))
                .then(response => response.text())
                .then(text => {
                    if (text === "success") {
                        Swal.fire(
                            'Deleted!',
                            'Car has been deleted.',
                            'success'
                        ).then(() => {
                            window.location.reload();
                        });
                    } else if (text === "notfound") {
                        Swal.fire(
                            'Not Found!',
                            'Car does not exist in the database.',
                            'warning'
                        );
                    } else {
                        Swal.fire(
                            'Error!',
                            'Failed to delete car.',
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