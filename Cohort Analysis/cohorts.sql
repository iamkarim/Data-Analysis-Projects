WITH week_date as (SELECT DATE_TRUNC(subscription_start,WEEK) cohort_week,
                          DATE_TRUNC(subscription_end,WEEK) sub_end_week FROM `turing_data_analytics.subscriptions`),
max_cohort_week AS (
    SELECT MAX(cohort_week) as max_week FROM week_date)

SELECT cohort_week,  
    COUNT(*) no_of_subscribers,
    SUM(CASE WHEN ((sub_end_week > cohort_week OR sub_end_week IS NULL) AND (cohort_week < max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_0,

    SUM(CASE WHEN ((sub_end_week > DATE_ADD(cohort_week, INTERVAL 1 WEEK) OR sub_end_week IS NULL) AND (DATE_ADD(cohort_week, INTERVAL 1 WEEK) <= max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_1,

    SUM(CASE WHEN ((sub_end_week > DATE_ADD(cohort_week, INTERVAL 2 WEEK) OR sub_end_week IS NULL) AND (DATE_ADD(cohort_week, INTERVAL 2 WEEK) <= max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_2,

    SUM(CASE WHEN ((sub_end_week > DATE_ADD(cohort_week, INTERVAL 3 WEEK) OR sub_end_week IS NULL) AND (DATE_ADD(cohort_week, INTERVAL 3 WEEK) <= max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_3,

    SUM(CASE WHEN ((sub_end_week > DATE_ADD(cohort_week, INTERVAL 4 WEEK) OR sub_end_week IS NULL) AND (DATE_ADD(cohort_week, INTERVAL 4 WEEK) <= max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_4,

    SUM(CASE WHEN ((sub_end_week > DATE_ADD(cohort_week, INTERVAL 5 WEEK) OR sub_end_week IS NULL) AND (DATE_ADD(cohort_week, INTERVAL 5 WEEK) <= max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_5,

    SUM(CASE WHEN ((sub_end_week > DATE_ADD(cohort_week, INTERVAL 6 WEEK) OR sub_end_week IS NULL) AND (DATE_ADD(cohort_week, INTERVAL 6 WEEK) <= max_cohort_week.max_week)) THEN 1 ELSE 0 END) week_6
    
FROM week_date,max_cohort_week
GROUP BY cohort_week
ORDER BY cohort_week
