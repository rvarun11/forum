ALTER TABLE events DROP COLUMN lat;
ALTER TABLE events DROP COLUMN lng;
ALTER TABLE events ADD COLUMN loc POINT NOT NULL;