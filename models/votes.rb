def create_vote(user_id, song_id)
  sql = <<~SQL      
      INSERT INTO votes (user_id, song_id)
      VALUES ($1, $2);
  SQL

  run_sql(sql, [user_id, song_id])
end

# read
def all_votes
  sql = "SELECT * FROM votes;"
  # implicit return
  run_sql(sql)
end

def get_song_votes_count(song_id)
  sql = "SELECT count(#{song_id}) FROM votes;"
  # implicit return
  run_sql(sql)
end

def find_one_vote(user_id, song_id)
  sql = "SELECT * FROM votes WHERE user_id = $1 AND song_id = $2;"
  run_sql(sql, [user_id, song_id]).first
end

def find_voted_songs(user_id)
  sql = "SELECT * FROM votes WHERE user_id = $1;"
  run_sql(sql, [user_id])
end

# update
def update_vote(update_column, update_value, cond_column, cond_value)
  sql = "UPDATE votes SET #{update_column} = $1 WHERE #{cond_column} = $2;"
  run_sql(sql, [update_value, cond_value])
end

# delete
def delete_vote_for_song(user_id, song_id)
  sql = "DELETE FROM votes WHERE user_id = $1 AND song_id = $2;"
  run_sql(sql, [user_id, song_id])
end