CREATE DATABASE IF NOT EXISTS complaint_db;
USE complaint_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('EMPLOYEE', 'ADMIN') NOT NULL
);

INSERT INTO users (username, password, role) VALUES
                                                 ('employee', '$2a$12$Gy6XAcTL4uLgyllrr7XIt.jCImH5OJym6n7VuilO6KMPMCHMAabzG', 'EMPLOYEE'),
                                                 ('admin', '$2a$12$Gy6XAcTL4uLgyllrr7XIt.jCImH5OJym6n7VuilO6KMPMCHMAabzG', 'ADMIN');


CREATE TABLE IF NOT EXISTS complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED') DEFAULT 'PENDING',
    remarks TEXT,
    created_at DATE DEFAULT CURDATE(),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
