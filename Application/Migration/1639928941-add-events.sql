CREATE TABLE events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    start_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    end_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    lat REAL NOT NULL,
    lng REAL NOT NULL
);
CREATE TABLE event_users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    event_id UUID NOT NULL,
    user_id UUID NOT NULL
);
CREATE INDEX event_users_event_id_index ON event_users (event_id);
CREATE INDEX event_users_user_id_index ON event_users (user_id);
ALTER TABLE event_users ADD CONSTRAINT event_users_ref_event_id FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE NO ACTION;
ALTER TABLE event_users ADD CONSTRAINT event_users_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
