-- database
CREATE DATABASE weekly_playlists;

\c weekly_playlists

-- CREATE TABLE roles (
--     id SERIAL PRIMARY KEY,
--     role VARCHAR(255)
-- )

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password_digest VARCHAR(400),
    -- FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE 
    admin BOOLEAN
);

ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);

CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    album VARCHAR(255),
    preview VARCHAR(255),
    link VARCHAR(255),
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE 
);

ALTER TABLE songs ADD COLUMN cover VARCHAR(255);
ALTER TABLE songs ALTER COLUMN cover TYPE VARCHAR(500);
ALTER TABLE songs ALTER COLUMN link TYPE VARCHAR(500);
ALTER TABLE songs ALTER COLUMN preview TYPE VARCHAR(500);
ALTER TABLE songs ADD COLUMN archived BOOLEAN;
ALTER TABLE songs ADD UNIQUE (title, artist);

CREATE TABLE votes (
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    song_id INTEGER NOT NULL,
    FOREIGN KEY (song_id) REFERENCES songs (id) ON DELETE CASCADE
);

ALTER TABLE votes ADD UNIQUE (user_id, song_id);

CREATE TABLE playlists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    create_date TIMESTAMPTZ NOT NULL
);

CREATE TABLE playlists_songs (
    playlist_id INTEGER NOT NULL,
    FOREIGN KEY (playlist_id) REFERENCES playlists (id) ON DELETE CASCADE,
    song_id INTEGER NOT NULL,
    FOREIGN KEY (song_id) REFERENCES songs (id) ON DELETE CASCADE
);

ALTER TABLE playlists_songs ADD UNIQUE (playlist_id, song_id);