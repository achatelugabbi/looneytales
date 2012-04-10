# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 

#require 'yaml'
require 'json'

if Rails.env == "development"
  Video.delete_all
  Movie.delete_all
end
puts "loading videos json file"
#@videos = YAML::load(File.open("#{Rails.root}/samples/videos.yml"))
videos_json_file = File.read "#{Rails.root}/samples/videos.json"
videos_json = JSON.parse(videos_json_file)

videos_json.each do |v| 
  begin
    Video.safely.create!(v)
    puts "created video #{v["title"]}"
  rescue => e
    puts "Error Creating Video: #{v['title']}"
    puts e
  end
end

puts "loading videos json file"
#@movies = YAML::load(File.open("#{Rails.root}/samples/videos.yml"))
movies_json_file = File.read "#{Rails.root}/samples/movies.json"
movies_json = JSON.parse(movies_json_file)


movies_json.each do |m| 
  begin
    Movie.safely.create!(m)
    puts "created movie #{m["title"]}"
  rescue => e
    puts "Error Creating Movie: #{m['title']}"
    puts e
  end
end

=begin
swarna_kamalam_video = Video.new(link: 'https://www.youtube.com/v/BsGhE116zLQ', title: 'Swarna Kamalam', language: 2, host: 'youtube', duration: 8571, is_movie: true, genre: 3)
swarna_kamalam_video.keywords = ['swarna kamalam', 'swarnakamalam', 'swarna kamalam movie', 'venkatesh in swarna kamalam', 'bhanu priya', 'k.viswanadh movies', 'classical movies', 'classic movies', 'swarnakamalam songs', 'telugu movie songs', 'teluguone movies', 'free telugu movies', 'free hd movies', 'high definiton movies', 'swarna kamalam video songs']
swarna_kamalam_video.thumbnails = [{:url=> 'http://i.ytimg.com/vi/BsGhE116zLQ/0.jpg', :height=>360, :width=>480}]
swarna_kamalam_video.desc = "Chandra, an artist meets Meena, who is her neighbour. As her father is a dance master Chandra urges Meena to learn dance, but Meena is not interested. He even arranges a dance programme for Meena who behaves mischeviously on the stage."
swarna_kamalam_video.safely.save!


swarna_kamalam_movie = Movie.new(name: 'Swarna Kamalam', video_ids: [swarna_kamalam_video.id], language: 2)
swarna_kamalam_movie.cast = ['Venkatesh', 'Bhanupriya', 'Shanmukha Srinivas', 'Mucherla Aruna', 'Sakshi Ranga Rao', 'Sharon Loven', 'Dubbing Janaki', 'Pavala SyAmala']
swarna_kamalam_movie.desc = "Chandra, an artist meets Meena, who is her neighbour. As her father is a dance master Chandra urges Meena to learn dance, but Meena is not interested. He even arranges a dance programme for Meena who behaves mischeviously on the stage."
swarna_kamalam_movie.safely.save!
=end
