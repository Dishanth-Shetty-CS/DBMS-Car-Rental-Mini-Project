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

@WebServlet("/UpdateCarActionServlet")
public class UpdateCarActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carRegno = request.getParameter("carRegno");
        String carModel = request.getParameter("carModel");
        int carYear = Integer.parseInt(request.getParameter("carYear"));
        String carColor = request.getParameter("carColor");
        String carStatus = request.getParameter("carStatus");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
            String query = "UPDATE Car SET Car_Model = ?, Car_Year = ?, Car_Color = ?, Car_Status = ? WHERE Car_Regno = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, carModel);
            preparedStatement.setInt(2, carYear);
            preparedStatement.setString(3, carColor);
            preparedStatement.setString(4, carStatus);
            preparedStatement.setString(5, carRegno);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
            	response.sendRedirect("ManageCars.jsp");
            } else {
                response.getWriter().print("Failed to update car.");
            }

            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().print("Error updating car.");
        }
    }
}