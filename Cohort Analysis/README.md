# Retention, Cohorts & Churn

## Task Description
You got a follow-up task from your product manager to give stats on how subscription churn looks like from a weekly retention standpoint. Your PM argues that viewing retention numbers on a monthly basis takes too long and important insights from data might be missed out.

You remember learning previously that cohort analysis can be helpful in such cases. You should provide weekly subscription data that shows how many subscribers started their subscription in a particular week and how many remain active in the following 6 weeks. Your result should show weekly retention cohorts for each week of data available in the dataset and their retention from week 0 to week 6. Assume that you are doing this analysis on 2021-02-07.

You should use turing_data_analytics.subscriptions table to answer this question. Please write a SQL that would extract data from the BigQuery, create effective visualizations, by using a tool that you are familiar with such as Google Spreadsheets, Tableau, Looker Studio, or any other suitable data visualization tool, and briefly comment on your findings.


## Solution Summary
This sprint contains the SQL file for the customer retention rate for 6 weeks and the Cohort Analysis of this retention rate

Kindly utilise Microsoft Excel to open the xlsx file by selecting 'View Raw'

The problem involves providing weekly subscription data that shows how many subscribers started their subscription in a particular week and how many remain active in the following 6 weeks. Your end result should show weekly retention cohorts for each week of data available in the dataset and their retention from week 0 to week 6. Assume that you are doing this analysis on 2021-02-07.

![Cohort Analysis](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Cohort%20Analysis/images/Cohort%20Analysis.png)

Below is a visual of the number of subscribers in Cohort Weeks and the Customer Retention Rate

![Cohort Analysis](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Cohort%20Analysis/images/Cohort%20Analysis2.png)

### Main Insights
1. The week of December 20th 2020 had the highest retention rate.

2. November has the worst retention rate compared to December and January.

3. The number of subscribers saw a massive increase starting November 29th, 2020. However, from December 20th, 2020, there was a notable drop in subscriptions. This downward trend continued until the week of January 3rd, 2021 when numbers briefly increased again. Following this rise, the subscriber count began to drop once more.

4. After 6 weeks, The customers had an overall retention rate of 90%



