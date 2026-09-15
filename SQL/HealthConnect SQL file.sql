-- ==========================================
-- HEALTHCONNECT WEEK 5 DATA PREPARATION
-- Tool: Microsoft SQL Server
-- Database: HealthConnect_db
-- ==========================================
-- IMPORT VERIFICATION

SELECT COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working;

SELECT TOP 10 *
FROM dbo.HealthConnect_Appointment_Working;

-- MISSING VALUE ASSESSMENT
SELECT
    SUM(CASE WHEN appointment_id IS NULL THEN 1 ELSE 0 END) AS appointment_id_missing,
    SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS patient_id_missing,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_missing,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_missing,
    SUM(CASE WHEN age_group IS NULL THEN 1 ELSE 0 END) AS age_group_missing
FROM dbo.HealthConnect_Appointment_Working;

SELECT
    SUM(CASE WHEN appointment_type IS NULL THEN 1 ELSE 0 END) AS appointment_type_missing,
    SUM(CASE WHEN booking_date IS NULL THEN 1 ELSE 0 END) AS booking_date_missing,
    SUM(CASE WHEN appointment_date IS NULL THEN 1 ELSE 0 END) AS appointment_date_missing,
    SUM(CASE WHEN appointment_day IS NULL THEN 1 ELSE 0 END) AS appointment_day_missing,
    SUM(CASE WHEN appointment_time IS NULL THEN 1 ELSE 0 END) AS appointment_time_missing
FROM dbo.HealthConnect_Appointment_Working;

SELECT
    SUM(CASE WHEN booking_lead_days IS NULL THEN 1 ELSE 0 END) AS booking_lead_days_missing,
    SUM(CASE WHEN previous_appointments IS NULL THEN 1 ELSE 0 END) AS previous_appointments_missing,
    SUM(CASE WHEN previous_no_shows IS NULL THEN 1 ELSE 0 END) AS previous_no_shows_missing,
    SUM(CASE WHEN reminder_sent IS NULL THEN 1 ELSE 0 END) AS reminder_sent_missing,
    SUM(CASE WHEN reminder_channel IS NULL THEN 1 ELSE 0 END) AS reminder_channel_missing
FROM dbo.HealthConnect_Appointment_Working;

SELECT
    SUM(CASE WHEN distance_to_clinic_km IS NULL THEN 1 ELSE 0 END) AS distance_missing,
    SUM(CASE WHEN waiting_time_minutes IS NULL THEN 1 ELSE 0 END) AS waiting_time_missing,
    SUM(CASE WHEN appointment_outcome IS NULL THEN 1 ELSE 0 END) AS appointment_outcome_missing
FROM dbo.HealthConnect_Appointment_Working;

SELECT
    reminder_channel,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY reminder_channel
ORDER BY total_records DESC;

SELECT 
    reminder_sent,
    reminder_channel,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY reminder_sent, reminder_channel
ORDER BY reminder_sent, reminder_channel;

-- DUPLICATE CHECK
SELECT 
    appointment_id,
    COUNT(*) AS duplicate_count
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_id
HAVING COUNT(*) > 1;

SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT appointment_id) AS unique_appointment_ids
FROM dbo.HealthConnect_Appointment_Working;

SELECT 
    appointment_id,
    patient_id,
    gender,
    age,
    age_group,
    appointment_type,
    booking_date,
    appointment_date,
    appointment_day,
    appointment_time,
    booking_lead_days,
    previous_appointments,
    previous_no_shows,
    reminder_sent,
    reminder_channel,
    distance_to_clinic_km,
    waiting_time_minutes,
    appointment_outcome,
    COUNT(*) AS duplicate_count
FROM dbo.HealthConnect_Appointment_Working
GROUP BY 
    appointment_id,
    patient_id,
    gender,
    age,
    age_group,
    appointment_type,
    booking_date,
    appointment_date,
    appointment_day,
    appointment_time,
    booking_lead_days,
    previous_appointments,
    previous_no_shows,
    reminder_sent,
    reminder_channel,
    distance_to_clinic_km,
    waiting_time_minutes,
    appointment_outcome
HAVING COUNT(*) > 1;

-- CATEGORICAL VALUE CONSISTENCY CHECK
-- GENDER CHECK
SELECT 
    gender,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY gender
ORDER BY total_records DESC;
-- AGE GROUP CHECK
SELECT 
    age_group,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY age_group
ORDER BY age_group;
-- APPOINTMENT TYPE
SELECT 
    appointment_type,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_type
ORDER BY total_records DESC;
--APPOINTMENT DAY
SELECT 
    appointment_day,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_day
ORDER BY appointment_day;
-- APPOINTMENT TIME
SELECT 
    appointment_time,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_time
ORDER BY total_records DESC;
-- REMINDER SENT
SELECT 
    reminder_sent,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY reminder_sent
ORDER BY reminder_sent;
--REMINDER CHANNEL
SELECT 
    reminder_channel,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY reminder_channel
ORDER BY total_records DESC;
-- APPOINTMENT OUTCOME
SELECT 
    appointment_outcome,
    COUNT(*) AS total_records
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_outcome
ORDER BY total_records DESC;

-- NUMERIC VALUE VALIDITY CHECK
-- AGE 
SELECT 
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age,
    AVG(age) AS average_age
FROM dbo.HealthConnect_Appointment_Working;
-- BOOKING LEAD DAY
SELECT 
    MIN(booking_lead_days) AS minimum_lead_days,
    MAX(booking_lead_days) AS maximum_lead_days,
    AVG(booking_lead_days) AS average_lead_days
FROM dbo.HealthConnect_Appointment_Working;
-- PREVIOUS APPOINTMENTY HISTORY
SELECT 
    MIN(previous_appointments) AS min_previous_appointments,
    MAX(previous_appointments) AS max_previous_appointments,
    MIN(previous_no_shows) AS min_previous_no_shows,
    MAX(previous_no_shows) AS max_previous_no_shows
FROM dbo.HealthConnect_Appointment_Working;
-- DISTANCE TO CLINIC
SELECT 
    MIN(distance_to_clinic_km) AS minimum_distance,
    MAX(distance_to_clinic_km) AS maximum_distance,
    AVG(distance_to_clinic_km) AS average_distance
FROM dbo.HealthConnect_Appointment_Working;
-- WAITING TIME
SELECT 
    MIN(waiting_time_minutes) AS minimum_waiting_time,
    MAX(waiting_time_minutes) AS maximum_waiting_time,
    AVG(waiting_time_minutes) AS average_waiting_time
FROM dbo.HealthConnect_Appointment_Working;

-- LOGICAL CONSISTENCY CHECKS
-- Previous No-Shows Cannot Exceed Previous Appointments
SELECT *
FROM dbo.HealthConnect_Appointment_Working
WHERE previous_no_shows > previous_appointments;

-- Appointment Date Cannot Be Before Booking Date
SELECT *
FROM dbo.HealthConnect_Appointment_Working
WHERE appointment_date < booking_date;
--BOOKING LEAD DAY
SELECT 
    appointment_id,
    booking_date,
    appointment_date,
    booking_lead_days,
    DATEDIFF(DAY, booking_date, appointment_date) AS calculated_lead_days
FROM dbo.HealthConnect_Appointment_Working
WHERE booking_lead_days <> DATEDIFF(DAY, booking_date, appointment_date);
-- Appointment Day Against Appointment Date
SELECT 
    appointment_id,
    appointment_date,
    appointment_day,
    DATENAME(WEEKDAY, appointment_date) AS calculated_day
FROM dbo.HealthConnect_Appointment_Working
WHERE appointment_day <> DATENAME(WEEKDAY, appointment_date);

-- EXPLORATORY DATA ANALYSIS (EDA)
-- What is the overall appointment outcome pattern?
-- Count appointments by outcome
SELECT
    appointment_outcome,
    COUNT(*) AS appointment_count
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_outcome
ORDER BY appointment_count DESC;
-- Calculate the percentage
SELECT
    appointment_outcome,
    COUNT(*) AS appointment_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_outcome
ORDER BY appointment_count DESC;
-- Calculate the overall no-show rate
SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working;

-- Do appointment outcomes vary by appointment type?
-- Appointment Outcomes by Appointment Type
SELECT
    appointment_type,
    appointment_outcome,
    COUNT(*) AS appointment_count
FROM dbo.HealthConnect_Appointment_Working
GROUP BY
    appointment_type,
    appointment_outcome
ORDER BY
    appointment_type,
    appointment_count DESC;
-- Calculate the no-show rate by appointment type
SELECT
    appointment_type,
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_type
ORDER BY no_show_rate DESC;

-- Does patient age or age group relate to no-show behaviour?
-- Age and No-Show Behaviour
SELECT
    age_group,
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working
GROUP BY age_group
ORDER BY no_show_rate DESC;

-- Do reminders affect attendance and no-show rates?
SELECT
    reminder_sent,
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'Attended' THEN 1
        ELSE 0
    END) AS attended,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working
GROUP BY reminder_sent
ORDER BY no_show_rate DESC;
-- Does waiting time affect appointment outcomes?
SELECT
    waiting_time_minutes,
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working
GROUP BY waiting_time_minutes
ORDER BY waiting_time_minutes;

-- Does booking lead time affect no-show patterns?
SELECT
    CASE
        WHEN booking_lead_days <= 7 THEN '0-7 days'
        WHEN booking_lead_days <= 14 THEN '8-14 days'
        WHEN booking_lead_days <= 30 THEN '15-30 days'
        ELSE '31+ days'
    END AS lead_time_group,

    COUNT(*) AS total_appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,

    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    CASE
        WHEN booking_lead_days <= 7 THEN '0-7 days'
        WHEN booking_lead_days <= 14 THEN '8-14 days'
        WHEN booking_lead_days <= 30 THEN '15-30 days'
        ELSE '31+ days'
    END;

-- Does distance to the clinic influence attendance?
SELECT
    CASE
        WHEN distance_to_clinic_km < 5 THEN 'Less than 5 km'
        WHEN distance_to_clinic_km < 10 THEN '5–9 km'
        WHEN distance_to_clinic_km < 20 THEN '10–19 km'
        ELSE '20+ km'
    END AS distance_group,
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working
GROUP BY
    CASE
        WHEN distance_to_clinic_km < 5 THEN 'Less than 5 km'
        WHEN distance_to_clinic_km < 10 THEN '5–9 km'
        WHEN distance_to_clinic_km < 20 THEN '10–19 km'
        ELSE '20+ km'
    END
ORDER BY no_show_rate DESC;

-- Do patients with previous no-shows have a higher risk of missing future appointments?
SELECT
    previous_no_shows,
    COUNT(*) AS total_appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,

    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY previous_no_shows

ORDER BY previous_no_shows;

-- Are there patterns in no-shows by appointment day?
SELECT
    DATENAME(WEEKDAY, appointment_date) AS appointment_day,
    COUNT(*) AS total_appointments,
    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,
    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate
FROM dbo.HealthConnect_Appointment_Working
GROUP BY DATENAME(WEEKDAY, appointment_date)
ORDER BY no_show_rate DESC;

-- Are there patterns in attendance based on appointment time?
SELECT
    appointment_time AS appointment_period,
    COUNT(*) AS total_appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show' THEN 1
        ELSE 0
    END) AS no_show_count,

    ROUND(
        SUM(CASE
            WHEN appointment_outcome = 'No-Show' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS no_show_rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY appointment_time

ORDER BY no_show_rate DESC;
 



