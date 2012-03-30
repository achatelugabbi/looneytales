# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env = "development"
  Video.delete_all
  Movie.delete_all
end

swarna_kamalam_video = Video.new(link: 'https://www.youtube.com/v/BsGhE116zLQ', title: 'Swarna Kamalam', language: 2, host: 'youtube', duration: 8571, is_movie: true, genre: 3)
swarna_kamalam_video.keywords = ['swarna kamalam', 'swarnakamalam', 'swarna kamalam movie', 'venkatesh in swarna kamalam', 'bhanu priya', 'k.viswanadh movies', 'classical movies', 'classic movies', 'swarnakamalam songs', 'telugu movie songs', 'teluguone movies', 'free telugu movies', 'free hd movies', 'high definiton movies', 'swarna kamalam video songs']
swarna_kamalam_video.thumbnails = [{:url=> 'http://i.ytimg.com/vi/BsGhE116zLQ/0.jpg', :height=>360, :width=>480}]
swarna_kamalam_video.desc = "Chandra, an artist meets Meena, who is her neighbour. As her father is a dance master Chandra urges Meena to learn dance, but Meena is not interested. He even arranges a dance programme for Meena who behaves mischeviously on the stage."
swarna_kamalam_video.safely.save!


swarna_kamalam_movie = Movie.new(name: 'Swarna Kamalam', video_ids: [swarna_kamalam_video.id], language: 2)
swarna_kamalam_movie.cast = ['Venkatesh', 'Bhanupriya', 'Shanmukha Srinivas', 'Mucherla Aruna', 'Sakshi Ranga Rao', 'Sharon Loven', 'Dubbing Janaki', 'Pavala SyAmala']
swarna_kamalam_movie.desc = "Chandra, an artist meets Meena, who is her neighbour. As her father is a dance master Chandra urges Meena to learn dance, but Meena is not interested. He even arranges a dance programme for Meena who behaves mischeviously on the stage."
swarna_kamalam_movie.safely.save!
