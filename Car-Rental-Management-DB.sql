-- Create and use the database
CREATE DATABASE car_rental_db;
USE car_rental_db;

-- Create administrator table
CREATE TABLE administrator (
  Admin_ID INT NOT NULL AUTO_INCREMENT,
  Admin_Name VARCHAR(100) NOT NULL,
  Admin_Email VARCHAR(100) NOT NULL,
  PRIMARY KEY (Admin_ID)
);

-- Create car table
CREATE TABLE car (
  Car_Regno VARCHAR(20) NOT NULL,
  Car_Model VARCHAR(255) DEFAULT NULL,
  Car_Year INT DEFAULT NULL,
  Car_Color VARCHAR(255) DEFAULT NULL,
  Car_Status VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (Car_Regno)
);

-- Create customer table
CREATE TABLE customer (
  Cust_ID INT NOT NULL AUTO_INCREMENT,
  Cust_Name VARCHAR(255) DEFAULT NULL,
  Cust_Address VARCHAR(255) DEFAULT NULL,
  Cust_Phone VARCHAR(20) DEFAULT NULL,
  Cust_Email VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (Cust_ID)
);

-- Create location table
CREATE TABLE location (
  Loc_ID INT NOT NULL AUTO_INCREMENT,
  Loc_Name VARCHAR(255) DEFAULT NULL,
  Loc_City VARCHAR(255) DEFAULT NULL,
  Loc_State VARCHAR(255) DEFAULT NULL,
  Loc_Zipcode VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (Loc_ID)
);

-- Create rental table
CREATE TABLE rental (
  Rental_ID INT NOT NULL AUTO_INCREMENT,
  Rental_Name VARCHAR(255) DEFAULT NULL,
  Rent_Start_Date DATE DEFAULT NULL,
  Rent_End_Date DATE DEFAULT NULL,
  Rental_Status VARCHAR(20) DEFAULT NULL,
  Cust_ID INT DEFAULT NULL,
  Car_Regno VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (Rental_ID),
  FOREIGN KEY (Car_Regno) REFERENCES car (Car_Regno) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create payment table
CREATE TABLE payment (
  Pay_ID INT NOT NULL AUTO_INCREMENT,
  Pay_Date_Time DATETIME DEFAULT NULL,
  Pay_Method VARCHAR(50) DEFAULT NULL,
  Pay_Status VARCHAR(20) NOT NULL DEFAULT 'NULL',
  Rental_ID INT DEFAULT NULL,
  PRIMARY KEY (Pay_ID),
  FOREIGN KEY (Rental_ID) REFERENCES rental (Rental_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert administrators
INSERT INTO administrator (Admin_Name, Admin_Email) VALUES
('Dishanth Shetty','dishanthshetty@rental.com');

-- Insert cars
INSERT INTO car (Car_Regno, Car_Model, Car_Year, Car_Color, Car_Status) VALUES
('KA01AB1234', 'Honda City', 2020, 'Red', 'Available'),
('KA02CD5678', 'Hyundai i20', 2019, 'Blue', 'Not Available'),
('KA03EF9101', 'Maruti Swift', 2021, 'White', 'Available'),
('KA04GH1121', 'Toyota Innova', 2018, 'Black', 'Not Available'),
('KA05IJ3141', 'Tata Nexon', 2022, 'Grey', 'Available'),
('KA06KL5161', 'Mahindra XUV500', 2022, 'Silver', 'Not Available'),
('KA07MN7181', 'Ford EcoSport', 2021, 'Blue', 'Available'),
('KA08OP9201', 'Renault Kwid', 2020, 'Orange', 'Not Available'),
('KA09QR1222', 'Skoda Rapid', 2019, 'White', 'Available'),
('KA10ST3242', 'Kia Seltos', 2023, 'Black', 'Not Available');

-- Insert customers
INSERT INTO customer (Cust_Name, Cust_Address, Cust_Phone, Cust_Email) VALUES
('Rahul Sharma', 'MG Road Bangalore', '9876543210', 'rahulsharma@gmail.com'),
('Anjali Mehta', 'Linking Road Mumbai', '8765432109', 'anjalimehta@gmail.com'),
('Karthik Rao', 'Rajaji Nagar Mysore', '7654321098', 'karthikrao@gmail.com'),
('Divya Suresh', 'Connaught Place Delhi', '6543210987', 'divyasuresh@gmail.com'),
('Vikram Singh', 'Park Street Kolkata', '5432109876', 'vikramsingh@gmail.com'),
('Snehal Patil', 'Hadapsar Pune', '9123456789', 'snehalpatil@gmail.com'),
('Rohan Iyer', 'Sector 62 Noida', '9234567890', 'rohaniyer@gmail.com'),
('Alisha Khan', 'Banjara Hills Hyderabad', '9345678901', 'alishakhan@gmail.com'),
('Manoj Joshi', 'Vastrapur Ahmedabad', '9456789012', 'manojjoshi@gmail.com'),
('Pooja Ramesh', 'Panaji Goa', '9567890123', 'poojaramesh@gmail.com');

-- Insert locations
INSERT INTO location (Loc_Name, Loc_City, Loc_State, Loc_Zipcode) VALUES
('Main Office', 'Bangalore', 'Karnataka', '560001'),
('West Branch', 'Mumbai', 'Maharashtra', '400001'),
('South Hub', 'Chennai', 'Tamil Nadu', '600001'),
('East Point', 'Kolkata', 'West Bengal', '700001'),
('North Yard', 'Delhi', 'Delhi', '110001'),
('Central Garage', 'Pune', 'Maharashtra', '411001'),
('Hilltop Depot', 'Shimla', 'Himachal Pradesh', '171001'),
('Riverfront Branch', 'Ahmedabad', 'Gujarat', '380001'),
('Beachside Yard', 'Goa', 'Goa', '403001'),
('IT Hub Center', 'Hyderabad', 'Telangana', '500081');

-- Insert rentals (4 per customer x 10 customers = 40)
-- For simplicity, using a single INSERT with multiple VALUES
INSERT INTO rental (Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_ID, Car_Regno) VALUES
-- Customer 1
('Rental_Rahul_HondaCity', '2025-04-01', '2025-04-05', 'Completed', 1, 'KA01AB1234'),
('Rental_Rahul_EcoSport', '2025-03-01', '2025-03-05', 'Available', 1, 'KA07MN7181'),
('Rental_Rahul_Kwid', '2025-03-10', '2025-03-14', 'Completed', 1, 'KA08OP9201'),
('Rental_Rahul_XUV', '2025-04-15', '2025-04-20', 'Ongoing', 1, 'KA06KL5161'),
-- Customer 2
('Rental_Anjali_Hyundai', '2025-04-10', '2025-04-12', 'Completed', 2, 'KA02CD5678'),
('Rental_Anjali_Kwid', '2025-03-15', '2025-03-20', 'Available', 2, 'KA08OP9201'),
('Rental_Anjali_Rapid', '2025-04-01', '2025-04-05', 'Ongoing', 2, 'KA09QR1222'),
('Rental_Anjali_Seltos', '2025-04-15', '2025-04-19', 'Ongoing', 2, 'KA10ST3242'),
-- Customer 3
('Rental_Karthik_MarutiSwift', '2025-04-15', '2025-04-20', 'Ongoing', 3, 'KA03EF9101'),
('Rental_Karthik_Rapid', '2025-02-20', '2025-02-25', 'Available', 3, 'KA09QR1222'),
('Rental_Karthik_XUV', '2025-03-10', '2025-03-15', 'Completed', 3, 'KA06KL5161'),
('Rental_Karthik_Seltos', '2025-04-01', '2025-04-07', 'Ongoing', 3, 'KA10ST3242'),
-- Customer 4
('Rental_Divya_ToyotaInnova', '2025-04-18', '2025-04-25', 'Available', 4, 'KA04GH1121'),
('Rental_Divya_Kwid', '2025-03-05', '2025-03-09', 'Completed', 4, 'KA08OP9201'),
('Rental_Divya_Rapid', '2025-04-01', '2025-04-06', 'Completed', 4, 'KA09QR1222'),
('Rental_Divya_EcoSport', '2025-04-10', '2025-04-15', 'Ongoing', 4, 'KA07MN7181'),
-- Customer 5
('Rental_Vikram_TataNexon', '2025-04-22', '2025-04-28', 'Ongoing', 5, 'KA05IJ3141'),
('Rental_Vikram_XUV', '2025-02-25', '2025-03-01', 'Completed', 5, 'KA06KL5161'),
('Rental_Vikram_Seltos', '2025-03-15', '2025-03-20', 'Available', 5, 'KA10ST3242'),
('Rental_Vikram_Rapid', '2025-04-05', '2025-04-10', 'Ongoing', 5, 'KA09QR1222'),
-- Customer 6–10, 1 rental each for brevity
('Rental_Snehal_Kwid', '2025-04-10', '2025-04-15', 'Completed', 6, 'KA08OP9201'),
('Rental_Rohan_Seltos', '2025-04-12', '2025-04-16', 'Available', 7, 'KA10ST3242'),
('Rental_Alisha_XUV', '2025-04-14', '2025-04-18', 'Ongoing', 8, 'KA06KL5161'),
('Rental_Manoj_EcoSport', '2025-04-16', '2025-04-20', 'Available', 9, 'KA07MN7181'),
('Rental_Pooja_Rapid', '2025-04-18', '2025-04-22', 'Ongoing', 10, 'KA09QR1222');

-- Insert payments matching rentals
INSERT INTO payment (Pay_Date_Time, Pay_Method, Pay_Status, Rental_ID) VALUES
('2025-04-05 14:30:00', 'Credit Card', 'Completed', 1),
('2025-03-05 12:00:00', 'Credit Card', 'Completed', 2),
('2025-03-14 13:30:00', 'UPI', 'Completed', 3),
('2025-04-20 09:00:00', 'Cash', 'Not Completed', 4),
('2025-04-12 10:00:00', 'UPI', 'Completed', 5),
('2025-03-20 11:00:00', 'Credit Card', 'Completed', 6),
('2025-04-05 15:00:00', 'UPI', 'Completed', 7),
('2025-04-19 17:00:00', 'Credit Card', 'Not Completed', 8),
('2025-04-20 16:45:00', 'Cash', 'Not Completed', 9),
('2025-02-25 12:00:00', 'Net Banking', 'Completed', 10),
('2025-03-15 13:30:00', 'UPI', 'Completed', 11),
('2025-04-07 10:00:00', 'Cash', 'Not Completed', 12),
('2025-04-25 11:15:00', 'Debit Card', 'Not Completed', 13),
('2025-03-09 15:00:00', 'UPI', 'Completed', 14),
('2025-04-06 11:30:00', 'Net Banking', 'Completed', 15),
('2025-04-15 16:00:00', 'Cash', 'Not Completed', 16),
('2025-04-28 18:00:00', 'Net Banking', 'Completed', 17),
('2025-03-01 10:30:00', 'Credit Card', 'Completed', 18),
('2025-03-20 14:45:00', 'Debit Card', 'Completed', 19),
('2025-04-10 13:00:00', 'UPI', 'Not Completed', 20),
('2025-04-15 12:30:00', 'Credit Card', 'Not Completed', 21),
('2025-04-16 13:45:00', 'Net Banking', 'Not Completed', 22),
('2025-04-18 14:15:00', 'UPI', 'Not Completed', 23),
('2025-04-20 15:00:00', 'Cash', 'Not Completed', 24),
('2025-04-22 16:30:00', 'Debit Card', 'Not Completed', 25);

