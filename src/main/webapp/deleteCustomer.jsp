<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    String customerId = request.getParameter("id");
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

        String query = "DELETE FROM Customer WHERE Cust_ID = ?";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, customerId);

        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            out.print("success"); 
        } else {
            out.print("failure"); 
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("error"); 
    } finally {
        try { if (preparedStatement != null) preparedStatement.close(); } catch (Exception e) {}
        try { if (connection != null) connection.close(); } catch (Exception e) {}
    }
%>