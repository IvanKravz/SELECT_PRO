-- SELECT PRO

-- Количество исполнителей в каждом жанре.

SELECT name, COUNT(artist_id) artist_q FROM artists_music_genres amg  
JOIN music_genres mg ON amg.genre_id = mg.genre_id
GROUP BY mg.name
ORDER BY artist_q DESC;

-- Количество треков, вошедших в альбомы 2019–2020 годов.

SELECT year_release, COUNT(tracks_id) track_q FROM collection_tracks ct  
JOIN music_collection mc ON mc.collection_id = ct.collection_id
WHERE year_release >= 2019 and year_release <= 2020 
GROUP BY mc.year_release
ORDER BY track_q DESC;

-- Средняя продолжительность треков по каждому альбому.

SELECT name_albums na, AVG(duration) dur FROM albums a
JOIN tracks t ON t.tracks_id = a.albums_id
GROUP BY a.name_albums
ORDER BY dur DESC;

-- Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT name_artist FROM artists a2  
JOIN albums a ON a2.artist_id = a.albums_id 
WHERE year_release != 2020
GROUP BY a2.name_artist;

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).

SELECT name_collection FROM artists a 
JOIN music_collection mc ON mc.collection_id = a.artist_id 
WHERE name_artist = 'Кино'
GROUP BY mc.name_collection;

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.

SELECT name_albums, count(name_ganre) FROM albums a
JOIN music_genres amg ON a.albums_id = amg.genre_id 
GROUP BY a.name_albums
HAVING COUNT(name_ganre) > 1;

-- Наименования треков, которые не входят в сборники.

SELECT name_track FROM tracks t 
full JOIN collection_tracks ct ON ct.tracks_id = t.tracks_id 
full JOIN music_collection mc ON mc.collection_id = ct.collection_id
WHERE ct.collection_id IS NULL;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.

SELECT name_artist FROM artists a 
JOIN artists_albums aa ON a.artist_id = aa.artist_id
JOIN albums a2 ON a2.albums_id = aa.albums_id 
JOIN tracks t ON t.albums_id = a2.albums_id
WHERE t.duration = (SELECT min(duration) FROM tracks);

-- Названия альбомов, содержащих наименьшее количество треков.

SELECT name_albums, COUNT(name_track) FROM albums a
JOIN tracks t ON a.albums_id = t.albums_id
GROUP BY a.name_albums
HAVING COUNT(name_track) = (SELECT min(COUNT) FROM (
	SELECT name_albums, COUNT(name_track) FROM albums a
	JOIN tracks t ON a.albums_id = t.albums_id
	GROUP BY a.name_albums) AS foo);



