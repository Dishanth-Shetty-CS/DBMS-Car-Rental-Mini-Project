import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdToDelete = request.getParameter("id");

        if (customerIdToDelete == null || customerIdToDelete.isEmpty()) {
            response.getWriter().print("invalid_id");
            return;
        }

        Connection connection = null;
        PreparedStatement disableFKCheck = null;
        PreparedStatement deleteStmt = null;
        PreparedStatement enableFKCheck = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
            String disableFKCheckQuery = "SET FOREIGN_KEY_CHECKS = 0;";
            disableFKCheck = connection.prepareStatement(disableFKCheckQuery);
            disableFKCheck.executeUpdate();
            String deleteQuery = "DELETE FROM Customer WHERE Cust_ID = ?";
            deleteStmt = connection.prepareStatement(deleteQuery);
            deleteStmt.setString(1, customerIdToDelete);
            int rowsAffected = deleteStmt.executeUpdate();

            if (rowsAffected > 0) {
                response.getWriter().print("success");
            } else {
                response.getWriter().print("failure");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().print("error_during_deletion");
        } finally {
            try {
                if (connection != null) {
                    String enableFKCheckQuery = "SET FOREIGN_KEY_CHECKS = 1;";
                    enableFKCheck = connection.prepareStatement(enableFKCheckQuery);
                    enableFKCheck.executeUpdate();
                }
                if (disableFKCheck != null) disableFKCheck.close();
                if (deleteStmt != null) deleteStmt.close();
                if (enableFKCheck != null) enableFKCheck.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().print("error_reenabling_fk");
            }
        }
    }
}