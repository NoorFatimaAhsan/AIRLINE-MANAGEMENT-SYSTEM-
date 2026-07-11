-- ============================================================
-- Airline Management System
-- SAMPLE DATA (3 records per table)
-- Run AFTER: tables.sql, sequences.sql
-- Run BEFORE: using the APEX app (to avoid PK/sequence clashes,
-- run this first since IDs here start at 1, matching sequence START WITH 1)
-- ============================================================

-- ------------------------------------------------------------
-- AIRPORTS
-- ------------------------------------------------------------
INSERT INTO airports (airport_id, airport_name, iata_code, city, country)
VALUES (1, 'Jinnah International Airport', 'KHI', 'Karachi', 'Pakistan');

INSERT INTO airports (airport_id, airport_name, iata_code, city, country)
VALUES (2, 'Allama Iqbal International Airport', 'LHE', 'Lahore', 'Pakistan');

INSERT INTO airports (airport_id, airport_name, iata_code, city, country)
VALUES (3, 'Islamabad International Airport', 'ISB', 'Islamabad', 'Pakistan');

-- ------------------------------------------------------------
-- AIRLINES
-- ------------------------------------------------------------
INSERT INTO airlines (airline_id, airline_name, iata_code, country, contact_no, email)
VALUES (1, 'Pakistan International Airlines', 'PK', 'Pakistan', '02199044949', 'info@piac.com.pk');

INSERT INTO airlines (airline_id, airline_name, iata_code, country, contact_no, email)
VALUES (2, 'AirBlue', 'PA', 'Pakistan', '02111247258', 'info@airblue.com');

INSERT INTO airlines (airline_id, airline_name, iata_code, country, contact_no, email)
VALUES (3, 'SereneAir', 'ER', 'Pakistan', '02111737368', 'info@sereneair.com');

-- ------------------------------------------------------------
-- FLIGHTS
-- ------------------------------------------------------------
INSERT INTO flights (flight_id, flight_no, airline_id, source_airport_id, destination_airport_id, duration, base_price)
VALUES (4, 'PK-301', 1, 1, 2, INTERVAL '02:00:00' HOUR TO SECOND, 15000);

INSERT INTO flights (flight_id, flight_no, airline_id, source_airport_id, destination_airport_id, duration, base_price)
VALUES (5, 'PA-205', 2, 2, 3, INTERVAL '01:00:00' HOUR TO SECOND, 12000);

INSERT INTO flights (flight_id, flight_no, airline_id, source_airport_id, destination_airport_id, duration, base_price)
VALUES (6, 'ER-101', 3, 3, 1, INTERVAL '02:30:00' HOUR TO SECOND, 18000);

-- ------------------------------------------------------------
-- FLIGHT_SCHEDULE
-- ------------------------------------------------------------

INSERT INTO flight_schedule (schedule_id, flight_id, departure_time, arrival_time, total_seats, flight_status)
VALUES (5, 1, TO_TIMESTAMP('2026-08-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'),
              TO_TIMESTAMP('2026-08-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'Scheduled');

INSERT INTO flight_schedule (schedule_id, flight_id, departure_time, arrival_time, total_seats, flight_status)
VALUES (6, 2, TO_TIMESTAMP('2026-08-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),
              TO_TIMESTAMP('2026-08-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'Scheduled');

INSERT INTO flight_schedule (schedule_id, flight_id, departure_time, arrival_time, total_seats, flight_status)
VALUES (7, 3, TO_TIMESTAMP('2026-08-03 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),
              TO_TIMESTAMP('2026-08-03 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'Scheduled');

-- ------------------------------------------------------------
-- PEOPLE
-- ------------------------------------------------------------
INSERT INTO people (person_id, first_name, last_name, gender, dob, phone, email)
VALUES (1, 'Ali', 'Khan', 'Male', TO_DATE('1998-05-14', 'YYYY-MM-DD'), '03001234567', 'ali.khan@example.com');

INSERT INTO people (person_id, first_name, last_name, gender, dob, phone, email)
VALUES (2, 'Sara', 'Ahmed', 'Female', TO_DATE('1995-11-02', 'YYYY-MM-DD'), '03011234567', 'sara.ahmed@example.com');

INSERT INTO people (person_id, first_name, last_name, gender, dob, phone, email)
VALUES (3, 'Bilal', 'Hussain', 'Male', TO_DATE('2000-02-20', 'YYYY-MM-DD'), '03211234567', 'bilal.hussain@example.com');

-- ------------------------------------------------------------
-- USERS
-- ------------------------------------------------------------
INSERT INTO users (user_id, username, password, role, person_id)
VALUES (1, 'alikhan', 'hashed_pw_1', 'Customer', 1);

INSERT INTO users (user_id, username, password, role, person_id)
VALUES (2, 'saraahmed', 'hashed_pw_2', 'Customer', 2);

INSERT INTO users (user_id, username, password, role, person_id)
VALUES (3, 'bilalh', 'hashed_pw_3', 'Admin', 3);

-- ------------------------------------------------------------
-- PASSENGERS
-- ------------------------------------------------------------
INSERT INTO passengers (passenger_id, person_id, passport_no, nationality)
VALUES (1, 1, 'AB1234567', 'Pakistani');

INSERT INTO passengers (passenger_id, person_id, passport_no, nationality)
VALUES (2, 2, 'CD7654321', 'Pakistani');

INSERT INTO passengers (passenger_id, person_id, passport_no, nationality)
VALUES (3, 3, 'EF1122334', 'Pakistani');

-- ------------------------------------------------------------
-- BOOKINGS
-- ------------------------------------------------------------
INSERT INTO bookings (booking_id, schedule_id, user_id, passenger_id, seat_number, travel_class, meal_preference, booking_status)
VALUES (1, 5, 1, 1, '12A', 'Economy', 'Vegetarian', 'Confirmed');

INSERT INTO bookings (booking_id, schedule_id, user_id, passenger_id, seat_number, travel_class, meal_preference, booking_status)
VALUES (2, 6, 2, 2, '14C', 'Business', 'Non-Vegetarian', 'Confirmed');

INSERT INTO bookings (booking_id, schedule_id, user_id, passenger_id, seat_number, travel_class, meal_preference, booking_status)
VALUES (3, 7, 3, 3, '9F', 'Economy', 'No Preference', 'Pending');

-- ------------------------------------------------------------
-- TICKETS
-- ------------------------------------------------------------
INSERT INTO tickets (ticket_id, booking_id, ticket_number, ticket_price, baggage_allowed_kg, seat_number, ticket_status)
VALUES (1, 1, 'PK1001', 15000, 20, '12A', 'Issued');

INSERT INTO tickets (ticket_id, booking_id, ticket_number, ticket_price, baggage_allowed_kg, seat_number, ticket_status)
VALUES (2, 2, 'PK1002', 25000, 30, '14C', 'Issued');

INSERT INTO tickets (ticket_id, booking_id, ticket_number, ticket_price, baggage_allowed_kg, seat_number, ticket_status)
VALUES (3, 3, 'PK1003', 18000, 20, '9F', 'Issued');

-- ------------------------------------------------------------
-- BAGGAGE
-- ------------------------------------------------------------
INSERT INTO baggage (baggage_id, booking_id, weight_kg, baggage_type, allowed_weight_kg, excess_kg, status)
VALUES (1, 1, 18, 'Checked', 20, 0, 'Checked-In');

INSERT INTO baggage (baggage_id, booking_id, weight_kg, baggage_type, allowed_weight_kg, excess_kg, status)
VALUES (2, 2, 25, 'Checked', 20, 5, 'Checked-In');

INSERT INTO baggage (baggage_id, booking_id, weight_kg, baggage_type, allowed_weight_kg, excess_kg, status)
VALUES (3, 3, 22, 'Checked', 20, 2, 'Checked-In');

-- ------------------------------------------------------------
-- PAYMENTS
-- ------------------------------------------------------------
INSERT INTO payments (payment_id, payment_amount, payment_method, payment_status)
VALUES (1, 15000, 'Credit Card', 'Completed');

INSERT INTO payments (payment_id, payment_amount, payment_method, payment_status)
VALUES (2, 25000, 'Debit Card', 'Completed');

INSERT INTO payments (payment_id, payment_amount, payment_method, payment_status)
VALUES (3, 18000, 'Bank Transfer', 'Pending');

-- ------------------------------------------------------------
-- BOOKING_PAYMENTS
-- ------------------------------------------------------------
INSERT INTO booking_payments (booking_payment_id, payment_id, booking_id, ticket_number)
VALUES (1, 1, 1, 'PK1001');

INSERT INTO booking_payments (booking_payment_id, payment_id, booking_id, ticket_number)
VALUES (2, 2, 2, 'PK1002');

INSERT INTO booking_payments (booking_payment_id, payment_id, booking_id, ticket_number)
VALUES (3, 3, 3, 'PK1003');

-- ------------------------------------------------------------
-- BAGGAGE_PAYMENTS
-- (only baggage records 2 and 3 have excess weight;
--  a third sample row is added for record-count consistency)
-- ------------------------------------------------------------


INSERT INTO baggage_payments (baggage_payment_id, payment_id, baggage_id, excess_kg_charged, rate_per_kg)
VALUES (2, 2, 2, 5, 100);

INSERT INTO baggage_payments (baggage_payment_id, payment_id, baggage_id, excess_kg_charged, rate_per_kg)
VALUES (3, 3, 3, 2, 200);

COMMIT;
