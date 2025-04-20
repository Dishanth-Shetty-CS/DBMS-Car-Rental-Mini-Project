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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("Cust_ID");
        String email = request.getParameter("Cust_Email");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

            String query = "SELECT Cust_ID FROM Customer WHERE Cust_ID = ? AND Cust_Email = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, customerID);
            preparedStatement.setString(2, email);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int retrievedCustomerID = resultSet.getInt("Cust_ID");
                HttpSession session = request.getSession();
                session.setAttribute("customerID", String.valueOf(retrievedCustomerID)); // Store as String
                session.setMaxInactiveInterval(300);

                //System.out.println("Login successful. Cust_ID: " + retrievedCustomerID);
                response.getWriter().write("Login successful");
            } else {
                //System.out.println("Login failed for Cust_ID: " + customerID + ", Email: " + email);
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