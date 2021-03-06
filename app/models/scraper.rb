class Scraper < ActiveRecord::Base

  def self.get_tracks(user_permalink, depth, track_ids)
    if depth > 0
      puts "#{depth} more to go!!!!"
      first_liked_track = CLIENT.get("/users/#{user_permalink}/favorites").sample
      first_liked_track_id = first_liked_track.id
      track_ids << first_liked_track_id
      random_favoriter_permalink = CLIENT.get("/tracks/#{first_liked_track_id}/favoriters").sample.permalink
      depth -= 1
      self.get_tracks(random_favoriter_permalink, depth, track_ids)
    end
  end

  def self.scrape(user_permalink, depth)
    track_ids = []
    self.get_tracks(user_permalink, depth, track_ids)
    puts "DONE"
    return track_ids
  end

end