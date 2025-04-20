<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Response</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<script>
    var status = "<%= request.getParameter("status") %>";
    var message = "<%= request.getParameter("message") %>";

    Swal.fire({
        icon: status === "success" ? "success" : "error",
        title: status === "success" ? "Success!" : "Error!",
        text: message
    }).then(() => {
        window.location.href = "customerForm.jsp";
    });
</script>

</body>
</html>
