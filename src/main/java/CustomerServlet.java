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

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/car_rental_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "trickortreat";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String custName = request.getParameter("Cust_Name");
        String custAddress = request.getParameter("Cust_Address");
        String custPhone = request.getParameter("Cust_Phone");
        String custEmail = request.getParameter("Cust_Email");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO customer (Cust_Name, Cust_Address, Cust_Phone, Cust_Email) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, custName);
            stmt.setString(2, custAddress);
            stmt.setString(3, custPhone);
            stmt.setString(4, custEmail);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int newCustomerId = generatedKeys.getInt(1);
                    response.getWriter().write("{\"status\":\"success\", \"message\":\"Customer added successfully!\", \"customerId\":\"" + newCustomerId + "\"}");
                }
                else{
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Customer added successfully! but couldn't retrieve customer ID\"}");
                }
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Failed to add customer.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Error: " + e.getMessage() + "\"}");
        } finally {
            try { if (generatedKeys != null) generatedKeys.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}
