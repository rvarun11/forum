ALTER TABLE events DROP COLUMN lat;
ALTER TABLE events DROP COLUMN lng;
ALTER TABLE events ADD COLUMN lat TEXT NOT NULL;
ALTER TABLE events ADD COLUMN lng TEXT NOT NULL;
ALTER TABLE event_users DROP CONSTRAINT event_users_ref_event_id;
ALTER TABLE event_users DROP CONSTRAINT event_users_ref_user_id;
ALTER TABLE event_users ADD CONSTRAINT event_users_ref_event_id FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE;
ALTER TABLE event_users ADD CONSTRAINT event_users_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
