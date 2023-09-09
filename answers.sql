-- 1.
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY date;

-- 2.
SELECT TOP 3 state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY SUM(revenue) DESC;
-- $37577

-- 3.
SELECT campaign_info.name, SUM(marketing_data.cost) AS total_cost, SUM(marketing_data.impressions) AS total_impressions, SUM(marketing_data.clicks) AS total_clicks, SUM(website_revenue.revenue) AS total_revenue
FROM ((campaign_info 
INNER JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id)
INNER JOIN website_revenue ON campaign_info.id = website_revenue.campaign_id)
GROUP BY campaign_info.name;

-- 4.
SELECT geo, sum(conversions) AS conv
FROM campaign_info INNER JOIN marketing_data
ON campaign_info.id = marketing_data.campaign_id
WHERE name = 'Campaign5'
GROUP BY geo
ORDER BY sum(conversions) DESC;
-- GA

-- 5.
SELECT name, ROUND(SUM(clicks)/SUM(impressions),2) AS click_thru_rate, ROUND(SUM(conversions)/SUM(clicks),2) AS conv_rate, ROUND(SUM(cost)/SUM(conversions),2) AS cost_per_conv, ROUND(SUM(revenue)/SUM(conversions),2) AS rev_per_conv, ROUND(SUM(cost)/SUM(revenue),4) AS cost_per_revenue
FROM ((campaign_info
INNER JOIN marketing_data
ON campaign_info.id = marketing_data.campaign_id)
INNER JOIN website_revenue
ON marketing_data.campaign_id = website_revenue.campaign_id)
GROUP BY name
ORDER BY ROUND(SUM(conversions)/SUM(clicks),2) DESC;
-- Campaign4 because they have the lowest click through rate, the second best conversion 
-- rate, the lowest cost per conversion, and generate the most revenue per conversion, and 
-- has the lowest cost per revenue generated.

-- 6.
SELECT MD.Day AS day_of_week, Round(AVG(MD.impressions),2) AS avg_impressions, ROUND(AVG(MD.clicks),2) AS avg_clicks, ROUND(AVG(MD.conversions),2) AS avg_conversions, ROUND(AVG(WR.revenue),2) AS avg_revenue, ROUND(avg_revenue/avg_conversions) AS avg_rev_per_conv, ROUND(avg_clicks/avg_impressions,2) AS avg_ctr, ROUND(avg_conversions/avg_clicks,2) AS avg_conv_rate
FROM marketing_data AS MD
INNER JOIN website_revenue AS WR on MD.Day = WR.Day
GROUP BY MD.Day
ORDER BY ROUND(AVG(WR.revenue),2) DESC;