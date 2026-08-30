# HealthConnect Appointment No-Show Analysis

Data analytics project investigating patient appointment attendance and no-show patterns for a healthcare clinic, using **SQL** for data exploration, validation, and analysis, and **Power BI** for visualization and dashboarding.

## 📋 Project Background

HealthConnect needed to better understand patient appointment attendance and no-show patterns. Missed appointments affect clinic operations, staff scheduling, service delivery, and the efficient use of available appointment slots.

This project establishes the analytical foundation for investigating the factors associated with appointment attendance, no-shows, and cancellations — using SQL for data exploration, validation, and cleaning, and Power BI for trend analysis and insight communication.

## 🗂️ Dataset

The HealthConnect appointment dataset contains **5,000 records** and **18 variables**, with each record representing a single appointment.

| Variable | Description |
|---|---|
| `appointment_id` | Unique identifier for each appointment |
| `patient_id` | Unique identifier for each patient |
| `gender` | Patient gender |
| `age` / `age_group` | Patient age and age category |
| `appointment_type` | Type of appointment booked |
| `booking_date` / `appointment_date` | Booking and scheduled dates |
| `appointment_day` / `appointment_time` | Day of week and time category |
| `booking_lead_days` | Days between booking and appointment |
| `previous_appointments` / `previous_no_shows` | Patient appointment history |
| `reminder_sent` / `reminder_channel` | Reminder status and channel used |
| `distance_to_clinic_km` | Estimated distance from patient to clinic |
| `waiting_time_minutes` | Waiting time associated with the appointment |
| `appointment_outcome` | Attended, No-Show, or Cancelled (primary outcome variable) |

**Current outcome distribution:**
- No-Show: 2,423 records
- Attended: 2,314 records
- Cancelled: 263 records

## 🔍 Data Quality Assessment

An initial review was conducted before analysis:

- **Missing values** found in `reminder_channel` (1,366), `distance_to_clinic_km` (90), and `waiting_time_minutes` (60). Missing `reminder_channel` values are logically tied to `reminder_sent` and treated as "No Reminder Sent" rather than errors.
- **No fully duplicated records** identified; `appointment_id` uniqueness to be confirmed in further analysis.
- **Data types** reviewed and confirmed appropriate for the planned analysis (dates, numeric, decimal, and categorical fields).
- **Validity checks** passed — including age ranges, booking lead time ranges, and consistency between related fields (e.g. age vs. age group, appointment date vs. appointment day, reminder sent vs. reminder channel).

## ❓ Business Questions

1. What proportion of scheduled appointments result in attendance, no-shows, and cancellations?
2. Which patient and appointment characteristics are associated with higher no-show rates?
3. Do patients with a history of previous no-shows have a higher likelihood of missing future appointments?
4. Are appointment reminders associated with improved attendance and reduced no-show rates?
5. Do no-show rates differ by reminder channel?
6. Are there particular days, times, or appointment types with consistently higher no-show rates?

## 📊 Proposed KPIs

| KPI | Definition |
|---|---|
| **No-Show Rate** | % of scheduled appointments resulting in a No-Show |
| **Appointment Attendance Rate** | % of scheduled appointments resulting in Attended |
| **No-Show Rate by Segment** | No-show rate across age group, appointment type, day, time, lead time, and distance categories |
| **Repeat No-Show Rate** | No-show rate for patients with prior no-shows vs. those without |
| **Reminder Effectiveness Rate** | Attendance/no-show comparison by reminder status and channel |

## 🛠️ Analysis Approach

1. **Load & understand the data** — review structure, data types, and key categories in SQL
2. **Data quality checks** — missing values, duplicates, unique IDs, logical consistency
3. **Define the analysis population** — decide how cancelled appointments are treated in KPI calculations
4. **Exploratory analysis** — compare appointment outcomes across patient and appointment characteristics in SQL
5. **Prepare data for Power BI** — create calculated categories (e.g. lead time ranges, distance ranges, attendance/no-show indicators)
6. **Power BI dashboard** — interactive visualizations of attendance trends, no-show patterns by segment, reminder effectiveness, and scheduling patterns

## ⚠️ Assumptions & Limitations

- Each record represents one appointment, with `appointment_id` as a unique identifier.
- Recorded appointment outcomes are assumed accurate.
- The dataset is observational — associations (e.g. reminders vs. attendance) should not be interpreted as causation without further evidence.
- Missing `distance_to_clinic_km` and `waiting_time_minutes` values will need an agreed treatment strategy before those variables are used in analysis.

## 🚀 Tools

- **SQL** — data exploration, validation, cleaning, and analysis
- **Power BI** — trend analysis, dashboards, and insight communication

## 📌 Project Status

Currently in the initial data assessment and planning phase (Week 4). Next steps: detailed SQL exploratory analysis, KPI calculation, and Power BI dashboard development.

---

*This project is part of an ongoing data analytics track focused on healthcare operations analytics.*# HealthConnect-Appointment-Analytics

Link to the file....https://docs.google.com/spreadsheets/d/1sxLJDlv2ORN5LuF40z9Ywd3qHzriJwA5pEzbrJ-qcek/edit?usp=sharing. 
