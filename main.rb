require 'sinatra'

if development?
  require 'sinatra/reloader'
  require 'pry'

  also_reload 'db/shared'
  also_reload 'models/users'
  also_reload 'models/songs'
  also_reload 'models/votes'
  also_reload 'models/playlists'
  also_reload 'models/playlists_songs'
  also_reload 'controllers/session_controller'
  also_reload 'controllers/user_controller'
  also_reload 'controllers/song_controller'
  also_reload 'controllers/vote_controller'
  also_reload 'controllers/playlist_controller'
  also_reload 'controllers/playlist_song_controller'
end

require_relative 'db/shared'
require_relative 'models/users'
require_relative 'models/songs'
require_relative 'models/votes'
require_relative 'models/playlists'
require_relative 'models/playlists_songs'

# search songs form
get '/' do
  erb :index
end

require_relative 'controllers/session_controller'
require_relative 'controllers/user_controller'
require_relative 'controllers/song_controller'
require_relative 'controllers/vote_controller'
require_relative 'controllers/playlist_controller'
require_relative 'controllers/playlist_song_controller'















