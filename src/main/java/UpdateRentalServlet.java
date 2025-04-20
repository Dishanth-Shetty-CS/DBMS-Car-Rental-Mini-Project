import java.io.IOException;
import java.io.PrintWriter;
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
import org.json.JSONObject;

@WebServlet("/UpdateRentalServlet")
public class UpdateRentalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rentalIdParam = request.getParameter("id");
        if (rentalIdParam == null || rentalIdParam.isEmpty()) {
            response.setContentType("application/json");
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("error", "Rental ID is missing.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        int rentalId;
        try {
            rentalId = Integer.parseInt(rentalIdParam);
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("error", "Invalid Rental ID.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
            String query = "SELECT Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_ID, Car_Regno FROM Rental WHERE Rental_ID = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, rentalId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String rentalName = resultSet.getString("Rental_Name");
                java.sql.Date rentStartDate = resultSet.getDate("Rent_Start_Date");
                java.sql.Date rentEndDate = resultSet.getDate("Rent_End_Date");
                String rentalStatus = resultSet.getString("Rental_Status");
                int custId = resultSet.getInt("Cust_ID");
                String carRegno = resultSet.getString("Car_Regno");
                String rentStartDateStr = (rentStartDate != null) ? rentStartDate.toString() : "";
                String rentEndDateStr = (rentEndDate != null) ? rentEndDate.toString() : "";
                request.setAttribute("rentalId", rentalId);
                request.setAttribute("rentalName", rentalName);
                request.setAttribute("rentStartDate", rentStartDateStr);
                request.setAttribute("rentEndDate", rentEndDateStr);
                request.setAttribute("rentalStatus", rentalStatus);
                request.setAttribute("custId", custId);
                request.setAttribute("carRegno", carRegno);
                request.getRequestDispatcher("/updateRentalForm.jsp").forward(request, response);
            } else {
                jsonResponse.put("error", "Rental not found.");
                out.print(jsonResponse.toString());
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            jsonResponse.put("error", "Database error: " + e.getMessage());
            out.print(jsonResponse.toString());
        }
    }
}
