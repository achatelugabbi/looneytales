class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :link, :type => String
  field :title, :type => String
  field :title_slug, :type => String
  field :desc, :type => String
  field :thumbnails, :type => Array, :default => []  #elements of type{:name => '', :url => '', :height => '', :width=> ''.,
  field :link_slug, :type => String
  field :language, :type => Integer # 1) Hindi 2) Telugu 3) Tamil 4)Malayalam 5) Bengali 6) Marathi 7) Punjabi
  field :host, :type => String
  field :host_videoid, :type => String
  field :host_lang_str, :type => String
  field :host_viewCount, :type => Integer
  field :host_rating, :type => Float
  field :host_likes, :type => Integer
  field :host_dislikes, :type => Integer
  field :host_published, :type => DateTime
  field :host_commentCount, :type => Integer
  field :host_rater_count, :type => Integer
  field :host_author, :type => String
  field :host_author_uri, :type => String
  field :duration, :type => Float
  field :keywords, :type => Array, :default => []
  field :is_3d, :type => Boolean, :default => false
  field :is_hd, :type => Boolean, :default => false
  field :paid_content, :type => Boolean, :default => false
  field :price, :type => Float
  field :price_currency, :type => String
  field :license, :type => String

  field :media_rating, :type => String
  field :genre, :type => Integer

  field :is_movie, :type => Boolean, :default => false
  field :is_movie_part, :type => Boolean, :default => false


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

  validates_uniqueness_of :link, :link_slug
  before_create :generate_slugs

  protected
  def generate_slugs
    self.link_slug = self.link.parameterize
    self.title_slug = self.title.parameterize
  end
end
