ALTER TABLE comments ADD COLUMN is_blocked BOOLEAN DEFAULT false NOT NULL;
ALTER TABLE posts ADD COLUMN is_blocked BOOLEAN DEFAULT false NOT NULL;