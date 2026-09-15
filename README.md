# HealthConnect Appointment No-Show Analysis

## 📊 Project Overview

The **HealthConnect Appointment No-Show Analysis** is a data analytics project focused on understanding appointment attendance and identifying patterns associated with patient no-shows.

The project analyses **5,000 appointment records** using **SQL and Power BI** to investigate appointment outcomes, booking behaviour, previous no-show history, reminders, distance, appointment type, age, and other demographic and scheduling factors.

The project progressed from descriptive analysis in Week 5 to **advanced analytics and decision support in Week 6**, with deeper cross-segment analysis and a handoff of analytical findings to the Data Science track for further statistical and predictive validation.

---

## 🎯 Business Problem

Missed appointments can affect healthcare scheduling, resource utilization, operational efficiency, and patient access.

HealthConnect needs to better understand:

* How frequently appointments are missed.
* Which appointment characteristics are associated with higher no-show rates.
* Whether booking lead time is related to attendance.
* Whether previous no-show behaviour is associated with future no-shows.
* How reminders relate to appointment attendance.
* Whether distance and appointment type show meaningful patterns.
* Which patient and appointment segments may require further investigation.

The goal of this project is to transform appointment data into **actionable insights that can support better appointment management and future predictive analysis**.

---

## 🎯 Project Objectives

The analysis aimed to:

1. Measure overall appointment outcomes.
2. Calculate no-show, attended, and cancelled rates.
3. Validate data quality and key analytical fields.
4. Identify patterns in appointment no-shows.
5. Analyse booking lead time and attendance.
6. Examine previous no-show history.
7. Investigate reminder status.
8. Analyse distance-related patterns.
9. Compare appointment types.
10. Identify high-risk combinations of variables.
11. Develop evidence-based business recommendations.
12. Provide analytical findings for further Data Science investigation.
13. Improve the Power BI dashboard for decision support.

---

## 🗂️ Dataset

The HealthConnect dataset contains:

* **5,000 appointment records**
* **18 variables**

The analysis includes variables relating to:

* Appointment outcome
* Appointment type
* Booking lead time
* Reminder status
* Previous no-shows
* Distance
* Age
* Gender
* Appointment date/time
* Other appointment characteristics

The working SQL table used for analysis was:

`dbo.HealthConnect_Appointment_Working`

---

# 📈 Key KPIs

| KPI                |     Result |
| ------------------ | ---------: |
| Total Appointments |      5,000 |
| No-Shows           |      2,423 |
| No-Show Rate       | **48.46%** |
| Attended           |      2,314 |
| Attended Rate      | **46.28%** |
| Cancelled          |        263 |
| Cancelled Rate     |  **5.26%** |

The overall no-show rate of **48.46%** means that almost half of the appointments in the dataset resulted in no-shows.

---

# 🔎 Key Findings

## 1. Booking Lead Time

Booking lead time showed one of the strongest observed patterns in the analysis.

| Booking Lead Time | No-Show Rate |
| ----------------- | -----------: |
| 0–7 days          |       27.81% |
| 8–14 days         |       33.55% |
| 15–30 days        |       43.21% |
| 31+ days          |   **60.49%** |

Appointments booked 31+ days in advance had a **60.49% no-show rate**, compared with **27.81%** for appointments booked 0–7 days in advance.

This represents a **32.68 percentage-point difference**.

---

## 2. Previous No-Show History

Patients with previous no-show history showed higher observed no-show rates.

| Previous No-Show Group | No-Show Rate |
| ---------------------- | -----------: |
| No previous no-shows   |       43.51% |
| 1 previous no-show     |       53.49% |
| 2+ previous no-shows   |   **61.02%** |

The observed no-show rate increased as previous no-show history increased.

---

## 3. Previous No-Shows × Booking Lead Time

The cross-segment analysis revealed an important high-risk combination.

The highest observed no-show rate was:

> **2+ previous no-shows + 31+ days booking lead time = 72.96%**

This interaction was identified as an important area for further Data Science investigation.

---

## 4. Reminder Status

| Reminder    | No-Show Rate |
| ----------- | -----------: |
| No reminder |       51.39% |
| Reminder    |       47.36% |

Appointments with reminders had a **4.03 percentage-point lower observed no-show rate**.

However, this is an observed association and does **not** establish that reminders caused the difference.

---

## 5. Distance

The 21+ km distance group had the highest observed no-show rate among the known distance categories.

| Distance Group | No-Show Rate |
| -------------- | -----------: |
| 0–5 km         |       46.45% |
| 6–10 km        |       47.01% |
| 11–20 km       |       49.30% |
| 21+ km         |   **59.63%** |

When distance was analysed together with booking lead time, the highest observed combination was:

> **21+ km + 31+ days = 71.15% no-show rate**

There were **90 records with missing distance information**, which is an important limitation of the distance analysis.

---

## 6. Appointment Type × Booking Lead Time

Long booking lead times produced the highest observed no-show rate across all appointment types.

| Appointment Type        | 31+ Day No-Show Rate |
| ----------------------- | -------------------: |
| Follow-up               |           **65.14%** |
| Diagnostic Test         |               59.55% |
| Specialist Consultation |               59.18% |
| General Consultation    |               58.10% |

The highest observed appointment-type segment was **Follow-up appointments booked 31+ days in advance**, with a no-show rate of **65.14%**.

---

# 📊 Power BI Dashboard

The Power BI dashboard was developed to communicate appointment outcomes and no-show patterns.

### Main KPIs

* Total Appointments
* No-Show Rate
* Cancelled Rate
* Attended Rate

### Main Visuals

* No-Show Rate by Appointment Time
* No-Show Rate by Appointment Type
* No-Show Rate by Appointment Day
* No-Show Rate by Previous No-Show Group
* No-Show Rate by Age Group
* No-Show Rate by Distance Group
* No-Show Rate by Booking Lead Time Group
* Appointment Outcome by Reminder

### Slicers

* Year-Month
* Gender

### Week 6 Dashboard Enhancement

The dashboard was refined with deeper cross-segment analysis focusing on:

* Previous No-Show Group × Booking Lead Time
* Appointment Type × Booking Lead Time
* Distance Group × Booking Lead Time

These additional analyses moved the dashboard beyond basic descriptive reporting toward **advanced analytics and decision support**.

---

# 🧮 SQL Analysis

SQL was used for:

* Data validation
* KPI validation
* Appointment outcome analysis
* No-show rate calculations
* Booking lead-time analysis
* Reminder analysis
* Previous no-show analysis
* Distance analysis
* Appointment type analysis
* Cross-segment analysis

Examples of advanced analyses include:

```text
Previous No-Show Group × Booking Lead Time
Distance Group × Booking Lead Time
Appointment Type × Booking Lead Time
Reminder × Booking Lead Time
```

SQL was also used to validate the figures presented in Power BI.

---

# 💡 Business Recommendations

Based on the observed patterns, the following areas are recommended for further investigation:

### 1. Investigate long booking lead times

Appointments scheduled 31+ days in advance showed substantially higher no-show rates.

### 2. Investigate previous no-show behaviour

Patients with previous no-shows had higher observed no-show rates and may be an important segment for further analysis.

### 3. Investigate high-risk combinations

The combination of previous no-show history and long booking lead time produced the highest observed no-show rate.

### 4. Evaluate reminder effectiveness

The lower observed no-show rate among appointments with reminders should be investigated using statistical testing before drawing causal conclusions.

### 5. Investigate distance-related patterns

The higher observed no-show rate among patients travelling 21+ km warrants further investigation.

### 6. Investigate long-lead-time follow-up appointments

Follow-up appointments booked 31+ days in advance had a 65.14% observed no-show rate.

### 7. Support future predictive modelling

The identified variables and interactions can provide candidate features for Data Science modelling and statistical testing.

---

# 🤝 Data Science Handoff

The Week 6 analysis provides the Data Science track with validated analytical evidence for further investigation.

Potential variables for predictive modelling include:

* Booking lead days
* Previous no-show history
* Reminder status
* Distance
* Appointment type
* Age
* Gender
* Appointment day/time
* Other validated appointment characteristics

Potential interactions include:

* Previous no-show history × booking lead time
* Distance × booking lead time
* Appointment type × booking lead time
* Reminder × booking lead time

The Data Science track can further evaluate:

* Statistical significance
* Predictive strength
* Feature importance
* Interaction effects
* Model performance
* Model interpretability

---

# ⚠️ Data Limitations

Several limitations were identified:

* The analysis is primarily descriptive and diagnostic.
* Observed relationships do not establish causation.
* Statistical significance has not yet been established for all relationships.
* Predictive performance has not yet been tested.
* 90 records have missing distance information.
* Reminder analysis may be affected by other differences between appointment groups.
* Findings are based on the available HealthConnect dataset and should not automatically be generalized to other healthcare settings.

---

# 🛠️ Tools & Technologies

### Data Analysis

* Microsoft SQL Server
* SQL

### Data Visualization

* Microsoft Power BI
* DAX

### Documentation

* GitHub
* Microsoft Word

---

# 📁 Project Structure

```text
HealthConnect-Appointment-Analytics/
│
├── README.md
│
├── SQL/
│   └── HealthConnect_Appointment_Analysis.sql
│
├── PowerBI/
│   └── HealthConnect_Appointment_No_Show_Dashboard
│
├── Documentation/
│   └── Week_6_Advanced_Analytics_Report
│
└── Screenshots/
    └── PowerBI_Dashboard_Screenshots
```

---

# 📌 Project Status

**Week 6 — Advanced Analytics & Decision Support: Completed**

The project has progressed from initial exploratory analysis and dashboard development to deeper cross-segment analysis, dashboard refinement, business recommendations, and Data Science handoff.

### Next Stage: Week 7

The next stage will focus on analytical testing, including:

* Statistical testing
* Predictive modelling
* Feature evaluation
* Interaction testing
* Model evaluation
* Explainability
* Business validation

---

## 👩🏽‍💻 My Role

**Data Analyst**

I was responsible for:

* Data validation
* SQL analysis
* KPI development and validation
* Exploratory and advanced analysis
* Cross-segment analysis
* Power BI dashboard development and refinement
* Insight generation
* Business recommendations
* Data Science handoff preparation
* Documentation of analytical limitations and findings

---

## 📚 Key Learning Outcomes

This project strengthened my practical experience in:

* SQL data analysis
* Data validation
* KPI development
* Advanced segmentation
* Cross-variable analysis
* Power BI dashboard development
* DAX
* Business insight generation
* Data storytelling
* Analytical documentation
* Cross-functional collaboration between Data Analytics and Data Science

---

## ⚠️ Analytical Note

The findings in this project describe **observed patterns and associations within the HealthConnect dataset**. They should not be interpreted as causal relationships without further statistical testing or experimental evidence.

The project demonstrates the process of moving from **raw appointment data → validated analysis → business insights → decision support → Data Science handoff**.
