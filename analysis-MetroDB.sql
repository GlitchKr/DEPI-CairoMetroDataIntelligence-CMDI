use MetroDB

--total passengers per station
--Purpose: find busiest stations

SELECT 
    s.station_name,
    SUM(p.passenger_count) AS total_passengers

FROM Passenger p
JOIN Station s ON p.station_id = s.station_id
GROUP BY s.station_name
ORDER BY total_passengers DESC;


--Find total revenue per month
--Purpose: monthly revenue trends
SELECT 
    t.month,
    SUM(tr.total_revenue_egp) AS total_revenue
FROM Trips tr
JOIN Time t ON tr.time_id = t.time_id
GROUP BY t.month
ORDER BY t.month;


--Purpose: Total passenger over months
SELECT 
    t.year,
    t.month,
    SUM(p.passenger_count) AS total_passengers
FROM Passenger p
JOIN Time t ON p.time_id = t.time_id
GROUP BY t.year, t.month
ORDER BY t.year, t.month;


--Purpose: Total revenue for each station
SELECT 
    s.station_name ,
    SUM(tr.total_revenue_egp) AS total_revenue
FROM Trips tr
JOIN Station s ON tr.origin_station_id = s.station_id
GROUP BY s.station_name
ORDER BY total_revenue DESC;



--Most profitable routes
--Know which station pairs bring in the most money
SELECT 
    s1.station_name AS origin_station,
    s2.station_name AS destination_station,
    SUM(tr.total_revenue_egp) AS total_revenue
FROM Trips tr
JOIN Station s1 ON tr.origin_station_id = s1.station_id
JOIN Station s2 ON tr.destination_station_id = s2.station_id
GROUP BY s1.station_name, s2.station_name
ORDER BY total_revenue DESC;


--Passenger count by weather description
SELECT 
    w.weather_desc,
    SUM(p.passenger_count) AS total_passengers
FROM Passenger p
JOIN Time t ON p.time_id = t.time_id
JOIN Weather w ON w.time_id = t.time_id
GROUP BY w.weather_desc
ORDER BY total_passengers DESC;


--review it one more time 
--Most common service problems
--Purpose: Understand which problems happen most often and how long they last
SELECT 
    reason,
    COUNT(*) AS occurrences,
    AVG(event_duration_min) AS avg_duration
FROM Service
GROUP BY reason
ORDER BY occurrences DESC;



--Purpose: Passanger by season
SELECT 
    t.season,
    SUM(p.passenger_count) AS total_passengers
FROM Passenger p
JOIN Time t ON p.time_id = t.time_id
GROUP BY t.season
ORDER BY total_passengers DESC;


--Average passengers per weather + period
--Purpose: How weather, service, and season affect usage
SELECT 
    w.weather_desc,
    t.period_of_day,
    AVG(p.passenger_count) AS avg_passengers
FROM Passenger p
JOIN Time t ON p.time_id = t.time_id
JOIN Weather w ON w.time_id = t.time_id
GROUP BY w.weather_desc, t.period_of_day
ORDER BY w.weather_desc, avg_passengers DESC;


--Purpose: the day with the highest passenger total

SELECT 
    p.date,
    t.year,
    t.month,
    SUM(p.passenger_count) AS total_passengers
FROM Passenger p
JOIN Time t ON p.time_id = t.time_id
GROUP BY p.date, t.year, t.month
ORDER BY  total_passengers DESC;

