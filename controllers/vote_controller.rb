def voted_songs
    # get the voted songs of the current user
    voted_songs = find_voted_songs(current_user["id"])
    voted_songs.map{ |record| record["song_id"] }
end

get '/votes' do
    redirect '/login' unless logged_in?

    # all_songs (not archived)
    @songs_data = all_weekly_songs()
    @no_results = @songs_data.count == 0 ? "NO SONGS SELECTED" : ""


    #get user's songs, user should not be able to vote for them
    owned_songs = find_user_songs(current_user["id"])
    @owned_songs_ids = owned_songs.map{ |record| record["id"] }
  
    @voted_songs_ids = voted_songs
   
    erb :"votes/votes_list"
end

get '/vote/:id' do
    redirect '/login' unless logged_in?
    
    song_id = params[:id]   
    
    create_vote(current_user["id"], song_id)
    redirect "/votes"
end

get '/un_vote/:id' do
    redirect '/login' unless logged_in?
    
    song_id = params[:id]
    
    delete_vote_for_song(current_user["id"], song_id)
    redirect "/votes"
end