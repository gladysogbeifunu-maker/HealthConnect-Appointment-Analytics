HealthConnect Appointment No-Show Analysis
Week 7 — Testing, Refinement & Validation (Data Analytics Track)
Author: Gladys Ogbeifun Programme: AnalystLab Africa — Data Analytics Internship Project: HealthConnect Clinic — reducing missed appointments through data & AI


Overview
Week 6 produced the advanced analytics report, six validated cross-segment findings, a data science handoff, and an improved Power BI dashboard with three new cross-segment views.

Week 7 shifted from building analysis to testing it — independently re-verifying that the dashboard and reported figures actually match the underlying data, rather than assuming they do.

No new analysis, no new dataset. This week validates what Week 6 already produced.


What Was Tested
Every number below was re-derived directly from SQL and compared against the live Power BI dashboard.

#
Test
Result
1
Outcome counts reconcile with total records.
✅ Pass
2
Outcome percentages sum to 100%.
✅ Pass
3
Previous no-show ordering holds across lead-time bands
✅ Pass
4
Reminder-status dashboard view (No = 51.39%, Yes = 47.36%)
⚠️ Failed twice → ✅ Fixed
5
Appointment-type dashboard view (31+ days lead time)
⚠️ Failed once → ✅ Fixed
6
Previous no-show history × lead time (72.96% high-risk segment)
⚠️ Failed once → ✅ Fixed
7
KPI cards match reported totals (filters cleared)
✅ Pass, first attempt
8
Dashboard usability review (labels, clarity, scaling)
✅ Pass, no changes needed



Issues Found & Fixed
Three of the eight tests failed on first attempt — all three shared the same underlying cause: the dashboard measures weren't correctly scoped by row-level context, even though the source data and SQL logic were correct throughout.

Issue
Root Cause
Fix
The reminder view showed one blended rate for both groups
Visual had no row-level filter context (card-style output).
Rebuilt as a Matrix with reminder_sent on Rows
The reminder view then showed the wrong rate.
The wrong measure was applied to the visual (lead-time measure instead of reminder measure).
Corrected the measure in the Values field
The appointment-type view showed one blended rate for all types.
Same root cause — missing row-level context
Rebuilt as a matrix with appointment_type on rows
The high-risk segment view showed only the "2+" row, the others blank.
Measure had a hardcoded previous_no_shows >= 2 filter that conflicted with row context for the "0" and "1" groups.
Removed the hardcoded condition; let the row-grouping column drive the split


Net result: no underlying figure from Week 6 required correction. Every discrepancy was a dashboard-construction issue, not an analytical error — and all are now resolved and re-tested.


Cross-Track Testing (Data Science)
A validation question was prepared for the Data Science track to check whether the previous-no-show × lead-time interaction (72.96%) surfaces as an important feature in their model:

"In your feature importance results, where does the previous-no-show × booking-lead-time interaction rank? I found it's the strongest single segment in the data (72.96% no-show rate) and want to confirm the model is picking it up."

Status: Not completed this cycle — no data science intern was available to receive and answer the question. Carried forward as a priority for Week 8.


Files in This Folder
HealthConnect_Week7_Report.docx — full testing & refinement report
HealthConnect_Week6_Report.docx — prior week's advanced analytics report (baseline)
HealthConnect_DataScience_Handoff.docx — Week 6 handoff document
dashboard/—updated .pbix file with corrected Matrix visuals
sql/ — query files used for each independent recalculation


Week 8 Priorities
Complete the Data Science cross-track validation once an intern is available.
Confirm whether the 72.96% interaction is retained as a model feature.
Prepare for final HC-POD integration and presentation



This README documents the Week 7 testing cycle only. See HealthConnect_Week7_Report.docx for the full test log, evidence, and validation record.

