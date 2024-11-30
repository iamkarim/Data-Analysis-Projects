# Funnel Overview
This analysis examines the customer journey through the e-commerce platform across the top three markets: the United States, India, and Canada. The funnel analysis tracks six key stages of customer interaction, from initial page views to final purchases, providing insights into user behaviour and conversion patterns.

From a total of 855,657 events captured, we identified the following key stages in our conversion funnel:
- Page View (273,889 events)
- View Item (62,576 events)
- Add to Cart (12,802 events)
- Begin Checkout (9,852 events)
- Add Payment Information (5,873 events)
- Purchase (4,489 events)

The United States represents our largest market with 617,729 total events, followed by India (131,915 events) and Canada (106,013 events). The overall conversion rate from initial page view to purchase is 1.64%, with similar patterns observed across all three markets.

This analysis reveals critical drop-off points in the customer journey, particularly between the View Item and Add to Cart stages, as well as during the payment process. These insights will help guide optimization efforts to improve user experience and increase conversion rates across all markets.

## United States (Primary Markets)

As our largest market, the United States accounts for **72%** of total events. From **120,112** initial page views, only **1,973** resulted in purchases, representing a **1.64%** conversion rate.

![image](https://github.com/user-attachments/assets/60cd825e-7700-417c-89b0-a7ac22b1548d)

The most significant drop-off occurs between *View Item* (27,550) and *Add to Cart* (5,730), where we lose 77.1% of potential customers. The payment stage also shows considerable friction, with a 41.2% drop-off rate from Begin Checkout to Add Payment Info.

![image](https://github.com/user-attachments/assets/de63b90c-4ac0-4539-b39f-694a6e47179d)

## INDIA

India represents 15% of total events with **25,711** initial page views and **416** final purchases, showing a **1.62%** conversion rate. 

![image](https://github.com/user-attachments/assets/8825ac01-1629-43f8-a82e-f2ca953fcaba)

The funnel follows a similar pattern to the US market, with a **77%** drop-off between View Item and Add to Cart stages. However, India shows a slightly lower payment stage drop-off **(39.8%)** compared to the US market, suggesting slightly better payment process adoption.

![image](https://github.com/user-attachments/assets/4a12e6d9-2b64-4f15-afc3-17d081155ec3)

## CANADA

Canada contributes 13% of total events, with **20,548** page views converting to **359** purchases (**1.75%** conversion rate). 

![image](https://github.com/user-attachments/assets/c5f393e0-3c71-41c7-a08a-b1ff06f8ddf0)

While following similar patterns to other markets, Canada shows marginally better retention at key friction points, with a **76.9%** drop-off at the Add to Cart stage and **38.8%** at the payment stage, the lowest among all three markets.

![image](https://github.com/user-attachments/assets/85fa56f5-5a88-4417-8cef-839c3a6375c5)


### FINAL INSIGHTS

Major Dropoff Points
- The most severe drop occurs between View Item to Add to Cart (77.15% drop)
- The second biggest drop is at Begin Checkout to Add Payment Info (40.39% drop)
- Purchase stage loses about 23.57% of users


Conversion Metrics
- Overall purchase conversion from initial page view: ~1.64%
- Cart abandonment rate is notably high across all countries
- Payment stage completion rate is concerning (~40% drop)

### RECOMMENDATIONS

Payment Process Optimization 
- Streamline the payment form to reduce fields
- Add multiple payment options including local payment methods
- Implement smart error detection in forms
- Add progress indicators in checkout

General Improvements
- Add cart persistence across sessions
- Implement automated abandoned cart email campaigns
- Add product recommendations during checkout
- Optimize page load times across all regions



