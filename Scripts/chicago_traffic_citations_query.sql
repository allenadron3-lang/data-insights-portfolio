USE chicago_traffic_citation;

-- View 1: Citations and officer information
DROP VIEW IF EXISTS citations_with_officer_location;
CREATE VIEW citations_with_officer_location AS
SELECT 
    c.Ticket_Number,
    o.Badge_Number,
    l.Violation_Location,
    c.Issue_Date
FROM Citation c
JOIN Officer o ON c.Officer_Id = o.Officer_Id
JOIN Location l ON c.Location_Id = l.Location_Id
WHERE c.Issue_Date > '2021-01-01';

-- View 2: Basic summary of a violation
DROP VIEW IF EXISTS violation_summary_by_type;
CREATE VIEW violation_summary_by_type AS
SELECT
    v.Violation_Code,
    v.Violation_Description,
    COUNT(chv.Ticket_Number) AS citation_count,
    ROUND(AVG(p.Current_Amounts + p.Total_Payments), 2) AS avg_fine
FROM Citation_has_Violation chv
JOIN Violation v ON chv.Violation_Id = v.Violation_Id
JOIN Payments p ON chv.Ticket_Number = p.Ticket_Number
GROUP BY v.Violation_Code, v.Violation_Description;

-- View 3: Citation and violation
DROP VIEW IF EXISTS citation_violation_joined;
CREATE VIEW citation_violation_joined AS
SELECT 
    c.Ticket_Number,
    v.Violation_Code,
    v.Violation_Description
FROM Citation c
JOIN Citation_has_Violation chv ON c.Ticket_Number = chv.Ticket_Number
JOIN Violation v ON chv.Violation_Id = v.Violation_Id;

-- View 4: Fine information
DROP VIEW IF EXISTS above_avg_fine_violations;
CREATE VIEW above_avg_fine_violations AS
SELECT DISTINCT
    Violation_Code,
    Violation_Description,
    Fine_Amount_1,
    Fine_Amount_2
FROM Violation
WHERE (Fine_Amount_1 + Fine_Amount_2) / 2 > (
    SELECT AVG((Fine_Amount_1 + Fine_Amount_2) / 2)
    FROM Violation
);

-- View 5: Car type payments
DROP VIEW IF EXISTS payments_by_vehicle_type;
CREATE VIEW payments_by_vehicle_type AS
SELECT 
    v.Vehicle_Type,
    COUNT(p.Payment_Id) AS total_payments,
    SUM(p.Total_Payments) AS total_amount
FROM Payments p
JOIN Citation c ON p.Ticket_Number = c.Ticket_Number
JOIN Vehicle v ON c.Vehicle_Id = v.Vehicle_Id
GROUP BY v.Vehicle_Type
HAVING SUM(p.Total_Payments) > 100;
