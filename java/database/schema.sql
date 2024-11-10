START TRANSACTION;

DROP TABLE IF EXISTS users_artist, artist, joke, users CASCADE;

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE joke (
    joke_id serial PRIMARY KEY,
    joke varchar(200),
    user_id int,
--    setting up the fk constraint to the users table
--    user_id in joke table relates to the id in the users table
    CONSTRAINT FK_users FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE artist (
	artist_id serial PRIMARY KEY,
	artist_name varchar(200),
	artist_spotify_id varchar(200),
	followers int
);

CREATE TABLE users_artist (
	user_id int,
	artist_id int,
	CONSTRAINT PK_users_artist PRIMARY KEY (user_id, artist_id),
	CONSTRAINT FK_users FOREIGN KEY (user_id) REFERENCES users (user_id),
	CONSTRAINT FK_artist FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

COMMIT TRANSACTION;

