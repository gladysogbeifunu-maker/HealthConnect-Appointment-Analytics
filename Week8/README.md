HealthConnect Appointment No-Show Analysis
Week 8 — Final Analytics, Dashboard & Business Insights (Data Analytics Track)

Author: Gladys Ogbeifun Programme: AnalystLab Africa — Data Analytics Internship Project: HealthConnect Clinic — reducing missed appointments through data & AI

Overview

Week 7 tested and corrected the Week 6 dashboard, confirming every core finding against raw SQL. Week 8 finalizes that work into a decision-ready package: consolidated KPIs, six validated findings, a cross-track statistical check with Data Science, final recommendations, and presentation materials for the HC-POD final integration.

No new dataset, no new dashboard rebuild. This week packages and statistically strengthens what Weeks 5–7 already validated.

Final KPIs
KPI	Value
Total appointments	5,000
No-show rate	48.46%
Attended rate	46.28%
Cancelled rate	5.26%
Validated Findings — Final Status
Finding	Result	Status
Booking lead time	27.81% → 60.49%	Dashboard-confirmed + statistically significant (p<0.0001)
Prior no-shows	43.51% → 61.02%	Dashboard-confirmed + statistically significant (p<0.0001)
Prior no-shows × lead time	72.96% (highest segment)	Dashboard-confirmed; interaction-specific significance test still pending
Reminder status	51.39% vs. 47.36%	Dashboard-confirmed; not statistically significant once other factors controlled
Distance	46.45% → 59.63%	Statistically significant (p<0.0001)
Appointment type × lead time	58.10%–65.14%	Dashboard-confirmed; not statistically significant on its own

No underlying figure required correction this cycle — every earlier discrepancy was a dashboard-construction issue (Week 7), not an analytical error.

Cross-Track: Data Science Statistical Validation

Data Science ran a logistic regression testing the Week 6/7 findings alongside other candidate variables.

Confirmed significant (p < 0.05):

booking_lead_days (p < 0.0001)
previous_no_shows (p < 0.0001)
distance_to_clinic_km (p < 0.0001)
previous_appointments (p = 0.029) — new finding, not previously tested

Not significant, once other variables controlled:

reminder_sent — raw gap likely reflects other correlated factors
appointment_type — effect likely driven by lead time itself

Open question, sent but not yet answered:

Does the previous-no-show × lead-time combination add predictive power beyond its two main effects added separately? (Also flagged: an undefined p-value on reminder_sent_Yes, possibly a data/estimation issue.)

Recommendations (Final)
Prioritise the 72.96% high-risk segment operationally
Act on lead time and distance — both statistically confirmed
De-prioritise reminders as a standalone fix pending controlled testing
Re-scope Follow-up appointment guidance — likely a lead-time effect, not a type effect
Await Data Science's interaction-term test before treating the high-risk segment as more than the sum of its parts
Continue avoiding causal claims — statistical significance is not proof of causation

Files in This Folder
HealthConnect_Week8_Report.docx — full Final Analytics & Decision Support Package
HealthConnect_Week8_Presentation.pptx — 10-slide stakeholder deck
HealthConnect_Data Science_Statistical Validation Result.pdf — Cross-Track Model Output and Interpretation
