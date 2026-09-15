-- =========================================================
-- HEALTHCONNECT WEEK 6
-- ADVANCED ANALYTICS & DECISION SUPPORT
-- Data Analytics Track
-- ==========================================================
-- DATA QUALITY & KPI VALIDATION
-- Validate total appointment records
SELECT
    COUNT(*) AS Total_Appointments
FROM dbo.HealthConnect_Appointment_Working;

-- Validate appointment outcomes
SELECT
    appointment_outcome,
    COUNT(*) AS Appointment_Count,

    CAST(
        100.0 * COUNT(*) /
        (SELECT COUNT(*)
         FROM dbo.HealthConnect_Appointment_Working)
        AS DECIMAL(5,2)
    ) AS Percentage
FROM dbo.HealthConnect_Appointment_Working
GROUP BY appointment_outcome
ORDER BY Appointment_Count DESC;

-- Check for missing values
SELECT
    COUNT(*) AS Total_Records,

    SUM(CASE WHEN appointment_outcome IS NULL THEN 1 ELSE 0 END)
        AS Missing_Status,

    SUM(CASE WHEN booking_lead_days IS NULL THEN 1 ELSE 0 END)
        AS Missing_Lead_Days,

    SUM(CASE WHEN booking_lead_days_group IS NULL THEN 1 ELSE 0 END)
        AS Missing_Lead_Group,

    SUM(CASE WHEN reminder_sent IS NULL THEN 1 ELSE 0 END)
        AS Missing_Reminder,

    SUM(CASE WHEN appointment_type IS NULL THEN 1 ELSE 0 END)
        AS Missing_Appointment_Type,

    SUM(CASE WHEN previous_no_shows IS NULL THEN 1 ELSE 0 END)
        AS Missing_Previous_No_Show,

    SUM(CASE WHEN distance_to_clinic_km IS NULL THEN 1 ELSE 0 END)
        AS Missing_Distance
FROM dbo.HealthConnect_Appointment_Working;

--  BOOKING LEAD TIME ANALYSIS

-- Validate booking lead-time relationship

SELECT
    booking_lead_days_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    SUM(CASE
        WHEN appointment_outcome = 'Attended'
        THEN 1 ELSE 0
    END) AS Attended,

    SUM(CASE
        WHEN appointment_outcome = 'Cancelled'
        THEN 1 ELSE 0
    END) AS Cancelled,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY booking_lead_days_group

ORDER BY
    CASE booking_lead_days_group
        WHEN '0-7 Days' THEN 1
        WHEN '8-14 Days' THEN 2
        WHEN '15-30 Days' THEN 3
        WHEN '31+ Days' THEN 4
        ELSE 5
    END;

    -- Measure the lead-time gap

    WITH LeadTimeRates AS
(
    SELECT
        booking_lead_days_group,

        CAST(
            100.0 *
            SUM(CASE
                WHEN appointment_outcome = 'No-Show'
                THEN 1 ELSE 0
            END) / COUNT(*)
            AS DECIMAL(5,2)
        ) AS No_Show_Rate

    FROM dbo.HealthConnect_Appointment_Working

    GROUP BY booking_lead_days_group
)

SELECT
    MAX(CASE
        WHEN booking_lead_days_group = '31+ Days'
        THEN No_Show_Rate
    END) AS Rate_31_Plus,

    MAX(CASE
        WHEN booking_lead_days_group = '0-7 Days'
        THEN No_Show_Rate
    END) AS Rate_0_7,

    MAX(CASE
        WHEN booking_lead_days_group = '31+ Days'
        THEN No_Show_Rate
    END)
    -
    MAX(CASE
        WHEN booking_lead_days_group = '0-7 Days'
        THEN No_Show_Rate
    END) AS Percentage_Point_Gap

FROM LeadTimeRates;

-- REMINDER EFFECTIVENESS 
-- No-show rate by reminder

SELECT
    reminder_sent,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    SUM(CASE
        WHEN appointment_outcome = 'Attended'
        THEN 1 ELSE 0
    END) AS Attended,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY reminder_sent;

-- Lead Time × Reminder

SELECT
    booking_lead_days_group,
    reminder_sent,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    SUM(CASE
        WHEN appointment_outcome = 'Attended'
        THEN 1 ELSE 0
    END) AS Attended,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    booking_lead_days_group,
    reminder_sent

ORDER BY
    CASE booking_lead_days_group
        WHEN '0-7 Days' THEN 1
        WHEN '8-14 Days' THEN 2
        WHEN '15-30 Days' THEN 3
        WHEN '31+ Days' THEN 4
        ELSE 5
    END,
    reminder_sent;

    -- PREVIOUS NO-SHOW BEHAVIOUR
    -- Previous no-show vs current outcome

    SELECT
    CASE
        WHEN previous_no_shows = 0
            THEN 'No Previous No-Shows'
        WHEN previous_no_shows = 1
            THEN '1 Previous No-Show'
        WHEN previous_no_shows >= 2
            THEN '2+ Previous No-Shows'
        ELSE 'Unknown'
    END AS previous_no_show_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    CASE
        WHEN previous_no_shows = 0
            THEN 'No Previous No-Shows'
        WHEN previous_no_shows = 1
            THEN '1 Previous No-Show'
        WHEN previous_no_shows >= 2
            THEN '2+ Previous No-Shows'
        ELSE 'Unknown'
    END;

   
-- Previous No-Show History × Booking Lead Time


WITH Analysis AS (
    SELECT
        CASE
            WHEN previous_no_shows = 0
                THEN 'No Previous No-Shows'
            WHEN previous_no_shows = 1
                THEN '1 Previous No-Show'
            WHEN previous_no_shows >= 2
                THEN '2+ Previous No-Shows'
            ELSE 'Unknown'
        END AS previous_no_show_group,

        booking_lead_days_group,

        appointment_outcome

    FROM dbo.HealthConnect_Appointment_Working
)

SELECT
    previous_no_show_group,
    booking_lead_days_group,

    COUNT(*) AS total_appointments,

    SUM(
        CASE
            WHEN appointment_outcome = 'No-show'
                THEN 1
            ELSE 0
        END
    ) AS no_shows,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN appointment_outcome = 'No-show'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS no_show_rate

FROM Analysis

GROUP BY
    previous_no_show_group,
    booking_lead_days_group

ORDER BY
    CASE previous_no_show_group
        WHEN 'No Previous No-Shows' THEN 1
        WHEN '1 Previous No-Show' THEN 2
        WHEN '2+ Previous No-Shows' THEN 3
        ELSE 4
    END,
    booking_lead_days_group;


    -- DISTANCE ANALYSIS
    -- Distance and no-show relationship
-- Question: Does greater distance from the clinic remain associated with higher no-show rates?

SELECT
    CASE
        WHEN distance_to_clinic_km BETWEEN 0 AND 5
            THEN '0-5 km'
        WHEN distance_to_clinic_km BETWEEN 6 AND 10
            THEN '6-10 km'
        WHEN distance_to_clinic_km BETWEEN 11 AND 20
            THEN '11-20 km'
        WHEN distance_to_clinic_km >= 21
            THEN '21+ km'
        ELSE 'Unknown'
    END AS distance_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome= 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    CASE
        WHEN distance_to_clinic_km BETWEEN 0 AND 5
            THEN '0-5 km'
        WHEN distance_to_clinic_km BETWEEN 6 AND 10
            THEN '6-10 km'
        WHEN distance_to_clinic_km BETWEEN 11 AND 20
            THEN '11-20 km'
        WHEN distance_to_clinic_km>= 21
            THEN '21+ km'
        ELSE 'Unknown'
    END

ORDER BY
    CASE
        WHEN MIN(distance_to_clinic_km) IS NULL THEN 5
        ELSE 1
    END;

    -- Lead Time × Distance
-- Question:Are patients who both live far away and book far in 
-- advance at particularly high risk of missing appointments?
SELECT
    booking_lead_days_group,

    CASE
        WHEN distance_to_clinic_km BETWEEN 0 AND 5
            THEN '0-5 km'
        WHEN distance_to_clinic_km BETWEEN 6 AND 10
            THEN '6-10 km'
        WHEN distance_to_clinic_km BETWEEN 11 AND 20
            THEN '11-20 km'
        WHEN distance_to_clinic_km >= 21
            THEN '21+ km'
        ELSE 'Unknown'
    END AS distance_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    booking_lead_days_group,

    CASE
        WHEN distance_to_clinic_km BETWEEN 0 AND 5
            THEN '0-5 km'
        WHEN distance_to_clinic_km BETWEEN 6 AND 10
            THEN '6-10 km'
        WHEN distance_to_clinic_km BETWEEN 11 AND 20
            THEN '11-20 km'
        WHEN distance_to_clinic_km >= 21
            THEN '21+ km'
        ELSE 'Unknown'
    END

ORDER BY No_Show_Rate DESC;

-- CROSS-SEGMENT ANALYSIS
-- Appointment Type × Lead Time
SELECT
    appointment_type,
    booking_lead_days_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    appointment_type,
    booking_lead_days_group

ORDER BY
    appointment_type,
    CASE booking_lead_days_group
        WHEN '0-7 Days' THEN 1
        WHEN '8-14 Days' THEN 2
        WHEN '15-30 Days' THEN 3
        WHEN '31+ Days' THEN 4
        ELSE 5
    END;

-- High-risk appointment segments
-- Question:Which combinations of appointment type and booking lead time have the highest no-show rates?
SELECT
    appointment_type,
    booking_lead_days_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY
    appointment_type,
    booking_lead_days_group

HAVING COUNT(*) >= 30

ORDER BY No_Show_Rate DESC;

-- BUSINESS IMPACT
-- No-show volume by lead time
SELECT
    booking_lead_days_group,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY booking_lead_days_group

ORDER BY No_Shows DESC;

-- KPI VALIDATION
-- Overall KPI validation
-- Question:Do the Week 6 SQL results reproduce the key Week 5 KPIs?
SELECT
    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    SUM(CASE
        WHEN appointment_outcome = 'Attended'
        THEN 1 ELSE 0
    END) AS Attended,

    SUM(CASE
        WHEN appointment_outcome = 'Cancelled'
        THEN 1 ELSE 0
    END) AS Cancelled,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'Attended'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Attended_Rate,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'Cancelled'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Cancelled_Rate

FROM dbo.HealthConnect_Appointment_Working;


-- DATA SCIENCE INTEGRATION
-- Candidate feature summary
SELECT
    appointment_type,

    COUNT(*) AS Total_Appointments,

    SUM(CASE
        WHEN appointment_outcome = 'No-Show'
        THEN 1 ELSE 0
    END) AS No_Shows,

    CAST(
        100.0 *
        SUM(CASE
            WHEN appointment_outcome = 'No-Show'
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS No_Show_Rate

FROM dbo.HealthConnect_Appointment_Working

GROUP BY appointment_type

ORDER BY No_Show_Rate DESC;