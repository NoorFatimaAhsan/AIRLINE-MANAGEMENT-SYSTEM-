-- ============================================================
-- Airline Management System
-- SEQUENCES
-- One sequence per table, used to auto-generate primary keys
-- ============================================================

-- Airlines
CREATE SEQUENCE airline_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Airports
CREATE SEQUENCE airport_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Flights
CREATE SEQUENCE flights_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Flight Schedule
CREATE SEQUENCE schedule_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- People
CREATE SEQUENCE people_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Users
CREATE SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Passengers
CREATE SEQUENCE passenger_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Bookings
CREATE SEQUENCE booking_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Tickets
CREATE SEQUENCE ticket_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Baggage
CREATE SEQUENCE baggage_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Payments
CREATE SEQUENCE payment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Booking_Payments
CREATE SEQUENCE booking_payment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Baggage_Payments
CREATE SEQUENCE baggage_payment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;