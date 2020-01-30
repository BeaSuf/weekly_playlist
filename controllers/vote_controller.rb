get '/votes' do
    redirect '/login' unless logged_in?

    # all_songs (not archived)
    @songs_data = all_weekly_songs()

    # get the voted songs of the current user

    voted = find_voted_songs(current_user["id"])
    @voted_songs_ids = voted.map{ |record| record["song_id"] }
   
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