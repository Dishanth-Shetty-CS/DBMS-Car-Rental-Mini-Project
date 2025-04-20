<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            font-family: 'Poppins', sans-serif;
            color: #333;
        }
        .container {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            margin-top: 20px;
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
            min-width: 800px; 
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
    <script>
    function deleteCustomer(customerId) {
        fetch('DeleteCustomerServlet?id=' + customerId)
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error('Failed to delete customer.');
                }
            })
            .then(text => {
                if (text === "success") {
                    Swal.fire(
                        'Deleted!',
                        'Customer has been deleted.',
                        'success'
                    ).then(() => {
                        window.location.reload();
                    });
                } else if (text === "failure") {
                    Swal.fire(
                        'Error!',
                        'Failed to delete customer.',
                        'error'
                    );
                } else if (text === "error") {
                    Swal.fire(
                        'Error!',
                        'An error occurred during deletion.',
                        'error'
                    );
                } else if (text === "invalid_id") {
                    Swal.fire(
                        'Error!',
                        'Invalid customer ID.',
                        'error'
                    );
                } else {
                    Swal.fire(
                        'Error!',
                        'Unknown error occurred.',
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

    function confirmDelete(customerId) {
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
                deleteCustomer(customerId);
            }
        });
    }
    </script>
</head>
<body>

    <div class="container">
        <h2 class="text-center text-primary fw-bold mb-3">Customer Management</h2>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- JSP Code to Fetch and Display Data --%>
                    <%@ page import="java.sql.*" %>
                    <%
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

                            String query = "SELECT Cust_ID, Cust_Name, Cust_Address, Cust_Phone, Cust_Email FROM Customer";
                            preparedStatement = connection.prepareStatement(query);
                            resultSet = preparedStatement.executeQuery();

                            while (resultSet.next()) {
                                String custID = resultSet.getString("Cust_ID");
                                String name = resultSet.getString("Cust_Name");
                                String address = resultSet.getString("Cust_Address");
                                String phone = resultSet.getString("Cust_Phone");
                                String email = resultSet.getString("Cust_Email");
                    %>
                    <tr>
                        <td><%= custID %></td>
                        <td><%= name %></td>
                        <td><%= address %></td>
                        <td><%= phone %></td>
                        <td><%= email %></td>
                        <td>
                            <button class="btn btn-danger btn-action" onclick="confirmDelete('<%= custID %>')">Delete</button>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>