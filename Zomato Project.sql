USE zomato_project;

SHOW TABLES;
DESCRIBE dim_location;
DESCRIBE dim_cuisine;
DESCRIBE dim_price;
DESCRIBE dim_rating;
DESCRIBE fact_restaurant;

USE zomato_project;

SELECT 'dim_location' AS table_name, COUNT(*) AS row_count
FROM dim_location

UNION ALL

SELECT 'dim_cuisine', COUNT(*)
FROM dim_cuisine

UNION ALL

SELECT 'dim_price', COUNT(*)
FROM dim_price

UNION ALL

SELECT 'dim_rating', COUNT(*)
FROM dim_rating

UNION ALL

SELECT 'fact_restaurant', COUNT(*)
FROM fact_restaurant;
SELECT COUNT(*) AS total_restaurants
FROM fact_restaurant;
SELECT *
FROM fact_restaurant
LIMIT 10;
SELECT COUNT(*) AS total_restaurants
FROM fact_restaurant;

SELECT
    l.city,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
GROUP BY l.city
ORDER BY restaurant_count DESC;

SELECT
    l.city,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
GROUP BY l.city
ORDER BY restaurant_count DESC
LIMIT 10;

SELECT
    restaurant_id,
    restaurant_name
FROM fact_restaurant
ORDER BY restaurant_name;
SELECT
    r.rating_text,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
GROUP BY r.rating_text
ORDER BY restaurant_count DESC;
SELECT
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0;
SELECT
    l.city,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY l.city
ORDER BY average_rating DESC;
SELECT
    l.city,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY l.city
HAVING COUNT(*) >= 10
ORDER BY average_rating DESC;
SELECT
    c.cuisine_name,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
GROUP BY c.cuisine_name
ORDER BY restaurant_count DESC;

SELECT
    c.cuisine_name,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
GROUP BY c.cuisine_name
ORDER BY restaurant_count DESC
LIMIT 10;

SELECT
    c.cuisine_name,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY c.cuisine_name
ORDER BY average_rating DESC;

SELECT
    c.cuisine_name,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY c.cuisine_name
HAVING COUNT(*) >= 20
ORDER BY average_rating DESC;
SELECT
    p.price_range,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_price p
    ON f.price_id = p.price_id
GROUP BY p.price_range
ORDER BY p.price_range;
SELECT
    p.price_range,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(f.average_cost_for_two), 2) AS average_cost
FROM fact_restaurant f
JOIN dim_price p
    ON f.price_id = p.price_id
GROUP BY p.price_range
ORDER BY p.price_range;
SELECT
    p.price_range,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_price p
    ON f.price_id = p.price_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY p.price_range
ORDER BY p.price_range;

SELECT
    p.price_range,
    ROUND(AVG(f.votes), 0) AS average_votes,
    SUM(f.votes) AS total_votes
FROM fact_restaurant f
JOIN dim_price p
    ON f.price_id = p.price_id
GROUP BY p.price_range
ORDER BY p.price_range;
SELECT
    restaurant_name,
    votes
FROM fact_restaurant
ORDER BY votes DESC
LIMIT 10;

SELECT
    f.restaurant_name,
    r.aggregate_rating,
    f.votes
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
ORDER BY r.aggregate_rating DESC, f.votes DESC
LIMIT 10;

SELECT
    f.restaurant_name,
    r.aggregate_rating,
    f.votes
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating >= 4
  AND f.votes >= 500
ORDER BY r.aggregate_rating DESC, f.votes DESC;

SELECT
    has_online_delivery,
    COUNT(*) AS restaurant_count
FROM fact_restaurant
GROUP BY has_online_delivery;

SELECT
    f.has_online_delivery,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating,
    ROUND(AVG(f.votes), 0) AS average_votes
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY f.has_online_delivery;

SELECT
    f.has_online_delivery,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating,
    ROUND(AVG(f.votes), 0) AS average_votes
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY f.has_online_delivery;

SELECT
    f.has_table_booking,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating,
    ROUND(AVG(f.votes), 0) AS average_votes
FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY f.has_table_booking;

SELECT
    COUNT(*) AS restaurants_with_both_services
FROM fact_restaurant
WHERE has_table_booking = 1
  AND has_online_delivery = 1;
  
  SELECT
    CASE
        WHEN has_table_booking = 1
             AND has_online_delivery = 1
            THEN 'Both Services'

        WHEN has_table_booking = 1
             AND has_online_delivery = 0
            THEN 'Table Booking Only'

        WHEN has_table_booking = 0
             AND has_online_delivery = 1
            THEN 'Online Delivery Only'

        ELSE 'No Services'
    END AS service_type,

    COUNT(*) AS restaurant_count

FROM fact_restaurant
GROUP BY service_type
ORDER BY restaurant_count DESC;

SELECT
    CASE
        WHEN has_table_booking = 1
             AND has_online_delivery = 1
            THEN 'Both Services'

        WHEN has_table_booking = 1
             AND has_online_delivery = 0
            THEN 'Table Booking Only'

        WHEN has_table_booking = 0
             AND has_online_delivery = 1
            THEN 'Online Delivery Only'

        ELSE 'No Services'
    END AS service_type,

    COUNT(*) AS restaurant_count

FROM fact_restaurant
GROUP BY service_type
ORDER BY restaurant_count DESC;

SELECT
    CASE
        WHEN f.has_table_booking = 1
             AND f.has_online_delivery = 1
            THEN 'Both Services'

        WHEN f.has_table_booking = 1
             AND f.has_online_delivery = 0
            THEN 'Table Booking Only'

        WHEN f.has_table_booking = 0
             AND f.has_online_delivery = 1
            THEN 'Online Delivery Only'

        ELSE 'No Services'
    END AS service_type,

    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating,
    ROUND(AVG(f.votes), 0) AS average_votes

FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id

WHERE r.aggregate_rating > 0

GROUP BY service_type
ORDER BY average_rating DESC;

SELECT
    l.city,
    c.cuisine_name,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY l.city, c.cuisine_name
ORDER BY l.city, average_rating DESC;

SELECT
    l.city,
    c.cuisine_name,
    COUNT(*) AS restaurant_count
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
GROUP BY
    l.city,
    c.cuisine_name
ORDER BY
    l.city,
    restaurant_count DESC;
    SELECT
    p.price_range,
    ROUND(AVG(f.average_cost_for_two), 2) AS average_cost,
    ROUND(AVG(r.aggregate_rating), 2) AS average_rating
FROM fact_restaurant f
JOIN dim_price p
    ON f.price_id = p.price_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating > 0
GROUP BY p.price_range
ORDER BY p.price_range;

SELECT
    f.restaurant_name,
    l.city,
    c.cuisine_name,
    r.aggregate_rating,
    f.average_cost_for_two,
    f.votes
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating >= 4
  AND f.average_cost_for_two <= 1000
  AND f.votes >= 100
ORDER BY
    r.aggregate_rating DESC,
    f.votes DESC;
    
    SELECT
    f.restaurant_name,
    l.city,
    c.cuisine_name,
    r.aggregate_rating,
    f.average_cost_for_two,
    f.votes
FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id
WHERE r.aggregate_rating >= 4
  AND f.average_cost_for_two <= 1000
  AND f.votes >= 100
ORDER BY
    r.aggregate_rating DESC,
    f.votes DESC;
    
    SELECT
    l.city,
    f.restaurant_name,
    r.aggregate_rating,
    f.votes,

    RANK() OVER (
        PARTITION BY l.city
        ORDER BY r.aggregate_rating DESC, f.votes DESC
    ) AS city_rank

FROM fact_restaurant f
JOIN dim_location l
    ON f.location_id = l.location_id
JOIN dim_rating r
    ON f.rating_id = r.rating_id

WHERE r.aggregate_rating > 0;

WITH ranked_restaurants AS (

    SELECT
        l.city,
        f.restaurant_name,
        r.aggregate_rating,
        f.votes,

        RANK() OVER (
            PARTITION BY l.city
            ORDER BY r.aggregate_rating DESC, f.votes DESC
        ) AS city_rank

    FROM fact_restaurant f
    JOIN dim_location l
        ON f.location_id = l.location_id
    JOIN dim_rating r
        ON f.rating_id = r.rating_id

    WHERE r.aggregate_rating > 0
)

SELECT *
FROM ranked_restaurants
WHERE city_rank <= 3
ORDER BY city, city_rank;

SELECT
    restaurant_id,
    COUNT(*) AS duplicate_count
FROM fact_restaurant
GROUP BY restaurant_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS missing_names
FROM fact_restaurant
WHERE restaurant_name IS NULL
   OR restaurant_name = '';
   
   SELECT *
FROM dim_rating
WHERE aggregate_rating < 0
   OR aggregate_rating > 5;
   
   SELECT *
FROM dim_price
WHERE price_range NOT BETWEEN 1 AND 4;

SELECT *
FROM fact_restaurant
WHERE votes < 0;

SELECT
    COUNT(*) AS total_restaurants,

    ROUND(
        AVG(
            CASE
                WHEN r.aggregate_rating > 0
                THEN r.aggregate_rating
            END
        ), 2
    ) AS average_rating,

    ROUND(
        AVG(f.average_cost_for_two), 2
    ) AS average_cost_for_two,

    SUM(f.votes) AS total_votes,

    SUM(
        CASE
            WHEN f.has_online_delivery = 1
            THEN 1
            ELSE 0
        END
    ) AS restaurants_with_online_delivery,

    SUM(
        CASE
            WHEN f.has_table_booking = 1
            THEN 1
            ELSE 0
        END
    ) AS restaurants_with_table_booking

FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id;
    
    SELECT
    COUNT(*) AS total_restaurants,

    ROUND(
        AVG(
            CASE
                WHEN r.aggregate_rating > 0
                THEN r.aggregate_rating
            END
        ), 2
    ) AS average_rating,

    ROUND(
        AVG(f.average_cost_for_two), 2
    ) AS average_cost_for_two,

    SUM(f.votes) AS total_votes,

    SUM(
        CASE
            WHEN f.has_online_delivery = 1
            THEN 1
            ELSE 0
        END
    ) AS restaurants_with_online_delivery,

    SUM(
        CASE
            WHEN f.has_table_booking = 1
            THEN 1
            ELSE 0
        END
    ) AS restaurants_with_table_booking

FROM fact_restaurant f
JOIN dim_rating r
    ON f.rating_id = r.rating_id;
    
    CREATE OR REPLACE VIEW vw_zomato_restaurant_analysis AS

SELECT
    f.restaurant_id,
    f.restaurant_name,

    l.city,

    c.cuisine_name,

    p.price_range,

    r.aggregate_rating,
    r.rating_text,
    r.rating_color,

    f.average_cost_for_two,
    f.votes,

    f.has_table_booking,
    f.has_online_delivery,
    f.is_delivering_now,

    CASE
        WHEN f.has_table_booking = 1
             AND f.has_online_delivery = 1
            THEN 'Both Services'

        WHEN f.has_table_booking = 1
             AND f.has_online_delivery = 0
            THEN 'Table Booking Only'

        WHEN f.has_table_booking = 0
             AND f.has_online_delivery = 1
            THEN 'Online Delivery Only'

        ELSE 'No Services'
    END AS service_type

FROM fact_restaurant f

LEFT JOIN dim_location l
    ON f.location_id = l.location_id

LEFT JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id

LEFT JOIN dim_price p
    ON f.price_id = p.price_id

LEFT JOIN dim_rating r
    ON f.rating_id = r.rating_id;

CREATE OR REPLACE VIEW vw_zomato_restaurant_analysis AS
SELECT
    f.restaurant_id,
    f.restaurant_name,
    l.city,
    c.cuisine_name,
    p.price_range,
    r.aggregate_rating,
    r.rating_text,
    r.rating_color,
    f.average_cost_for_two,
    f.votes,
    f.has_table_booking,
    f.has_online_delivery,
    f.is_delivering_now,

    CASE
        WHEN f.has_table_booking = 1
             AND f.has_online_delivery = 1
            THEN 'Both Services'

        WHEN f.has_table_booking = 1
             AND f.has_online_delivery = 0
            THEN 'Table Booking Only'

        WHEN f.has_table_booking = 0
             AND f.has_online_delivery = 1
            THEN 'Online Delivery Only'

        ELSE 'No Services'
    END AS service_type

FROM fact_restaurant f

LEFT JOIN dim_location l
    ON f.location_id = l.location_id

LEFT JOIN dim_cuisine c
    ON f.cuisine_id = c.cuisine_id

LEFT JOIN dim_price p
    ON f.price_id = p.price_id

LEFT JOIN dim_rating r
    ON f.rating_id = r.rating_id;

    