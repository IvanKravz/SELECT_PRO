CREATE TABLE music_genres (
	genre_id SERIAL PRIMARY KEY,
	name_ganre VARCHAR(60) NOT NULL UNIQUE 
);

CREATE TABLE artists (
	artist_id SERIAL PRIMARY KEY,
	name_artist VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE albums (
	albums_id SERIAL PRIMARY KEY,
	name_albums VARCHAR(60) NOT NULL UNIQUE,
	Year_release INTEGER NOT NULL 
);

CREATE TABLE tracks (
	tracks_id SERIAL PRIMARY KEY,
	albums_id INTEGER REFERENCES albums(albums_id),
	name_track VARCHAR(60) NOT NULL,
	duration INTEGER NOT NULL
);

CREATE TABLE music_collection (
	collection_id SERIAL PRIMARY KEY,
	name_collection VARCHAR(60) NOT NULL UNIQUE,
	Year_release INTEGER NOT NULL
);

CREATE TABLE artists_music_genres (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER REFERENCES artists(artist_id),
	genre_id INTEGER REFERENCES music_genres(genre_id)
);

CREATE TABLE artists_albums (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER REFERENCES artists(artist_id),
	albums_id INTEGER REFERENCES albums(albums_id)
);

CREATE TABLE collection_tracks (
	id SERIAL PRIMARY KEY,
	collection_id INTEGER REFERENCES music_collection(collection_id),
	tracks_id INTEGER REFERENCES tracks(tracks_id)
);
