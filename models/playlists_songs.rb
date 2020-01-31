def create_playlist_song(playlist_id, song_id)
  sql = <<~SQL      
    INSERT INTO playlists_songs (playlist_id, song_id)
    VALUES ($1, $2);
  SQL

  run_sql(sql, [playlist_id, song_id])
end

# INSERT INTO public."Item" ("Id", name)
# VALUES  ('1', 'name1'),
#         ('2', 'name2'),
#         ('3','name3')

# read
def all_playlists_songs
  sql = "SELECT * FROM playlists_songs;"
  # implicit return
  run_sql(sql)
end

def get_active_playlist_songs 
  sql = <<~SQL  
    SELECT id, title, artist, album, preview, link, cover, archived, songs.user_id AS user_song
    FROM songs, playlists_songs WHERE id = song_id AND archived = false;
  SQL
  run_sql(sql)
end

def find_one_playlist_song(playlist_id, song_id)
  sql = "SELECT * FROM playlists_songs WHERE playlist_id = $1 AND song_id = $2;"
  run_sql(sql, [playlist_id, song_id]).first
end

def find_playlist_songs(playlist_id)
  sql = "SELECT * FROM votes WHERE playlist_id = $1;"
  run_sql(sql, [playlist_id])
end

# update
def update_playlist_song(update_column, update_value, cond_column, cond_value)
  sql = "UPDATE playlists_songs SET #{update_column} = $1 WHERE #{cond_column} = $2;"
  run_sql(sql, [update_value, cond_value])
end

# delete
def delete_playlist_song(column, value)
  sql = "DELETE FROM playlists_songs WHERE #{column} = $1;"
  run_sql(sql, [value])
end