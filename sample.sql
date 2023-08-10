INSERT INTO roots (user_id) VALUES (1);
INSERT INTO folders (parent_id, index, title) VALUES (1, 0, 'Birthdays');
INSERT INTO projects (parent_id, index, title) VALUES (1, 0, 'bachelor study');
INSERT INTO notes (parent_id, index, title, content) VALUES (1, 0, 'My note', 'Some note');
INSERT INTO folders (parent_id, index, title) VALUES (1, 3, 'Work');
INSERT INTO date_bounded_events (parent_id, index, title, begining, ending) 
VALUES (2, 0, 'Mom', '2023-11-17', '2023-11-17');
INSERT INTO date_bounded_events (parent_id, index, title, begining, ending) 
VALUES (2, 0, 'Dad', '2023-05-23', '2023-05-23');
INSERT INTO tasks (parent_id, index, title, is_complete, note) 
VALUES (3, 0, '1st year', true, 'Python and C');
INSERT INTO tasks (parent_id, index, title, is_complete, note) 
VALUES (3, 1, '2nd year', true, 'Algs and CG');
INSERT INTO tasks (parent_id, index, title, note) 
VALUES (3, 2, '3rd year', 'Lisp and Prolog');
INSERT INTO tasks (parent_id, index, title, note) 
VALUES (3, 3, '4th year', 'Ansible and Grafana');
INSERT INTO time_bounded_events (parent_id, index, title, begining, ending) 
VALUES (5, 0, 'Daily meeting', '2023-08-10 11:00', '2023-08-10 12:00');
