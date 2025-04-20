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

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String customerID = (String) session.getAttribute("customerID");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

            String sql = "SELECT Cust_Name, Cust_Address, Cust_Phone, Cust_Email FROM CUSTOMER WHERE Cust_ID = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, customerID);

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("Cust_Name");
                String address = resultSet.getString("Cust_Address");
                String phone = resultSet.getString("Cust_Phone");
                String email = resultSet.getString("Cust_Email");

                // Set attributes to be used in JSP
                request.setAttribute("Cust_Name", name);
                request.setAttribute("Cust_Address", address);
                request.setAttribute("Cust_Phone", phone);
                request.setAttribute("Cust_Email", email);
                request.setAttribute("Cust_ID", customerID);

                request.getRequestDispatcher("profile.jsp").forward(request, response); // Forward to your profile.jsp
            } else {
                response.getWriter().write("Customer details not found.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred: " + e.getMessage());
        } finally {
            try { if (resultSet != null) resultSet.close(); } catch (SQLException e) {}
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) {}
            try { if (connection != null) connection.close(); } catch (SQLException e) {}
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String customerID = (String) session.getAttribute("customerID");

        String name = request.getParameter("Cust_Name");
        String address = request.getParameter("Cust_Address");
        String phone = request.getParameter("Cust_Phone");
        String email = request.getParameter("Cust_Email");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

            String sql = "UPDATE CUSTOMER SET Cust_Name = ?, Cust_Address = ?, Cust_Phone = ?, Cust_Email = ? WHERE Cust_ID = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, address);
            preparedStatement.setString(3, phone);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, customerID);

            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
            	 response.getWriter().write("Updated");
            } else {
            	response.getWriter().write("Failed");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred: " + e.getMessage());
        } finally {
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) {}
            try { if (connection != null) connection.close(); } catch (SQLException e) {}
        }
    }
}