-- -----------------------------------------------------------------------------
-- SECURITY & AUTHENTICATION FUNCTIONS
-- Component Type: Custom Authentication Scheme Function
-- Description: Validates user credentials against the USERS table for application access.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION custom_auth (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
) RETURN BOOLEAN AS
    l_count NUMBER;
BEGIN
    SELECT count(*)
    INTO   l_count
    FROM   USERS
    WHERE  UPPER(username) = UPPER(p_username)
    AND    password = p_password;

    IF l_count > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/


-- =============================================================================
-- APPLICATION BACKEND PROCESSES (PL/SQL)
-- Project: Airline Booking Management System
-- =============================================================================

-- -----------------------------------------------------------------------------
-- PAGE 11: BOOK FLIGHT
-- Component Type: Page Process (PL/SQL)
-- Description: Transaction handling for creating a passenger, generating 
--              bookings, baggage checks, processing payments, and ticketing.
-- -----------------------------------------------------------------------------
DECLARE
    l_passenger_id   NUMBER;
    l_booking_id     NUMBER;
    l_baggage_id     NUMBER;
    l_payment_id     NUMBER;
    l_ticket_seq     NUMBER;
    l_ticket_number  VARCHAR2(50);
    l_excess_kg      NUMBER := 0;
    l_rate_per_kg    NUMBER := 1500;
BEGIN
    IF :P11_PERSON_ID IS NULL OR :P11_USER_ID IS NULL THEN
        raise_application_error(-20002, 'Session Error: PERSON_ID or USER_ID is missing.');
    END IF;

    INSERT INTO Passengers (passenger_id, person_id, passport_no, nationality) 
    VALUES (passenger_seq.NEXTVAL, :P11_PERSON_ID, :P11_PASSPORT_NO, :P11_NATIONALITY)
    RETURNING passenger_id INTO l_passenger_id;

    INSERT INTO Bookings (
        booking_id, passenger_id, schedule_id, user_id, 
        booking_date, seat_number, travel_class, meal_preference, booking_status
    )
    VALUES (
        booking_seq.NEXTVAL, l_passenger_id, :P11_SCHEDULE_ID, :P11_USER_ID, 
        SYSDATE, :P11_SEAT_NUMBER, :P11_TRAVEL_CLASS, :P11_MEAL_PREFERENCE, 'Confirmed'
    )
    RETURNING booking_id INTO l_booking_id;

    IF :P11_WEIGHT_KG > 20 THEN
        l_excess_kg := :P11_WEIGHT_KG - 20;
    END IF;

    INSERT INTO Baggage (
        baggage_id, booking_id, weight_kg, baggage_type, 
        allowed_weight_kg, excess_kg, status
    )
    VALUES (
        baggage_seq.NEXTVAL, l_booking_id, :P11_WEIGHT_KG, 
        :P11_BAGGAGE_TYPE, 20, l_excess_kg, 'Checked-In'
    )
    RETURNING baggage_id INTO l_baggage_id;

    INSERT INTO Payments (
        payment_id, payment_date, payment_amount, payment_method, payment_status
    )
    VALUES (payment_seq.NEXTVAL, SYSDATE, :P11_PRICE, :P11_PAYMENT_METHOD, 'Completed')
    RETURNING payment_id INTO l_payment_id;

    SELECT ticket_seq.NEXTVAL INTO l_ticket_seq FROM dual;
    l_ticket_number := 'PK' || l_ticket_seq;

    INSERT INTO Tickets (
        ticket_id, booking_id, ticket_number, issue_date, 
        ticket_price, baggage_allowed_kg, seat_number, ticket_status
    )
    VALUES (l_ticket_seq, l_booking_id, l_ticket_number, SYSDATE, :P11_PRICE, 20, :P11_SEAT_NUMBER, 'Issued');

    INSERT INTO Booking_Payments (booking_payment_id, payment_id, booking_id, ticket_number)
    VALUES (booking_payment_seq.NEXTVAL, l_payment_id, l_booking_id, l_ticket_number);

    IF l_excess_kg > 0 THEN
        INSERT INTO Baggage_Payments (
            baggage_payment_id, payment_id, baggage_id, excess_kg_charged, rate_per_kg
        )
        VALUES (baggage_payment_seq.NEXTVAL, l_payment_id, l_baggage_id, l_excess_kg, l_rate_per_kg);
    END IF;

    :P11_TICKET_DISPLAY := l_ticket_number;
    :P13_TICKET_NUMBER  := l_ticket_number;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        raise_application_error(-20001, 'An unexpected error occurred. Transaction rolled back to maintain data integrity.');
END;
/


-- -----------------------------------------------------------------------------
-- PAGE 4: SIGN UP
-- Component Type: Page Process (PL/SQL Registration)
-- Description: Handles multi-table inserts into transactional identity structures.
-- -----------------------------------------------------------------------------
DECLARE
    l_new_id NUMBER;
BEGIN
    INSERT INTO People (person_id, first_name, last_name, gender, dob, phone, email)
    VALUES (people_seq.NEXTVAL, :P_FIRST_NAME, :P_LAST_NAME, :P_GENDER, :P_DOB, :P_PHONE, :P_EMAIL)
    RETURNING person_id INTO l_new_id;

    INSERT INTO Users (user_id, person_id, username, password, role)
    VALUES (user_seq.NEXTVAL, l_new_id, :P_USERNAME, :P_PASSWORD, 'Customer');
END;
/

