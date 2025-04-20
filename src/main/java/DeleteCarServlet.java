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

@WebServlet("/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carRegno = request.getParameter("id");

        if (carRegno == null || carRegno.isEmpty()) {
            response.getWriter().print("failure");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
            connection.createStatement().execute("SET FOREIGN_KEY_CHECKS=0");
            String deleteRentals = "DELETE FROM Rental WHERE Car_Regno = ?";
            PreparedStatement deleteRentalsStmt = connection.prepareStatement(deleteRentals);
            deleteRentalsStmt.setString(1, carRegno);
            deleteRentalsStmt.executeUpdate();
            deleteRentalsStmt.close();
            String query = "DELETE FROM Car WHERE Car_Regno = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, carRegno);
            int rowsAffected = preparedStatement.executeUpdate();
            connection.createStatement().execute("SET FOREIGN_KEY_CHECKS=1");

            if (rowsAffected > 0) {
                response.getWriter().print("success");
            } else {
                response.getWriter().print("failure");
            }

            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().print("error");
        }
    }
}
