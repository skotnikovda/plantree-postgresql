CREATE FUNCTION insert_plan_item() RETURNS TRIGGER AS $$
DECLARE
    last_index_available INT := (SELECT COALESCE(MAX(index) + 1, 0)
    FROM plan_items WHERE parent_id = NEW.parent_id);
BEGIN
    IF NEW.index < 0 OR NEW.index > last_index_available THEN
        RAISE EXCEPTION 'Incorrect plan item index. Expected between 0 and %, got %', last_index_available, NEW.index;
    END IF;
    UPDATE plan_items SET index = index + 1 
        WHERE parent_id = NEW.parent_id AND index >= NEW.index AND id != NEW.id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_folder AFTER INSERT ON folders
    FOR EACH ROW EXECUTE PROCEDURE insert_plan_item();

CREATE TRIGGER insert_project AFTER INSERT ON projects
    FOR EACH ROW EXECUTE PROCEDURE insert_plan_item();

CREATE TRIGGER insert_task AFTER INSERT ON tasks
    FOR EACH ROW EXECUTE PROCEDURE insert_plan_item();

CREATE TRIGGER insert_note AFTER INSERT ON notes
    FOR EACH ROW EXECUTE PROCEDURE insert_plan_item();

CREATE TRIGGER insert_date_bounded_event AFTER INSERT ON date_bounded_events
    FOR EACH ROW EXECUTE PROCEDURE insert_plan_item();

CREATE TRIGGER insert_time_bounded_event AFTER INSERT ON time_bounded_events
    FOR EACH ROW EXECUTE PROCEDURE insert_plan_item();