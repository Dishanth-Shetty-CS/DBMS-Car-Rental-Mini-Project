import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;

@WebServlet("/UpdateRentalActionServlet")
public class UpdateRentalActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int rentalId = Integer.parseInt(request.getParameter("rentalId"));
        String rentalName = request.getParameter("rentalName");
        String rentStartDateStr = request.getParameter("rentStartDate");
        String rentEndDateStr = request.getParameter("rentEndDate");
        String rentalStatus = request.getParameter("rentalStatus");
        int custId = Integer.parseInt(request.getParameter("custId"));
        String carRegno = request.getParameter("carRegno");

        Date rentStartDate = Date.valueOf(rentStartDateStr);
        Date rentEndDate = Date.valueOf(rentEndDateStr);

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
            String query = "UPDATE Rental SET Rental_Name = ?, Rent_Start_Date = ?, Rent_End_Date = ?, Rental_Status = ?, Cust_ID = ?, Car_Regno = ? WHERE Rental_ID = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, rentalName);
            preparedStatement.setDate(2, rentStartDate);
            preparedStatement.setDate(3, rentEndDate);
            preparedStatement.setString(4, rentalStatus);
            preparedStatement.setInt(5, custId);
            preparedStatement.setString(6, carRegno);
            preparedStatement.setInt(7, rentalId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("manageRentals.jsp?message=Rental updated successfully");
            } else {
                response.getWriter().println("Failed to update rental.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) {}
            try { if (connection != null) connection.close(); } catch (SQLException e) {}
        }
    }
}