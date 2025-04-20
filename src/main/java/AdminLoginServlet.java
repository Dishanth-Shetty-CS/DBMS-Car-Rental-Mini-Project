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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminID = request.getParameter("Admin_ID");
        String email = request.getParameter("Admin_Email");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

            String query = "SELECT Admin_ID, Admin_Name FROM Administrator WHERE Admin_ID = ? AND Admin_Email = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, adminID);
            preparedStatement.setString(2, email);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String retrievedAdminID = resultSet.getString("Admin_ID");
                String adminName = resultSet.getString("Admin_Name"); 
                HttpSession session = request.getSession();
                session.setAttribute("adminID", retrievedAdminID); 
                session.setAttribute("adminName", adminName);   
                session.setMaxInactiveInterval(300);

                //System.out.println("Admin login successful. Admin_ID: " + retrievedAdminID + ", Admin_Name: " + adminName);
                response.getWriter().write("Login successful");
            } else {
                //System.out.println("Admin login failed for Admin_ID: " + adminID + ", Email: " + email);
                response.getWriter().write("Login failed");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.err.println("Database error: " + e.getMessage());
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            try { if (resultSet != null) resultSet.close(); } catch (SQLException e) {}
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) {}
            try { if (connection != null) connection.close(); } catch (SQLException e) {}
        }
    }
}
