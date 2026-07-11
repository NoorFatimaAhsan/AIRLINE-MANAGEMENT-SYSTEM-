-- ============================================================
-- Airline Management System
-- SEQUENCES
-- One sequence per table, used to auto-generate primary keys
--
-- NOTE: Run this AFTER tables.sql and sample_data.sql.
-- Each sequence dynamically starts at MAX(existing_id) + 1,
-- so it always continues correctly no matter how many sample
-- rows you inserted (3, 10, 13... whatever). This avoids
-- ORA-00001 unique constraint collisions when the live
-- application later inserts a new record.
--
-- Run order: tables.sql -> sample_data.sql -> sequences.sql
-- ============================================================

DECLARE
    PROCEDURE create_seq_from_max(
        p_seq_name  VARCHAR2,
        p_table     VARCHAR2,
        p_col       VARCHAR2
    ) IS
        l_max   NUMBER;
        l_start NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT NVL(MAX(' || p_col || '),0) FROM ' || p_table
        INTO l_max;

        l_start := l_max + 1;

        EXECUTE IMMEDIATE
            'CREATE SEQUENCE ' || p_seq_name ||
            ' START WITH ' || l_start ||
            ' INCREMENT BY 1 NOCACHE NOCYCLE';

        DBMS_OUTPUT.PUT_LINE(p_seq_name || ' created starting at ' || l_start);
    END;
BEGIN
    create_seq_from_max('airline_seq',         'airlines',          'airline_id');
    create_seq_from_max('airport_seq',         'airports',          'airport_id');
    create_seq_from_max('flights_seq',         'flights',           'flight_id');
    create_seq_from_max('schedule_seq',        'flight_schedule',   'schedule_id');
    create_seq_from_max('people_seq',          'people',            'person_id');
    create_seq_from_max('user_seq',            'users',             'user_id');
    create_seq_from_max('passenger_seq',       'passengers',        'passenger_id');
    create_seq_from_max('booking_seq',         'bookings',          'booking_id');
    create_seq_from_max('ticket_seq',          'tickets',           'ticket_id');
    create_seq_from_max('baggage_seq',         'baggage',           'baggage_id');
    create_seq_from_max('payment_seq',         'payments',          'payment_id');
    create_seq_from_max('booking_payment_seq', 'booking_payments',  'booking_payment_id');
    create_seq_from_max('baggage_payment_seq', 'baggage_payments',  'baggage_payment_id');
END;
/
