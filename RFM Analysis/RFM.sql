WITH rfm_reference AS (SELECT CustomerID,
                              MAX(InvoiceDate) last_purchase_date,
                              COUNT(DISTINCT InvoiceNo) frequency,
                              SUM(UnitPrice * Quantity) monetary,
                              FROM `turing_data_analytics.rfm`
                              WHERE InvoiceDate BETWEEN '2010-12-01' AND '2011-12-02' AND CustomerID IS NOT NULL AND InvoiceNo NOT LIKE 'C%' AND UnitPrice > 0
                              GROUP BY CustomerID
                      ),

recency AS (SELECT *,
                DATE_DIFF(DATE('2011-12-01'), DATE(last_purchase_date), DAY) AS recency
        FROM rfm_reference
    ),

rfm_value as (SELECT CustomerID,
                     recency.recency recency,
                     recency.frequency frequency,
                     recency.monetary monetary
FROM recency
-- LEFT JOIN `turing_data_analytics.rfm_value` rfm_value
-- ON recency.CustomerID = rfm_value.customerID
-- WHERE rfm_value.customerID IS NOT NULL
ORDER BY frequency,recency DESC),

percentiles AS (
SELECT 
    a.*,
    --All percentiles for MONETARY
    b.percentiles[offset(25)] AS m25, 
    b.percentiles[offset(50)] AS m50,
    b.percentiles[offset(75)] AS m75,    
    --All percentiles for FREQUENCY
    c.percentiles[offset(25)] AS f25, 
    c.percentiles[offset(50)] AS f50,
    c.percentiles[offset(75)] AS f75, 

    --All percentiles for RECENCY
    d.percentiles[offset(25)] AS r25, 
    d.percentiles[offset(50)] AS r50,
    d.percentiles[offset(75)] AS r75, 
FROM 
    rfm_value a,
    (SELECT APPROX_QUANTILES(monetary, 100) percentiles FROM
    rfm_value) b,
    (SELECT APPROX_QUANTILES(frequency, 100) percentiles FROM
    rfm_value) c,
    (SELECT APPROX_QUANTILES(recency, 100) percentiles FROM
    rfm_value) d
),

rfm_score AS (
    SELECT *, 
    CAST(ROUND((f_score + m_score) / 2, 0) AS INT64) AS fm_score
    FROM (
        SELECT *, 
        CASE WHEN monetary <= m25 THEN 1
            WHEN monetary <= m50 AND monetary > m25 THEN 2 
            WHEN monetary <= m75 AND monetary > m50 THEN 3 
            WHEN monetary > m75 THEN 4
        END AS m_score,
        CASE WHEN frequency <= f25 THEN 1
            WHEN frequency <= f50 AND frequency > f25 THEN 2 
            WHEN frequency <= f75 AND frequency > f50 THEN 3 
            WHEN frequency > f75 THEN 4
        END AS f_score,
        --Recency scoring is reversed
        CASE WHEN recency <= r25 THEN 4
            WHEN recency <= r50 AND recency > r25 THEN 3
            WHEN recency <= r75 AND recency > r50 THEN 2 
            WHEN recency > r75 THEN 1
        END AS r_score,
        FROM percentiles
        )
),

rfm AS (
    SELECT 
        CustomerID,
        recency,
        frequency,
        monetary,
        r_score,
        f_score,
        m_score,
        fm_score,
        CASE WHEN (r_score = 4 AND fm_score = 4) 
        THEN 'Best Customers'
        WHEN (r_score = 3 AND fm_score = 4) 
            OR (r_score = 4 AND fm_score = 3)
            OR (r_score = 3 AND fm_score = 3)
        THEN 'Loyal Customers'
        WHEN (r_score = 4 AND fm_score = 2) 
            OR (r_score = 4 AND fm_score = 1)
            OR (r_score = 3 AND fm_score = 2)
            OR (r_score = 3 AND fm_score = 1)
        THEN 'Potential Loyalists'
        WHEN (r_score = 2 AND fm_score = 4) 
        THEN 'At Risk'
        WHEN (r_score = 2 AND fm_score = 2) 
            OR (r_score = 2 AND fm_score = 3)
        THEN 'Customers Needing Attention'
        WHEN (r_score = 1 AND fm_score = 3)
            OR (r_score = 1 AND fm_score = 4)        
        THEN 'Cant Lose Them'
        WHEN r_score = 2 AND fm_score = 1 
            OR (r_score = 1 AND fm_score = 2)
        THEN 'Hibernating'
        WHEN r_score = 1 AND fm_score = 1 THEN 'Lost'
        END AS rfm_segment 
    FROM rfm_score
)

SELECT * FROM rfm