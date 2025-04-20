import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/processRent")
public class processRent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Session expired. Please log in again.\"}");
            return;
        }

        String customerID = (String) session.getAttribute("customerID");
        if (customerID == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Customer ID not found. Please log in again.\"}");
            return;
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

            String rentalName = request.getParameter("rentalName");
            String rentStartDate = request.getParameter("rentStartDate");
            String rentEndDate = request.getParameter("rentEndDate");
            String rentalStatus = request.getParameter("rentalStatus");
            String carRegno = request.getParameter("carRegno");

            if (rentalName == null || rentStartDate == null || rentEndDate == null || rentalStatus == null || carRegno == null) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"All fields are required.\"}");
                return;
            }

            String query = "INSERT INTO RENTAL (Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_ID, Car_Regno) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS); // Important: Get generated keys
            preparedStatement.setString(1, rentalName);
            preparedStatement.setString(2, rentStartDate);
            preparedStatement.setString(3, rentEndDate);
            preparedStatement.setString(4, rentalStatus);
            preparedStatement.setString(5, customerID);
            preparedStatement.setString(6, carRegno);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                generatedKeys = preparedStatement.getGeneratedKeys(); 
                if (generatedKeys.next()) {
                    int rentalId = generatedKeys.getInt(1); 
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\":\"success\", \"message\":\"Rental successful.\", \"rentalId\":\"" + rentalId + "\"}");
                } else {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Rental failed: No Rental ID generated.\"}");
                }
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Rental failed: No rows inserted.\"}");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Rental failed: " + e.getMessage() + "\"}");
        } finally {
            try { if (generatedKeys != null) generatedKeys.close(); } catch (SQLException e) {}
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) {}
            try { if (connection != null) connection.close(); } catch (SQLException e) {}
        }
    }
}
