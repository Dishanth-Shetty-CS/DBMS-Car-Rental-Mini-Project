<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Location Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
   <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
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
            min-width: 600px; 
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
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center text-primary fw-bold mb-3">Location Details</h2>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Location ID</th>
                        <th>Location Name</th>
                        <th>City</th>
                        <th>State</th>
                        <th>Zipcode</th>
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

                            String query = "SELECT Loc_ID, Loc_Name, Loc_City, Loc_State, Loc_Zipcode FROM Location";
                            preparedStatement = connection.prepareStatement(query);
                            resultSet = preparedStatement.executeQuery();

                            while (resultSet.next()) {
                                int locId = resultSet.getInt("Loc_ID");
                                String locName = resultSet.getString("Loc_Name");
                                String locCity = resultSet.getString("Loc_City");
                                String locState = resultSet.getString("Loc_State");
                                String locZipcode = resultSet.getString("Loc_Zipcode");
                    %>
                    <tr>
                        <td><%= locId %></td>
                        <td><%= locName %></td>
                        <td><%= locCity %></td>
                        <td><%= locState %></td>
                        <td><%= locZipcode %></td>
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