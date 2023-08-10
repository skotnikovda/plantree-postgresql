CREATE FUNCTION delete_container() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM plan_items WHERE parent_id = OLD.id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_container BEFORE DELETE ON folders
    FOR EACH ROW EXECUTE PROCEDURE delete_container();

CREATE TRIGGER delete_container BEFORE DELETE ON folders
    FOR EACH ROW EXECUTE PROCEDURE delete_container();