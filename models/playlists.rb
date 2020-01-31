def create_playlist(name, create_date, archived = false)
  # DateTime.now.strftime("%d/%m/%Y %I:%M")
  sql = <<~SQL      
      INSERT INTO playlists (name, create_date, archived)
      VALUES ($1, $2, $3);
  SQL

  run_sql(sql, [name, create_date, archived])
end

# read
def all_playlists
  sql = "SELECT * FROM playlists;"
  # implicit return
  run_sql(sql)
end

def get_active_playlists
  sql = "SELECT * FROM playlists WHERE archived = false;"
  # implicit return
  run_sql(sql).first
end

def find_one_playlist(column, value)
  sql = "SELECT * FROM playlists WHERE #{column} = $1;"
  run_sql(sql, [value]).first
end

# update
def update_playlist(update_column, update_value, cond_column, cond_value)
  sql = "UPDATE playlists SET #{update_column} = $1 WHERE #{cond_column} = $2;"
  run_sql(sql, [update_value, cond_value])
end

# delete
def delete_playlist(column, value)
  sql = "DELETE FROM playlists WHERE #{column} = $1;"
  run_sql(sql, [value])
end