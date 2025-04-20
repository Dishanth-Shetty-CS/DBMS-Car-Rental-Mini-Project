import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/processPayment")
public class processPayment extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String payMethod = request.getParameter("payMethod");
        int rentalID = Integer.parseInt(request.getParameter("rentalID"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

            String query = "INSERT INTO Payment (Pay_Method, Pay_status, Rental_ID, Pay_Date_Time) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, payMethod);
            stmt.setString(2, "Completed");
            stmt.setInt(3, rentalID);
            Timestamp timestamp = new Timestamp(new Date().getTime());
            stmt.setTimestamp(4, timestamp);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                out.print("Payment successful");
            } else {
                out.print("Payment failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("Payment failed");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
