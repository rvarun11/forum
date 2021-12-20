ALTER TABLE events ADD COLUMN user_id UUID NOT NULL;
CREATE INDEX events_user_id_index ON events (user_id);
ALTER TABLE events ADD CONSTRAINT events_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
