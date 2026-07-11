-- =============================================================================
-- DATABASE QUERIES & DATA RETRIEVAL (DML)
-- Project: Airline Booking Management System
-- =============================================================================

-- -----------------------------------------------------------------------------
-- PAGE 10: FLIGHT SEARCH
-- Component Type: Interactive Report
-- Description: Fetches upcoming available flights matching search filters.
-- -----------------------------------------------------------------------------
SELECT 
    f.flight_no,
    al.airline_name,
    src.airport_name || ' (' || src.iata_code || ')' as from_airport,
    dst.airport_name || ' (' || dst.iata_code || ')' as to_airport,
    TO_CHAR(fs.departure_time, 'DD-MON-YYYY HH24:MI') as departure,
    TO_CHAR(fs.arrival_time, 'DD-MON-YYYY HH24:MI') as arrival,
    f.base_price as price_pkr,
    fs.total_seats,
    fs.flight_status,
    fs.schedule_id
FROM flight_schedule fs
JOIN flights f ON fs.flight_id = f.flight_id
JOIN airlines al ON f.airline_id = al.airline_id
JOIN airports src ON f.source_airport_id = src.airport_id
JOIN airports dst ON f.destination_airport_id = dst.airport_id
WHERE fs.departure_time > SYSDATE
  AND (src.iata_code = :P10_SOURCE OR :P10_SOURCE IS NULL)
  AND (dst.iata_code = :P10_DESTINATION OR :P10_DESTINATION IS NULL)
ORDER BY fs.departure_time;


-- -----------------------------------------------------------------------------
-- PAGE 13: VIEW TICKET
-- Component Type: Interactive Report (Electronic Ticket Receipt)
-- Description: Generates final receipt utilizing ticket numbers.
-- -----------------------------------------------------------------------------
SELECT 
    P.passport_no,
    P.nationality,
    B.seat_number,
    B.travel_class,
    B.meal_preference,
    T.ticket_number,
    T.issue_date,
    T.ticket_price,
    S.departure_time,
    S.arrival_time,
    A1.airport_name as departure_from,
    A2.airport_name as arrival_to
FROM Tickets T
JOIN Bookings B ON T.booking_id = B.booking_id
JOIN Passengers P ON B.passenger_id = P.passenger_id
LEFT JOIN FLIGHT_SCHEDULE S ON B.schedule_id = S.schedule_id
LEFT JOIN FLIGHTS F ON S.flight_id = F.flight_id
LEFT JOIN Airports A1 ON F.source_airport_id = A1.airport_id
LEFT JOIN Airports A2 ON F.destination_airport_id = A2.airport_id
WHERE T.ticket_number = :P13_TICKET_NUMBER;