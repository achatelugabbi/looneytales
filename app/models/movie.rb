class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :video_ids, :type => Array, :default => []
  field :title, :type => String
  field :year, :type => Integer
  field :cast, :type => Array, :default => []
  field :title_slug, :type => String
  field :desc, :type => String
  field :thumbnails, :type => Array, :default => []  #elements of type{:name => '', :url => '', :height => '', :width=> ''.,
  field :link_slug, :type => String
  field :language, :type => Integer # 1) Hindi 2) Telugu 3) Tamil 4)Malayalam 5) Bengali 6) Marathi 7) Punjabi
  field :duration, :type => Float
  field :keywords, :type => Array, :default => []
  field :is_3d, :type => Boolean, :default => false
  field :is_hd, :type => Boolean, :default => false
  field :paid_content, :type => Boolean, :default => false
  field :price, :type => Float
  field :price_currency, :type => String
  field :license, :type => String

  field :genres, :type => Array, :default => []
=begin
  Genres:
    1 – Action & Adventure
    2 – Animation & Cartoons
    3 – Classics
    4 – Comedy
    5 – Crime
    6 – Drama
    7 – Documentary & Biography
    8 – Family
    9 – Foreign
    10 – Horror
    11 – Mystery & Suspense
    12 – Romance
    13 – Science Fiction
    15 – Sports
    18 – Indian Cinema
    19 – Nigerian Cinema
=end

  validates_presence_of :title
  validates_uniqueness_of :title_slug
  before_save :generate_title_slug
  before_save :make_conversions
#, :populate_thumbnails


  def link
    return nil if self.video_ids.blank?
    return Video.find(self.video_ids.first).link
  end

  protected
  def generate_title_slug
    title_slug = self.title
    title_slug+= "#{self.year}" if self.year
    title_slug = title_slug.parameterize
    if year.blank?
      m = Movie.where(:title_slug=> title_slug).first
      if m
        count = 2
        while true
          title_slug = "#{title_slug}#{count}"
          break if not Movie.where(:title_slug => title_slug).first
          count += 1
        end
      end
    end
    self.title_slug = title_slug
  end

  def populate_thumbnails
    thumbnails = []
    self.video_ids.each do |v|
      video = Video.find(v)
      video.thumbnails.each { |t| thumbnails << t} unless video.nil?
    end
    self.thumbnails = thumbnails
  end

  def make_conversions
    begin
      self.year = self.year.to_i unless self.year.blank?
    rescue
      self.year = nil
    end
  end
end
