CREATE TYPE CONTENT_TYPE AS ENUM (
    'root',
    'folder',
    'project', 
    'task', 
    'note',
    'date_bounded_event',
    'time_bounded_event'
);