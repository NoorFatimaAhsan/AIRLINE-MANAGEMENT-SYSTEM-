-- =============================================================================
-- TRIGGERS
-- Project: Airline Booking Management System
-- Description: Automatically populates primary key fields using system sequences.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- AIRLINES AUTO-INCREMENT
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER AIRLINES_TRG
BEFORE INSERT ON AIRLINES
FOR EACH ROW
BEGIN
    :NEW.AIRLINE_ID := AIRLINES_SEQ.NEXTVAL;
END;
/

-- -----------------------------------------------------------------------------
-- AIRPORTS AUTO-INCREMENT
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER AIRPORTS_TRG
BEFORE INSERT ON AIRPORTS
FOR EACH ROW
BEGIN
    :NEW.AIRPORT_ID := AIRPORTS_SEQ.NEXTVAL;
END;
/

-- -----------------------------------------------------------------------------
-- FLIGHTS AUTO-INCREMENT
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER FLIGHTS_TRG
BEFORE INSERT ON FLIGHTS
FOR EACH ROW
BEGIN
    :NEW.FLIGHT_ID := FLIGHTS_SEQ.NEXTVAL;
END;
/

-- -----------------------------------------------------------------------------
-- FLIGHT_SCHEDULE AUTO-INCREMENT
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER SCHEDULE_TRG
BEFORE INSERT ON FLIGHT_SCHEDULE
FOR EACH ROW
BEGIN
    :NEW.SCHEDULE_ID := SCHEDULE_SEQ.NEXTVAL;
END;
/