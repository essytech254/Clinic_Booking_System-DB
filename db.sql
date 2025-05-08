-- --------------------------------------
-- Clinic Booking System Database Schema
-- --------------------------------------

-- Table: departments
-- Stores different departments in the clinic (e.g., Cardiology, Dermatology)
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each department
    name VARCHAR(100) NOT NULL UNIQUE              -- Name of the department (must be unique)
);

-- Table: doctors
-- Stores doctor information and links each doctor to a department
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique identifier for each doctor
    name VARCHAR(100) NOT NULL,                     -- Doctor's full name
    email VARCHAR(100) NOT NULL UNIQUE,             -- Doctor's email (must be unique)
    department_id INT,                              -- FK referencing department doctor belongs to
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Table: patients
-- Stores patient information
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,      -- Unique identifier for each patient
    name VARCHAR(100) NOT NULL,                     -- Patient's full name
    phone VARCHAR(20) NOT NULL UNIQUE,              -- Patient's contact number (must be unique)
    date_of_birth DATE                              -- Patient's date of birth
);

-- Table: appointments
-- Stores details of appointments between patients and doctors
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,      -- Unique identifier for each appointment
    patient_id INT NOT NULL,                            -- FK referencing the patient
    doctor_id INT NOT NULL,                             -- FK referencing the doctor
    appointment_date DATETIME NOT NULL,                 -- Date and time of the appointment
    status ENUM('Scheduled', 'Completed', 'Cancelled')  -- Status of the appointment
        DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Table: services
-- Stores available medical services and their fees
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique identifier for each service
    name VARCHAR(100) NOT NULL UNIQUE,               -- Name of the service (must be unique)
    fee DECIMAL(10,2) NOT NULL                       -- Cost of the service
);

-- Table: appointment_services
-- Junction table for many-to-many relationship between appointments and services
CREATE TABLE appointment_services (
    appointment_id INT,                              -- FK referencing appointment
    service_id INT,                                   -- FK referencing service
    PRIMARY KEY (appointment_id, service_id),        -- Composite primary key
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- Table: payments
-- Stores payment information for each appointment
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique identifier for each payment
    appointment_id INT,                              -- FK referencing appointment
    amount DECIMAL(10,2) NOT NULL,                   -- Amount paid
    payment_date DATE NOT NULL,                      -- Date of the payment
    payment_method ENUM('Cash', 'Card', 'Insurance') NOT NULL,  -- Method of payment
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);
