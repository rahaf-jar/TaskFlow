USE taskflow;

INSERT INTO Departments (department_name, manager_name)
VALUES
('Sales', 'Sarah Johnson'),
('Product', 'Michael Brown'),
('Engineering', 'David Wilson'),
('Marketing', 'Emma Davis'),
('Customer Success', 'Daniel Miller'),
('Human Resources', 'Sophia Taylor');


INSERT INTO Employees 
(first_name, last_name, date_of_birth, job_title, department_id, salary, hire_date)
VALUES
('Anna', 'Smith', '1995-03-12', 'Sales Manager', 1, 65000.00, '2024-01-15'),
('James', 'Wilson', '1998-07-25', 'Sales Representative', 1, 50000.00, '2025-03-10'),
('Olivia', 'Brown', '1993-11-05', 'Product Manager', 2, 85000.00, '2023-06-01'),
('Daniel', 'Miller', '1997-02-18', 'Software Engineer', 3, 90000.00, '2024-09-20'),
('Emma', 'Davis', '1999-08-30', 'Marketing Specialist', 4, 55000.00, '2025-01-05'),
('Sophia', 'Taylor', '1996-12-10', 'HR Specialist', 6, 60000.00, '2024-04-12'),
('Liam', 'Anderson', '1994-05-22', 'Customer Success Manager', 5, 70000.00, '2024-02-20');