require 'httparty'

# find matched songs
get '/songs' do
    title = params[:title]
    # binding.pry

    headers = {
        'x-rapidapi-host': 'deezerdevs-deezer.p.rapidapi.com',
        'x-rapidapi-key': '8c542d09c5msh4176cc948383ec9p1eef53jsn8825cd8975d8'
    }

    url = "https://deezerdevs-deezer.p.rapidapi.com/search?q=#{title}"
    
    deezer_json = HTTParty.get(url, {
        headers: headers, 
        debug_output: STDOUT, # To show that User-Agent is Httparty
    })

    search_data = deezer_json["data"]
    
    if(search_data.size > 0)
        @songs_data = []
        search_data.each do |track|
            @songs_data << { 
                search_term: title,
                title: track['title'],
                artist_name: track['artist']["name"],
                album_title: track['album']['title'],
                cover: track['album']['cover_medium'],            
                preview: track['preview'],
                link: track['link']
            }
        end
        
        # raise @song_data.inspect

        redirect "/song/#{@song_data}" unless search_data.size > 1    
        
        erb :"songs/songs_list"
    else
        @error = "No results"
        erb :index
    end
end

# find specific song
get '/song_details' do
    @song_data = {
        search_term: params['search_term'],
        title: params['title'],
        artist_name: params['artist_name'],
        album_title: params['album_title'],
        cover: params['cover'],            
        preview: params['preview'],
        link: params['link'] 
    }

    @in_list = find_song_by_title_and_artist(@song_data[:title], @song_data[:artist_name])
    # binding.pry
    erb :"songs/song_details"
end

# create
post '/song' do
    redirect '/login' unless logged_in?
  
    title = params['title']
    artist_name = params['artist_name']
    album_title = params['album_title']
    cover = params['cover'] 
    preview = params['preview']
    link = params['link'] 

    create_song(title, artist_name, album_title, preview, link, current_user["id"], cover)
    #currently not interested in the results because it's insert
    
    redirect '/'
end

# delete
delete '/songs/:id' do
    redirect '/login' unless logged_in?
  
    id = params[:id]

    delete_song("id", id)
  
    redirect '/'
end

# edit specific
get '/songs/:id/edit' do
    redirect '/login' unless logged_in?
  
    id = params[:id]
  
    # @song =  find_one_song("id", id)

    erb :edit_song
end

# update
patch '/songs/:id' do
    redirect '/login' unless logged_in?
    
    id = params[:id]
    name = params[:name]
    img_url = params[:image_url]
     
    update_song(name, image_url, id)
  
    redirect "/songs/#{id}"
end

get '/my_songs' do
    redirect '/login' unless logged_in?
  
    sql = "SELECT * from songs WHERE user_is = $1;"
  
    @songs = run_sql(sql, [current_user[:id]])
    # raise @songs.to_a.inspect
    erb :my_songs
end