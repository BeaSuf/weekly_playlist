def create_song(title, artist, album, preview, link, user_id)
    sql = <<~SQL      
        INSERT INTO songs (title, artist, album, preview, link, user_id)
        VALUES ($1, $2, $3, $4, $5, $6);
    SQL

    run_sql(sql, [title, artist, album, preview, link, user_id])
end

# read
def all_songs
    sql = "SELECT * FROM songs;"
    # implicit return
    run_sql(sql)
end

def find_one_song(column, value)
    sql = "SELECT * FROM songs WHERE #{column} = $1;"
    run_sql(sql, [value]).first
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