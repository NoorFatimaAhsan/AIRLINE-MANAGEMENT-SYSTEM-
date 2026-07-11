CREATE TABLE airports (
    airport_id NUMBER PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    iata_code VARCHAR(3) UNIQUE NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE airlines (
    airline_id NUMBER PRIMARY KEY,
    airline_name VARCHAR2(100) NOT NULL,
    iata_code VARCHAR2(3) UNIQUE NOT NULL,
    country VARCHAR2(100),
    contact_no VARCHAR2(20),
    email VARCHAR2(100)
);

CREATE TABLE flights(
    flight_id NUMBER PRIMARY KEY,
    flight_no VARCHAR2(20) NOT NULL,
    airline_id NUMBER NOT NULL,
    source_airport_id NUMBER NOT NULL,
    destination_airport_id NUMBER NOT NULL,
    duration INTERVAL DAY TO SECOND,
    base_price NUMBER(10,2),
    CONSTRAINT fk_flights_airline FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    CONSTRAINT fk_flights_source FOREIGN KEY (source_airport_id) REFERENCES airports(airport_id),
    CONSTRAINT fk_flights_dest FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id)
);

CREATE TABLE flight_schedule(
    schedule_id NUMBER PRIMARY KEY,
    flight_id NUMBER NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    total_seats  NUMBER DEFAULT 150,
    flight_status VARCHAR2(20) DEFAULT 'Scheduled',
    CONSTRAINT fk_schedule_flight FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    CONSTRAINT chk_flight_status CHECK (flight_status IN ('Scheduled', 'Delayed', 'Cancelled', 'Departed', 'Arrived'))
);

CREATE TABLE People(
    person_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    gender VARCHAR2(10),
    dob DATE,
    phone VARCHAR2(20),
    email VARCHAR2(100) UNIQUE
);

CREATE TABLE users(
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password VARCHAR2(255) NOT NULL,
    role VARCHAR2(30) DEFAULT 'Customer',
    person_id NUMBER NOT NULL,
    created_date DATE DEFAULT SYSDATE,
    last_login DATE,
    CONSTRAINT fk_users_person FOREIGN KEY (person_id) REFERENCES people(person_id),
    CONSTRAINT chk_role CHECK (role IN ('Admin', 'Staff', 'Customer'))
);

CREATE TABLE passengers(
    passenger_id NUMBER PRIMARY KEY,
    person_id NUMBER NOT NULL,
    passport_no VARCHAR2(20) UNIQUE NOT NULL,
    nationality VARCHAR2(50),
    CONSTRAINT fk_passengers_person FOREIGN KEY (person_id) REFERENCES people(person_id)
);

CREATE TABLE bookings (
    booking_id NUMBER PRIMARY KEY,
    booking_date DATE DEFAULT SYSDATE,
    booking_status VARCHAR2(20) DEFAULT 'Pending',
    schedule_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    passenger_id NUMBER NOT NULL,
    seat_number VARCHAR2(10),
    travel_class VARCHAR2(20) DEFAULT 'Economy',
    meal_preference VARCHAR2(50),
    CONSTRAINT fk_bookings_schedule FOREIGN KEY (schedule_id) REFERENCES flight_schedule(schedule_id),
    CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_bookings_passenger FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    CONSTRAINT uk_passenger_flight UNIQUE (passenger_id, schedule_id),
    CONSTRAINT chk_booking_status CHECK (booking_status IN ('Pending', 'Confirmed', 'Cancelled', 'Completed'))
);

CREATE TABLE tickets (
    ticket_id NUMBER PRIMARY KEY,
    booking_id NUMBER UNIQUE NOT NULL,
    ticket_number VARCHAR2(50) UNIQUE NOT NULL,
    issue_date DATE DEFAULT SYSDATE,
    ticket_price NUMBER(10,2) NOT NULL,
    baggage_allowed_kg NUMBER(5,2) DEFAULT 20,
    seat_number VARCHAR2(10),
    ticket_status VARCHAR2(20) DEFAULT 'Issued',
    CONSTRAINT fk_tickets_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CONSTRAINT chk_ticket_status CHECK (ticket_status IN ('Issued', 'Used', 'Refunded', 'Cancelled'))
);

CREATE TABLE baggage(
    baggage_id NUMBER PRIMARY KEY,
    booking_id NUMBER NOT NULL,
    weight_kg NUMBER(5,2) NOT NULL,
    baggage_type VARCHAR2(50) NOT NULL,
    allowed_weight_kg NUMBER(5,2) DEFAULT 20,
    excess_kg NUMBER(5,2) DEFAULT 0,
    status VARCHAR2(20) DEFAULT 'Checked-In',
    CONSTRAINT fk_baggage_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CONSTRAINT chk_positive_weight CHECK (weight_kg > 0),
    CONSTRAINT chk_baggage_type CHECK (baggage_type IN ('Checked', 'Carry-on', 'Oversized', 'Special Item')),
    CONSTRAINT chk_baggage_status CHECK (status IN ('Checked-In', 'Loaded', 'Unloaded', 'Claimed', 'Lost'))
);

CREATE TABLE payments(
    payment_id NUMBER PRIMARY KEY,
    payment_date DATE DEFAULT SYSDATE,
    payment_amount NUMBER(10,2) NOT NULL,
    payment_method VARCHAR2(30) NOT NULL,
    payment_status VARCHAR2(20) DEFAULT 'Pending',
    CONSTRAINT chk_payment_amount CHECK (payment_amount >= 0),
    CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    CONSTRAINT chk_payment_method CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Cash', 'Bank Transfer'))
);

CREATE TABLE booking_payments (
    booking_payment_id NUMBER PRIMARY KEY,
    payment_id NUMBER NOT NULL UNIQUE,
    booking_id NUMBER NOT NULL,
    ticket_number VARCHAR2(50),
    CONSTRAINT fk_bp_payment FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
    CONSTRAINT fk_bp_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE baggage_payments (
    baggage_payment_id NUMBER PRIMARY KEY,
    payment_id NUMBER NOT NULL UNIQUE,
    baggage_id NUMBER NOT NULL,
    excess_kg_charged NUMBER(5,2),
    rate_per_kg NUMBER(5,2),
    CONSTRAINT fk_bgp_payment FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
    CONSTRAINT fk_bgp_baggage FOREIGN KEY (baggage_id) REFERENCES baggage(baggage_id)
);

