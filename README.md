# HealthConnect Appointment No-Show Analysis

Data analytics project investigating patient appointment attendance and no-show patterns for a healthcare clinic, using **SQL** for data cleaning, exploration, validation, and analysis, and **Power BI** for visualization and dashboarding.

## 📋 Project Background

HealthConnect needed to better understand patient appointment attendance and no-show patterns. Missed appointments can affect clinic operations, staff scheduling, service delivery, and the efficient use of available appointment slots.

This project analyses appointment data to identify factors associated with attendance, no-shows, and cancellations. The analysis uses SQL to clean, validate, and explore the data, with Power BI used to communicate findings through an interactive dashboard.

---

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
| `appointment_day` / `appointment_time` | Day of week and appointment period |
| `booking_lead_days` | Days between booking and appointment |
| `previous_appointments` / `previous_no_shows` | Patient appointment history |
| `reminder_sent` / `reminder_channel` | Reminder status and channel used |
| `distance_to_clinic_km` | Estimated distance from patient to clinic |
| `waiting_time_minutes` | Waiting time associated with the appointment |
| `appointment_outcome` | Attended, No-Show, or Cancelled |

### Appointment Outcome Distribution

- **No-Show:** 2,423 appointments, 48.46%
- **Attended:** 2,314 appointments, 46.28%
- **Cancelled:** 263 appointments, 5.26%

---

## 🔍 Data Preparation and Quality Assessment

The dataset was reviewed and prepared before analysis.

The process included:

- Checking the dataset structure and column data types.
- Identifying missing values.
- Checking for duplicate records.
- Validating appointment and patient identifiers.
- Reviewing age and booking lead time ranges.
- Checking consistency between related fields, including age and age group, appointment date and appointment day, and reminder status and reminder channel.
- Preparing the cleaned working dataset for analysis.

The final cleaned dataset was stored in:

`dbo.HealthConnect_Appointment_Working`

---

## ❓ Business Questions

The analysis focused on the following questions:

1. What is the overall appointment attendance pattern?
2. What percentage of appointments result in no-shows?
3. How do appointment outcomes vary by appointment type?
4. Does patient age or age group relate to no-show behaviour?
5. Do reminders affect attendance and no-show rates?
6. Does waiting time affect appointment outcomes?
7. Does booking lead time affect no-show patterns?
8. Does distance to the clinic influence attendance?
9. Do patients with previous no-shows have a higher risk of missing future appointments?
10. Are there patterns by appointment day or appointment time?

---

## 📊 Key KPIs

| KPI | Definition |
|---|---|
| **Total Appointments** | Total number of scheduled appointments |
| **No-Show Rate** | Percentage of appointments resulting in a No-Show |
| **Attendance Rate** | Percentage of appointments resulting in Attended |
| **Cancellation Rate** | Percentage of appointments resulting in Cancelled |
| **No-Show Rate by Segment** | No-show rate across appointment and patient characteristics |
| **Reminder Comparison** | Attendance and no-show comparison by reminder status |
| **Repeat No-Show Pattern** | No-show patterns based on previous no-show history |

---

## 🛠️ Analysis Approach

### 1. Data Understanding

The dataset structure, data types, and key variables were reviewed to understand the available information.

### 2. Data Preparation

Missing values, duplicates, data consistency, and logical relationships between fields were assessed before analysis.

### 3. Exploratory Data Analysis

SQL was used to investigate appointment outcomes and no-show patterns across:

- Appointment type
- Age group
- Reminder status
- Waiting time
- Booking lead time
- Distance to clinic
- Previous no-shows
- Appointment day
- Appointment time

### 4. Power BI Visualization

The cleaned dataset is being used to build a Power BI dashboard for monitoring appointment performance and no-show patterns.

---

# 📈 Key Findings

### High Overall No-Show Rate

HealthConnect recorded a **48.46% no-show rate**, meaning 2,423 out of 5,000 appointments resulted in missed appointments.

This highlights a significant attendance challenge for the clinic.

### Appointment Type

Follow-up appointments recorded the highest no-show rate at **51.23%**, followed by Diagnostic Tests at **49.75%**.

### Age Group

No-show rates varied across age groups. Patients aged **55–64 recorded the highest rate at 50.75%**, while patients aged **65 and above had the lowest rate at 45.12%**.

### Appointment Reminders

Patients who did not receive reminders had a no-show rate of **51.39%**, compared with **47.36%** among patients who received reminders.

This suggests that reminders may be associated with improved attendance.

### Waiting Time

No-show rates generally increased as waiting time increased, suggesting that longer waiting periods may be associated with a higher likelihood of missed appointments.

### Booking Lead Time

Booking lead time showed one of the clearest patterns in the analysis.

| Booking Lead Time | No-Show Rate |
|---|---:|
| 0–7 days | 27.81% |
| 8–14 days | 33.55% |
| 15–30 days | 43.21% |
| 31+ days | 60.49% |

Appointments booked further in advance were significantly more likely to result in no-shows.

### Distance to Clinic

Patients living more than **20 km from the clinic had the highest no-show rate at 56.35%**, compared with **46.40%** among patients living less than 5 km away.

### Previous No-Shows

Patients with a history of previous no-shows were more likely to miss future appointments. The no-show rate generally increased as the number of previous no-shows increased.

This makes previous attendance behaviour an important indicator of future no-show risk.

### Appointment Day

Sunday recorded the highest no-show rate at **50.47%**, while Friday recorded the lowest at **46.57%**. The variation across appointment days was relatively small.

### Appointment Time

Appointment patterns were also analysed across Morning, Afternoon, and Evening periods to identify differences in no-show behaviour.

---

# 💡 Business Insights

The analysis shows that HealthConnect's no-show challenge is associated with several patient and appointment characteristics.

The strongest patterns were observed around:

- Longer booking lead times
- Previous no-show history
- Longer waiting periods
- Greater distance from the clinic
- Reminder status

These findings suggest that HealthConnect can take a more targeted approach to reducing missed appointments rather than applying the same communication process to every patient.

---

# 📌 Business Recommendations

### 1. Implement Targeted Appointment Reminders

Provide additional reminders and follow-up communication to patients with a higher risk of missing appointments.

### 2. Identify High-Risk Patients

Use previous no-show history and appointment characteristics to identify patients who may require additional follow-up.

### 3. Review Long Booking Lead Times

Appointments booked 31 or more days in advance recorded the highest no-show rate. Where possible, appointments should be reconfirmed closer to the scheduled date.

### 4. Monitor Long Waiting Periods

HealthConnect should review appointments with long waiting periods and explore ways to reduce unnecessary delays.

### 5. Address Distance-Related Barriers

Patients travelling longer distances may benefit from earlier confirmation, flexible scheduling, or virtual appointment options where appropriate.

### 6. Monitor No-Show Patterns Continuously

A Power BI dashboard can help HealthConnect monitor appointment performance and identify emerging no-show patterns over time.

---

## 📊 Power BI Dashboard

The Power BI dashboard is being developed from the cleaned HealthConnect dataset.

It will monitor:

- Total Appointments
- No-Show Rate
- Attendance Rate
- Cancellation Rate
- Appointment Outcomes
- No-Show Rate by Appointment Type
- No-Show Rate by Age Group
- Reminder Status
- Booking Lead Time
- Previous No-Shows
- Distance to Clinic
- Appointment Day
- Appointment Time

*A dashboard screenshot will be added after the visualization is completed.*

---

## ⚠️ Assumptions and Limitations

- Each record represents one appointment.
- Appointment outcomes are assumed to be accurately recorded.
- The dataset is observational, so relationships identified in the analysis should not automatically be interpreted as causation.
- Some variables contain missing values and findings involving those fields should be interpreted within the context of the available data.
- Very small groups, particularly patients with a high number of previous no-shows, should be interpreted cautiously.

---

## 🚀 Tools Used

- **SQL Server Management Studio (SSMS):** Data cleaning, validation, and exploratory data analysis
- **SQL:** Data querying and analysis
- **Power BI:** Dashboard development and visualization
- **DAX:** KPI and measure creation
- **Excel:** Data export and supporting data review
- **GitHub:** Project documentation and portfolio presentation

---

## 📂 Project Structure

```text
HealthConnect-Appointment-Analytics/
│
├── Data/
│   └── Cleaned HealthConnect dataset
│
├── SQL/
│   ├── Data Cleaning.sql
│   └── EDA Queries.sql
│
├── PowerBI/
│   └── HealthConnect Dashboard.pbix
│
├── Images/
│   └── Dashboard screenshots
│
└── README.md[HealthConnect SQL file.sql](https://github.com/user-attachments/files/31883922/HealthConnect.SQL.file.sql)
[HealthConnect Analysis.pdf](https://github.com/user-attachments/files/31883921/HealthConnect.Analysis.pdf)
