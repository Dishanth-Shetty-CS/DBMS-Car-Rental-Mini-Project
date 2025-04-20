<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Rental - Your Journey Starts Here</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }

        header {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 15px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            border-radius: 0 0 10px 10px;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #007bff;
            transition: transform 0.3s ease-in-out;
        }

        .logo:hover {
            transform: scale(1.05);
        }

        nav ul {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            margin-left: 20px;
        }

        nav ul li a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s, transform 0.3s, background-color 0.3s;
            padding: 8px 14px;
            border-radius: 8px;
            display: inline-block;
        }

        nav ul li a:hover {
            color: #007bff;
            background-color: #e0f7fa;
            transform: translateY(-2px);
        }

        nav ul li:first-child a {
            background-color: #e0f7fa;
            color: #007bff;
            font-weight: 600;
        }

        nav ul li:first-child a:hover {
            background-color: #b2ebf2;
        }

        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                url('Resources/Pickup Truck.jpg') center/cover no-repeat;
            color: white;
            text-align: center;
            padding: 180px 5%;
            position: relative;
            border-radius: 0 0 10px 10px;
        }

        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            font-weight: 700;
        }

        .hero p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            padding: 0 10%;
            font-weight: 400;
        }

        .cta-button {
            background-color: #007bff;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            display: inline-block;
        }

        .cta-button:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
        }

        .featured-cars {
            padding: 50px 5%;
            text-align: center;
        }

        .featured-cars h2 {
            font-size: 2.2rem;
            margin-bottom: 40px;
            color: #2c3e50;
            font-weight: 700;
        }

        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .car-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            border: 1px solid #e0e0e0;
        }

        .car-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
        }

        .car-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 20px;
            transition: height 0.3s ease;
        }

        .car-item img:hover {
            height: 210px;
        }

        .car-item h3 {
            margin-bottom: 12px;
            color: #2c3e50;
            font-size: 1.3rem;
            font-weight: 600;
        }

        .car-item p {
            color: #555;
            font-size: 0.95rem;
            line-height: 1.6;
            font-weight: 400;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 25px 0;
            margin-top: 60px;
            border-top: 1px solid #495764;
            border-radius: 10px 10px 0 0;
        }

        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
                align-items: center;
                margin-top: 15px;
            }

            nav ul li {
                margin-left: 0;
                margin-top: 10px;
            }

            .hero {
                padding: 150px 5%;
            }

            .hero h1 {
                font-size: 2rem;
            }

            .hero p {
                font-size: 1rem;
                padding: 0 5%;
            }

            .car-grid {
                grid-template-columns: 1fr;
            }
            .featured-cars h2{
                font-size: 1.8rem;
            }
        }

        @media (max-width: 480px) {
            .hero h1 {
                font-size: 1.7rem;
            }

            .hero p {
                font-size: 0.9rem;
            }
            header{
                padding: 12px 5%;
            }
            .logo{
                font-size: 1.6rem;
            }
            nav ul li a{
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">CarRental</div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="login.jsp" target="_self">Login</a></li>
                <li><a href="registration.jsp" target="_self">Register</a></li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <h1>Explore the Freedom of the Road</h1>
        <p>Unlock your next journey. Find your ideal rental car now.</p>
        <a href="login.jsp" class="cta-button">Find Your Car</a>
    </section>

    <section class="featured-cars">
        <h2>Our Featured Vehicles</h2>
        <div class="car-grid">
            <div class="car-item">
                <img src="Resources/Luxury Sedan.jpg" alt="Car 1">
                <h3>Luxury Sedan</h3>
                <p>Experience ultimate comfort and style for your business or leisure trips.</p>
            </div>
            <div class="car-item">
                <img src="Resources/Premium SUV.jpg" alt="SUV">
                <h3>Premium SUV</h3>
                <p>Ideal for family adventures with ample space and rugged capability.</p>
            </div>
            <div class="car-item">
                <img src="Resources/Sports Convertible.jpg" alt="Convertible">
                <h3>Sports Convertible</h3>
                <p>Enjoy the thrill of open-air driving with a touch of elegance.</p>
            </div>
            <div class="car-item">
                <img src="Resources/Pickup Truck.jpg" alt="Pickup Truck">
                <h3>Pickup Truck</h3>
                <p>Robust and versatile, ideal for hauling and outdoor adventures.</p>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2025 CarRental. All rights reserved.</p>
    </footer>
</body>
</html>
