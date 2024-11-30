# Customer Lifetime Value (CLV) Task
TIP: imagine that the current week is 2021-01-24 (the last weekly cohort you have in your dataset).

As the first step, you should write 1 or 2 queries to pull data of weekly revenue divided by registrations. Since in this particular site there is no concept of registration, we will simply use the first visit to our website as the registration date (registration cohort). Do not forget to use user_pseudo_id to distinguish between users. Then divide revenue in consequent weeks by the number of weekly registration numbers.

## Weekly Average Revenue by Cohorts (USD)
Next, you will produce the same chart, but the revenue/registrations for a particular week cohort will be expressed as a cumulative sum. For this you simply need to add the previous week's revenue to the current week’s revenue. Down below you will calculate averages for all week numbers (weeks since registration). 

## Cumulative Revenue by Cohorts (USD)
This gives you growth of revenue by registered users in the cohort for n weeks after registration. This provides you with a coherent view of how much revenue you can expect to grow based on your historical data.

## Revenue Prediction by Cohorts (USD)
You should calculate the average cumulative revenue for the 12th week for all users who have been on your website. This not only provide a better estimate of CLV for all your users who have been on your website (including the ones who did not purchase anything) but also allows you to see trends for weekly cohorts.

# RFM Task
- Use only one year of data, 2010-12-01 to 2011-12-01.
- Use SQL for calculation and data selection.
- Calculate recency, frequency and money value and convert those values into R, F and M scores by using Quartiles, 1 to 4 values. In BigQuery, a function APPROX_QUANTILES is used to set the quartiles.
- Calculate recency from date 2011-12-01.
- Calculate common RFM score. An example of a possible answer is given in the table rfm_score.
- Segment customers into Best Customers, Loyal Customers, Big Spenders, Lost Customers and other categories.
- Present your analyses with a dashboard by using one of these tools: Tableau/Power Bi/Looker Studio.
- Present some insights on which customer group/customer groups should the marketing team get focus on.



