-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    user_id UUID NOT NULL,
    is_blocked BOOLEAN DEFAULT false NOT NULL
);
CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    post_id UUID NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    user_id UUID NOT NULL,
    is_blocked BOOLEAN DEFAULT false NOT NULL
);
CREATE INDEX comments_post_id_index ON comments (post_id);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    is_admin BOOLEAN DEFAULT false NOT NULL
);
CREATE INDEX posts_user_id_index ON posts (user_id);
CREATE INDEX comments_user_id_index ON comments (user_id);
CREATE TABLE events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    start_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    end_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    loc POINT NOT NULL,
    user_id UUID NOT NULL,
    is_blocked BOOLEAN DEFAULT false NOT NULL
);
CREATE TABLE event_users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    event_id UUID NOT NULL,
    user_id UUID NOT NULL
);
CREATE INDEX event_users_event_id_index ON event_users (event_id);
CREATE INDEX event_users_user_id_index ON event_users (user_id);
CREATE INDEX events_user_id_index ON events (user_id);
ALTER TABLE comments ADD CONSTRAINT comments_ref_post_id FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE;
ALTER TABLE comments ADD CONSTRAINT comments_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE event_users ADD CONSTRAINT event_users_ref_event_id FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE;
ALTER TABLE event_users ADD CONSTRAINT event_users_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
ALTER TABLE events ADD CONSTRAINT events_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE posts ADD CONSTRAINT posts_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
