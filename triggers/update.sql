CREATE FUNCTION update_plan_item() RETURNS TRIGGER AS $$
DECLARE
    last_index_available INT := (SELECT COALESCE(MAX(index) + 1, 0)
    FROM plan_items WHERE parent_id = NEW.parent_id);
BEGIN
    IF NEW.index != OLD.index THEN
        IF NEW.index < 0 OR NEW.index > last_index_available THEN
            RAISE EXCEPTION 'Incorrect plan item index. Expected between 0 and %, got %', last_index_available, NEW.index;
        END IF;
        IF NEW.index > OLD.index THEN
            UPDATE plan_items SET index = index - 1 
                WHERE parent_id = OLD.parent_id AND index > OLD.index AND index <= NEW.index;
        ELSE
            UPDATE plan_items SET index = index + 1 
                WHERE parent_id = OLD.parent_id AND index < OLD.index AND index >= NEW.index;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_folder BEFORE UPDATE ON folders
    FOR EACH ROW WHEN (pg_trigger_depth() = 0)
    EXECUTE PROCEDURE update_plan_item();

CREATE TRIGGER update_project BEFORE UPDATE ON projects
    FOR EACH ROW WHEN (pg_trigger_depth() = 0)
        EXECUTE PROCEDURE update_plan_item();

CREATE TRIGGER update_task BEFORE UPDATE ON tasks
    FOR EACH ROW WHEN (pg_trigger_depth() = 0)
        EXECUTE PROCEDURE update_plan_item();

CREATE TRIGGER update_note BEFORE UPDATE ON notes
    FOR EACH ROW WHEN (pg_trigger_depth() = 0)
    EXECUTE PROCEDURE update_plan_item();

CREATE TRIGGER update_date_bounded_event BEFORE UPDATE ON date_bounded_events
    FOR EACH ROW WHEN (pg_trigger_depth() = 0)
    EXECUTE PROCEDURE update_plan_item();

CREATE TRIGGER update_time_bounded_event BEFORE UPDATE ON time_bounded_events
    FOR EACH ROW WHEN (pg_trigger_depth() = 0)
    EXECUTE PROCEDURE update_plan_item();