def create_playlist(name, create_date)
    # DateTime.now.strftime("%d/%m/%Y %I:%M")
    sql = <<~SQL      
        INSERT INTO playlists (name, create_date)
        VALUES ($1, $2);
    SQL

    run_sql(sql, [name, create_date])
end

# read
def all_playlists
    sql = "SELECT * FROM playlists;"
    # implicit return
    run_sql(sql)
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