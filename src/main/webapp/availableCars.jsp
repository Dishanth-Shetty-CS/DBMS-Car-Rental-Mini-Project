<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Cars</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background-color: #e3f2fd; 
           font-family: 'Poppins', sans-serif;
            color: #333;
            padding: 30px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px;
            overflow: auto; 
            scrollbar-width: thin;
            scrollbar-color: #2196f3 #e3f2fd; 
        }
        h2 {
            color: #1e88e5; 
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
            font-size: 2.5em;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.08);
            border-radius: 8px;
            overflow: auto; 
            scrollbar-width: thin;
            scrollbar-color: #2196f3 #f9f9f9; 
        }
        .table th, .table td {
            padding: 15px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid #e0e0e0;
        }
        .table thead {
            background-color: #1976d2; 
            color: white;
            font-weight: 500;
        }
        .table th {
            font-size: 0.95em;
        }
        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .table tbody tr:hover {
            background-color: #f0f8ff; 
        }
        .rent-btn {
            background-color: #2196f3;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            font-weight: 500;
            font-size: 0.9em;
        }
        .rent-btn:hover {
            background-color: #1976d2;
        }
        .rent-form {
            display: inline-block;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 90%;
            max-width: 500px;
            border-radius: 8px;
            position: relative;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            animation: fadeIn 0.3s;
        }
        @keyframes fadeIn {
          from {opacity: 0; transform: translateY(-50px);}
          to {opacity: 1; transform: translateY(0);}
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 15px;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
        }
        .modal h2 {
            color: #1e88e5;
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 1.8rem;
        }
        .form-control {
            border: 2px solid #a8cfff;
            border-radius: 6px;
            padding: 10px 12px;
            margin-bottom: 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 6px;
            display: block;
            font-size: 14px;
        }
        .link-text {
            text-align: center;
            margin-top: 15px;
        }
        .link-text a {
            color: #0d6efd;
            text-decoration: none;
        }
        .link-text a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 5px;
            display: block;
        }
        .error-border {
            border-color: red !important;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4"><i class="fas fa-car me-2"></i> Available Cars</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th><i class="fas fa-id-card me-1"></i> Car Reg No</th>
                <th><i class="fas fa-car-alt me-1"></i> Model</th>
                <th><i class="fas fa-calendar-alt me-1"></i> Year</th>
                <th><i class="fas fa-paint-brush me-1"></i> Color</th>
                <th><i class="fas fa-traffic-light me-1"></i> Status</th>
                <th><i class="fas fa-handshake me-1"></i> Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

                    String query = "SELECT * FROM CAR WHERE Car_Status = 'Available'";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    boolean hasAvailableCars = false;
                    while (rs.next()) {
                        hasAvailableCars = true;
                        String regNo = rs.getString("Car_Regno");
                        String model = rs.getString("Car_Model");
                        int year = rs.getInt("Car_Year");
                        String color = rs.getString("Car_Color");
                        String status = rs.getString("Car_Status");
            %>
            <tr>
                <td><%= regNo %></td>
                <td><%= model %></td>
                <td><%= year %></td>
                <td><%= color %></td>
                <td><span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> <%= status %></span></td>
                <td>
                    <button class="rent-btn" onclick="openModal('<%= regNo %>', '<%= status %>')"><i class="fas fa-key me-1"></i> Rent Now</button>
                </td>
            </tr>
            <%
                    }
                    if (!hasAvailableCars) {
                        out.println("<tr><td colspan='6' class='text-center text-muted'><i class='fas fa-car-crash me-2'></i> No cars currently available.</td></tr>");
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6' class='text-danger'><i class='fas fa-exclamation-triangle me-2'></i> Error fetching data!</td></tr>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</div>

<div id="rentModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2><i class="fas fa-handshake me-2"></i> Rent Car</h2>
        <form action="processRent" method="post" id="rental">
            <input type="hidden" name="carRegno" id="modalCarRegno">
            <input type="hidden" name="rentalStatus" id="modalRentalStatus">

            <div class="mb-3">
                <label for="rentalName" class="form-label"><i class="fas fa-file-signature me-1"></i> Rental Name</label>
                <select name="rentalName" id="rentalName" class="form-control" >
                    <option value="" disabled selected>Select Rental Type</option>
                    <option value="Business Lease">Business Lease</option>
                    <option value="Corporate Rental">Corporate Rental</option>
                    <option value="Personal Trip">Personal Trip</option>
                    <option value="Travel Agency">Travel Agency</option>
                    <option value="Event Rental">Event Rental</option>
                    <option value="VIP Service">VIP Service</option>
                    <option value="Government Contract">Government Contract</option>
                    <option value="Luxury Chauffeur">Luxury Chauffeur</option>
                    <option value="Long-Term Lease">Long-Term Lease</option>
                    <option value="Ride Sharing Partner">Ride Sharing Partner</option>
                </select>
                <div id="rentalName-error" class="error-message"></div>
            </div>

            <div class="mb-3">
                <label for="rentStartDate" class="form-label"><i class="fas fa-calendar-alt me-1"></i> Start Date</label>
                <input type="date" name="rentStartDate" id="rentStartDate" class="form-control" >
                <div id="rentStartDate-error" class="error-message"></div>
            </div>

            <div class="mb-3">
                <label for="rentEndDate" class="form-label"><i class="fas fa-calendar-check me-1"></i> End Date</label>
                <input type="date" name="rentEndDate" id="rentEndDate" class="form-control" >
                <div id="rentEndDate-error" class="error-message"></div>
            </div>

            <button type="submit" class="btn btn-primary"><i class="fas fa-check me-1"></i> Submit Rental</button>
        </form>
    </div>
</div>


<script>
    function openModal(regNo, status) {
        document.getElementById('modalCarRegno').value = regNo;
        document.getElementById('modalRentalStatus').value = status;
        document.getElementById('rentModal').style.display = "block";
    }

    function closeModal() {
        document.getElementById('rentModal').style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == document.getElementById('rentModal')) {
            closeModal();
        }
    }



    const rentalForm = document.getElementById("rental");
    const rentalNameInput = document.getElementById("rentalName");
    const rentStartDateInput = document.getElementById("rentStartDate");
    const rentEndDateInput = document.getElementById("rentEndDate");

    const rentalNameError = document.getElementById("rentalName-error");
    const rentStartDateError = document.getElementById("rentStartDate-error");
    const rentEndDateError = document.getElementById("rentEndDate-error");


    function validateRentalName() {
        const rentalNameValue = rentalNameInput.value.trim();
        if (rentalNameValue === "") {
            rentalNameError.textContent = "Please select a rental type";
            rentalNameInput.classList.add("error-border");
            return false;
        } else {
            rentalNameError.textContent = "";
            rentalNameInput.classList.remove("error-border");
            return true;
        }
    }

    function validateStartDate() {
        const startDateValue = rentStartDateInput.value;
        const today = new Date().toISOString().split("T")[0];

        if (startDateValue === "") {
            rentStartDateError.textContent = "Please enter start date";
            rentStartDateInput.classList.add("error-border");
            return false;
        } else if (startDateValue < today) {
            rentStartDateError.textContent = "Start date must be future or current date";
            rentStartDateInput.classList.add("error-border");
            return false;
        } else {
            rentStartDateError.textContent = "";
            rentStartDateInput.classList.remove("error-border");
            return true;
        }
    }

    function validateEndDate() {
        const endDateValue = rentEndDateInput.value;
        const startDateValue = rentStartDateInput.value;

        if (endDateValue === "") {
            rentEndDateError.textContent = "Please enter end date";
            rentEndDateInput.classList.add("error-border");
            return false;
        } else if (startDateValue && endDateValue < startDateValue) {
            rentEndDateError.textContent = "End date must be after start date";
            rentEndDateInput.classList.add("error-border");
            return false;
        } else {
            rentEndDateError.textContent = "";
            rentEndDateInput.classList.remove("error-border");
            return true;
        }
    }



    rentalNameInput.addEventListener("input", validateRentalName);
    rentStartDateInput.addEventListener("input", validateStartDate);
    rentEndDateInput.addEventListener("input", validateEndDate);


    rentalForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const isRentalNameValid = validateRentalName();
        const isStartDateValid = validateStartDate();
        const isEndDateValid = validateEndDate();

        if (isRentalNameValid && isStartDateValid && isEndDateValid) {
             fetch('processRent', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(new FormData(rentalForm)),
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(errorData => {
                        throw new Error(errorData.message || 'Failed to process rental');
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    Swal.fire({
                        title: "Rental Successful!",
                        text:  "Rental successfully inserted! Your Rental ID is : " + data.rentalId,
                        icon: "success",
                    }).then(() => {
                         window.location.href = "payments.jsp?rentalId=" + data.rentalId;
                    });
                   
                } else {
                    Swal.fire({
                        title: "Error",
                        text: data.message || "An error occurred",
                        icon: "error",
                    });
                }
            })
            .catch(error => {
                console.error("Error:", error);
                 Swal.fire({
                        title: "Error",
                        text: error.message || "An unexpected error occurred",
                        icon: "error",
                    });
            });
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
