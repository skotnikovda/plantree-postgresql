CREATE TABLE plan_items (
    id SERIAL PRIMARY KEY,
    parent_id INTEGER,
    index INTEGER,
    title VARCHAR,
    type CONTENT_TYPE NOT NULL,
    CHECK (false) NO INHERIT
);

CREATE TABLE roots (
    parent_id INTEGER GENERATED ALWAYS AS (NULL) STORED,
    title VARCHAR GENERATED ALWAYS AS (NULL) STORED,
    type CONTENT_TYPE GENERATED ALWAYS AS ('root') STORED,
    user_id INTEGER NOT NULL
) INHERITS (plan_items);

CREATE TABLE non_roots (
    parent_id INTEGER NOT NULL CHECK (id != parent_id) REFERENCES plan_items (id),
    title VARCHAR NOT NULL CHECK (title != ''),
    CHECK (false) NO INHERIT
) INHERITS (plan_items);

CREATE TABLE folders (
    type CONTENT_TYPE GENERATED ALWAYS AS ('folder') STORED
) INHERITS (plan_items);

CREATE TABLE projects (
    type CONTENT_TYPE GENERATED ALWAYS AS ('project') STORED,
    is_complete BOOLEAN NOT NULL DEFAULT false
) INHERITS (non_roots);

CREATE TABLE tasks (
    type CONTENT_TYPE GENERATED ALWAYS AS ('task') STORED,
    is_complete BOOLEAN NOT NULL DEFAULT false,
    note VARCHAR NOT NULL
) INHERITS (non_roots);

CREATE TABLE notes (
    type CONTENT_TYPE GENERATED ALWAYS AS ('note') STORED,
    content VARCHAR NOT NULL
) INHERITS (non_roots);

CREATE TABLE date_bounded_events (
    type CONTENT_TYPE GENERATED ALWAYS AS ('date_bounded_event') STORED,
    begining DATE NOT NULL,
    ending DATE NOT NULL CHECK (ending >= begining)
) INHERITS (non_roots);

CREATE TABLE time_bounded_events (
    type CONTENT_TYPE GENERATED ALWAYS AS ('time_bounded_event') STORED,
    begining TIMESTAMP NOT NULL,
    ending TIMESTAMP NOT NULL CHECK (ending >= begining)
) INHERITS (non_roots);