require 'pg'

def run_sql(sql, args = [])
    conn = PG.connect(dbname: 'weekly_playlists')
    results = conn.exec_params(sql, args)
    conn.close

    results
end

# def create(table, col_val)
#     sql = "INSERT INTO #{} "
#     col_val.each do |key, value|

# end