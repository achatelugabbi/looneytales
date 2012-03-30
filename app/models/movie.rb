class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :video_ids, :type => Array, :default => []
  field :name, :type => String
  field :year, :type => String
  field :cast, :type => Array, :default => []
  field :name_slug, :type => String
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

  field :genre, :type => Integer
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

  validates_presence_of :name
  validates_uniqueness_of :name_slug
  before_create :generate_name_slug, :populate_thumbnails

  def title
    return self.name
  end

  def link
    return nil if self.video_ids.blank?
    return Video.find(self.video_ids.first).link
  end

  protected
  def generate_name_slug
    self.name_slug = self.name
    self.name_slug+= self.year if self.year
    self.name_slug = self.name_slug.parameterize
  end

  def populate_thumbnails
    self.video_ids.each do |v|
      video = Video.find(v)
      video.thumbnails.each { |t| self.thumbnails << t}
    end
  end
end
