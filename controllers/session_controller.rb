enable :sessions # sinatra feature - abstruction - it's 'global' variable that you can write to

def logged_in?
    if session[:user_id]
      return true
    else
      return false
    end  
end
  
def current_user     
    find_one_user('id', session[:user_id])     
end

# show login form
get '/login' do
    erb :"users/login"
end

# parse login form
post '/login' do
    # check if the record exists for the email the user sent in
    email = params[:email]
    password = params[:password]

    results = find_one_user('email', email)
    
    if(results == nil)
        @error = 'Invalid email'
        erb :"users/login"
    else
        digested_password = BCrypt::Password.new(results['password_digest'])
        
        # check record exist && password digested match 
        if results && digested_password == password
            # store the user_id in the session
            session[:user_id] = results['id']
            redirect '/'
        else
            # add error message "Email or Password are incorrect"
            @error = 'Invalid email/password'
            erb :"users/login"
        end
    end
end

get '/sign_up' do
    erb :"users/sign_up"
end

post '/sign_up' do
    email = params[:email]
    password = params[:password]
    repeat_password = params[:repeat_password]

    results = find_one_user('email', email)
        
    if(password != repeat_password)
        @error = "Passwords doesn't match"
        erb :"users/sign_up"
    elsif results 
        @error = 'There is a user with this email'
        erb :"users/login"
    else
        create_user(email, password, admin = false)
        erb :"users/login"
    end
end

# show forgot password 
get '/forgot_password' do
    erb :"users/forgot_password"
end

# forgot password form parse
post '/forgot_password' do
    @email = params[:email]

    results = find_one_user('email', @email)
    
    if(results == nil)
        @error = "User with this email doesn't exist"
        erb :"users/forgot_password"
    else
        erb :"users/reset_password"
    end
end

# reset password form parse
post '/reset_password/:email' do
    email = params[:email]
    password = params[:password]
    repeat_password = params[:repeat_password]

    if(password != repeat_password)
        @error = "Passwords doesn't match"
        # TODO ask
        @email = email
        erb :"users/reset_password"
    else
        update_user('password_digest', password, 'email', email)
        redirect '/'
    end
end

# logout
delete '/session' do
    session[:user_id] = nil

    redirect '/login'
end

