
-- TABLE
CREATE TABLE item (
  id serial PRIMARY KEY,
  name VARCHAR (50) NOT NULL,
  price integer NOT NULL,
  created_at TIMESTAMP NOT NULL
);

-- FUNCTION
CREATE OR REPLACE FUNCTION notify_new_item()
  RETURNS trigger AS
$BODY$
    BEGIN
        PERFORM pg_notify('new_item', row_to_json(NEW)::text);
        RETURN NULL;
    END; 
$BODY$
LANGUAGE plpgsql VOLATILE;

-- TRIGGER
CREATE TRIGGER notify_new_item
  AFTER INSERT
  ON "item"
  FOR EACH ROW
  EXECUTE PROCEDURE notify_new_item();