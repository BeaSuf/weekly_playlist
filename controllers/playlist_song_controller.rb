# show the votes count 
get '/playlist_songs/:id' do
    @playlist_id = params[:id]
 
    @name = find_one_playlist("id", @playlist_id)["name"]

    # count query
    @songs_data = get_song_votes_count
    @no_results = @songs_data.count == 0 ? "NO SONGS SELECTED AND VOTED" : ""
    
    erb :"playlists_songs/playlist_songs"
end

# save to db
post '/playlist_songs' do
    params.each do |param|
        # binding.prys
        # create_playlist_song(playlist_ids, song_ids)
        create_playlist_song(param[1], param[0])
    end
        
    redirect '/'
end


