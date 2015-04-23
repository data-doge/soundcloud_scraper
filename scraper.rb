require 'soundcloud'
require 'pp'

CLIENT = SoundCloud.new(:client_id => "24c2bcc4621aecf148e95e8a43c3cc1f")

TRACK_IDS = []

def get_tracks(user_permalink, depth)
  if depth > 0
    p depth
    first_liked_track = CLIENT.get("/users/#{user_permalink}/favorites").first
    first_liked_track_id = first_liked_track.id
    TRACK_IDS << first_liked_track_id
    first_favoriter_permalink = CLIENT.get("/tracks/#{first_liked_track_id}/favoriters").first.permalink
    depth -= 1
    get_tracks(first_favoriter_permalink, depth)
  end
end

get_tracks("nu-yi", 20)

puts TRACK_IDS