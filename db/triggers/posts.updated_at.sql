CREATE OR REPLACE FUNCTION set_updated_at() RETURNS TRIGGER AS $break$
  BEGIN
    NEW.updated_at = now();
    return NEW;
  END
$break$ LANGUAGE plpgsql;

CREATE TRIGGER posts_updated_at_trigger BEFORE UPDATE ON posts
  FOR EACH ROW EXECUTE PROCEDURE set_updated_at();
