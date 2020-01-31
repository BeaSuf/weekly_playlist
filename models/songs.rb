def create_song(title, artist, album, preview, link, user_id, cover, archived = false)
  sql = <<~SQL      
      INSERT INTO songs (title, artist, album, preview, link, user_id, cover, archived)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8);
  SQL

  run_sql(sql, [title, artist, album, preview, link, user_id, cover, archived])
end

# read
def all_songs
  sql = "SELECT * FROM songs;"
  # implicit return
  run_sql(sql)
end

def all_weekly_songs
  sql = "SELECT * FROM songs WHERE archived = false;"
  # implicit return
  run_sql(sql)
end

def find_user_songs(user_id)
  sql = "SELECT * FROM songs WHERE user_id = $1;"
  run_sql(sql, [user_id])
end

def find_song_by_title_and_artist(title, artist_name)
  sql = "SELECT * FROM songs WHERE title ILIKE $1 AND artist ILIKE $2 AND archived = false;"
  run_sql(sql, [title, artist_name]).first
end

# update
def update_song(update_column, update_value, cond_column, cond_value)
  sql = "UPDATE songs SET #{update_column} = $1 WHERE #{cond_column} = $2;"
  run_sql(sql, [update_value, cond_value])
end

# delete
def delete_song(column, value)
  sql = "DELETE FROM songs WHERE #{column} = $1;"
  run_sql(sql, [value])
end