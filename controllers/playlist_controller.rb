# show form to create the playlist
get '/playlist/new' do
    prev_playlists = get_active_playlists
    # binding.pry
    @name = prev_playlists && prev_playlists.count != 0 ? prev_playlists["name"] : nil
    @id = prev_playlists && prev_playlists.count != 0 ? prev_playlists["id"] : nil

    @songs = all_weekly_songs
    
    erb :"playlists/new_playlist"
end

# show form to create the playlist
post '/playlist/archive' do
    @id = params[:id]
    
    songs_in_playlist = get_active_playlist_songs
    binding.pry
    # archive the song
    songs_in_playlist.each do |track|
        update_song("archived", true, "id", track["id"])
    end
    
    
    update_playlist("archived", true, "id", @id)

    redirect "/playlist/new"
end

# save to db
post '/playlist' do
    name = params[:name]

    create_playlist(name, DateTime.now.strftime("%d/%m/%Y %I:%M"))

    id = find_one_playlist("name", name)["id"]

    redirect "playlist_songs/#{id}"
end

get '/playlist' do
    @songs_data = get_active_playlist_songs
    @no_results = @songs_data.count == 0 ? "CURRENT PLAYLIST EMPTY" : ""
    erb :"playlists/playlist"
end

#  TODO update archive 