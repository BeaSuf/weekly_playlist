# create
require 'bcrypt'

def create_user(email, password, admin = false)
    password_digest = BCrypt::Password.create(password)

    sql = <<~SQL
        INSERT INTO users (email, password_digest, admin)
        VALUES ($1, $2, $3);
    SQL

    run_sql(sql, [email, password_digest, admin])
end

# read
def all_users
    sql = "SELECT * FROM users;"
    # implicit return
    run_sql(sql)
end

def find_one_user(column, value)
    sql = "SELECT * FROM users WHERE #{column} = $1;"
    run_sql(sql, [value]).first
  end

# update
def update_user(update_column, update_value, cond_column, cond_value)
    sql = "UPDATE users SET #{update_column} = $1 WHERE #{cond_column} = $2;"
    run_sql(sql, [update_value, cond_value])
end

# delete
def delete_user(column, value)
    sql = "DELETE FROM users WHERE #{column} = $1;"
    run_sql(sql, [value])
end