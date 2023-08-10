CREATE FUNCTION delete_plan_item() RETURNS TRIGGER AS $$
BEGIN
    UPDATE plan_items SET index = index - 1 
        WHERE parent_id = OLD.parent_id AND index > OLD.index;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_folder BEFORE DELETE ON folders
    FOR EACH ROW EXECUTE PROCEDURE delete_plan_item();

CREATE TRIGGER delete_project BEFORE DELETE ON projects
    FOR EACH ROW EXECUTE PROCEDURE delete_plan_item();

CREATE TRIGGER delete_task BEFORE DELETE ON tasks
    FOR EACH ROW EXECUTE PROCEDURE delete_plan_item();

CREATE TRIGGER delete_note BEFORE DELETE ON notes
    FOR EACH ROW EXECUTE PROCEDURE delete_plan_item();

CREATE TRIGGER delete_date_bounded_event BEFORE DELETE ON date_bounded_events
    FOR EACH ROW EXECUTE PROCEDURE delete_plan_item();

CREATE TRIGGER delete_time_bounded_event BEFORE DELETE ON time_bounded_events
    FOR EACH ROW EXECUTE PROCEDURE delete_plan_item();

