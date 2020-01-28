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

 CREATE TABLE votes (
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    song_id INTEGER NOT NULL,
    FOREIGN KEY (song_id) REFERENCES songs (id) ON DELETE CASCADE
 );

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