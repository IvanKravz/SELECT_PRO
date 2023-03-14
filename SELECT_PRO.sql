-- SELECT PRO

-- Количество исполнителей в каждом жанре.

SELECT name_ganre, COUNT(artist_id) artist_q FROM artists_music_genres amg  
JOIN music_genres mg ON amg.genre_id = mg.genre_id
GROUP BY mg.name_ganre
ORDER BY artist_q DESC;

-- Количество треков, вошедших в альбомы 2019–2020 годов.

SELECT COUNT(tracks_id) track_q FROM collection_tracks ct  
JOIN music_collection mc ON mc.collection_id = ct.collection_id
WHERE year_release >= 2019 and year_release <= 2020 
ORDER BY track_q;

-- Средняя продолжительность треков по каждому альбому.

SELECT name_albums na, AVG(duration) dur FROM albums a
JOIN tracks t ON t.tracks_id = a.albums_id
GROUP BY a.name_albums
ORDER BY dur DESC;

-- Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT name_artist FROM artists a2  
WHERE name_artist NOT IN (
	SELECT name_artist FROM artists a2
	JOIN artists_albums aa2 ON a2.artist_id = aa2.artist_id
	JOIN albums a ON a.albums_id = aa2.albums_id 
	WHERE a.year_release = 2020);
	
-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).

SELECT DISTINCT name_collection FROM music_collection mc  
JOIN collection_tracks ct ON mc.collection_id = ct.collection_id
JOIN tracks t ON ct.tracks_id = t.tracks_id
JOIN albums a ON t.albums_id = a.albums_id
JOIN artists_albums aa ON a.albums_id = aa.albums_id
JOIN artists a2 ON aa.artist_id = a2.artist_id
WHERE name_artist = 'Кино';

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.

SELECT name_albums FROM albums a
JOIN artists_albums aa ON a.albums_id = aa.albums_id 
JOIN artists a2 ON aa.artist_id = a2.artist_id 
JOIN artists_music_genres amg ON a2.artist_id = amg.artist_id
GROUP BY a.name_albums, a2.artist_id
HAVING COUNT(amg.genre_id) > 1;

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



