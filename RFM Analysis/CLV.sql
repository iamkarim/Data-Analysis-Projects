-- Gathering all the users first entry into the website
WITH first_visit_users as (SELECT DISTINCT user_pseudo_id as User, 
                                  MIN(PARSE_DATE('%Y%m%d', event_date)) as Registration_Date, 
                                  MIN(event_timestamp) First_visit 
                           FROM `tc-da-1.turing_data_analytics.raw_events`
                           GROUP BY user_pseudo_id),
-- Users who have made purchases in the website
purchase_users as (SELECT user_pseudo_id as User, 
                          PARSE_DATE('%Y%m%d', event_date) as Purchase_date, 
                          purchase_revenue_in_usd as Revenue 
                   FROM `tc-da-1.turing_data_analytics.raw_events`
                   WHERE event_name='purchase' AND purchase_revenue_in_usd>0), 
-- Getting the week the user made their first visit and their last purchase
cohort_raw_data as (SELECT f.user as first_user, 
                           DATE_TRUNC(Registration_Date, week) as Registration_week, 
                           DATE_TRUNC(Purchase_date, week) as Purchase_week,
                           Revenue 
                    FROM first_visit_users f
                    LEFT JOIN purchase_users p 
                    ON f.user = p.user),
-- Segmenting the registration and purchase weeks and getting the Differences between them
cohort_week as (SELECT first_user, 
                       Registration_week, 
                       purchase_week, 
                       DATE_DIFF(purchase_week, Registration_week, week) as week_diff,
                       revenue
                FROM cohort_raw_data)
-- Breaking the users into different week segments  
SELECT Registration_week, 
  	   COUNT(first_user) as Registrations,
       SUM(IF(week_diff = 0, revenue, 0)) AS week_0,
       SUM(IF(week_diff = 1, revenue, 0)) AS week_1,
       SUM(IF(week_diff = 2, revenue, 0)) AS week_2,
       SUM(IF(week_diff = 3, revenue, 0)) AS week_3,
       SUM(IF(week_diff = 4, revenue, 0)) AS week_4,
       SUM(IF(week_diff = 5, revenue, 0)) AS week_5,
       SUM(IF(week_diff = 6, revenue, 0)) AS week_6,
       SUM(IF(week_diff = 7, revenue, 0)) AS week_7,
       SUM(IF(week_diff = 8, revenue, 0)) AS week_8,
       SUM(IF(week_diff = 9, revenue, 0)) AS week_9,
       SUM(IF(week_diff = 10, revenue, 0)) AS week_10,
       SUM(IF(week_diff = 11, revenue, 0)) AS week_11,
       SUM(IF(week_diff = 12, revenue, 0)) AS week_12
FROM cohort_week 
GROUP BY Registration_week
HAVING Registration_week <= '2021-01-24'
ORDER BY Registration_week;
