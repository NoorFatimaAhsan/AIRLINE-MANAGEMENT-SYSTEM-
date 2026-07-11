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

