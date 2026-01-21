Chicago Traffic Citation Database & Analysis
This project focuses on structuring and querying municipal data to understand traffic violation patterns, officer productivity, and payment trends.
1. Problem Statement
The City of Chicago generates a vast amount of traffic citation data. The challenge addressed in this project is to transform raw citation records into actionable insights regarding:
* Officer enforcement patterns and location-based citation trends.
* Identifying high-cost violations that exceed the city's average fine threshold.
* Analyzing revenue collection and citation volume based on vehicle types to inform urban policy.
2. Approach and Methodology
* Database Schema Implementation: Developed a relational structure using tables such as Citation, Officer, Location, Violation, and Payments.
* Data Aggregation via Views: Created specialized SQL views to simplify complex joins and provide "at-a-glance" reports for city administrators.
* Financial Benchmarking: Utilized subqueries to calculate the global average fine amount and dynamically filter violation types that represent a higher financial burden on citizens.
* Categorical Analysis: Grouped payment data by vehicle classification to determine which segments contribute most to city citation revenue.
3. Tools and Technologies Used
* SQL (MySQL/MariaDB Syntax): For database schema definition (DDL) and complex querying (DML).
* Relational Database Management System (RDBMS): To manage many-to-many relationships (e.g., Citation_has_Violation).
4. Key Findings and Reporting Views
* Violation Extremes: Successfully isolated violations where the average fine exceeds the city-wide mean, highlighting specific areas for policy review.
* Officer Productivity: Created a filtered view for citations issued after January 1, 2021, to track recent officer and location-based performance.
* Revenue by Vehicle: The payments_by_vehicle_type view provides a clear summary of total payments and citation counts, identifying which vehicle categories are most frequently cited.
