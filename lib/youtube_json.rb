require 'date'

class YoutubeJson
#skipped yt$accessControl, yt$availability, gd$comments, yt$hd 

  def self.datetime_parser(str)
    begin
      t= Time.parse(str)
      dt = DateTime.parse(t.to_s)
      return dt
    rescue => e
      puts "in datetimeparser: #{e}"
      return nil
    end
  end


  def self.title(data)
    begin
      return data["entry"]["title"]["$t"]
    rescue => e
      puts "in title: #{e}"
      return nil
    end
  end

  def self.author_name(data)
    begin
      return data["entry"]["author"].first["name"]["$t"]
    rescue => e
      puts "in author_name: #{e}"
      return nil
    end
  end

  def self.author_uri(data)
    begin
      return data["entry"]["author"].first["uri"]["$t"]
    rescue => e
      puts "author_uri: #{e}"
      return nil
    end
  end

  def self.author_yt_userId(data)
    begin
      return data["entry"]["author"].first["yt$userId"]["$t"]
    rescue => e
      puts "in author_yt_userId: #{e}"
      return nil
    end
  end

  def self.first_released(data)
    begin
      d = data["entry"]["yt$firstReleased"]["$t"]
      dt = nil
      dt = self.datetime_parser(d) unless d.blank?
      return dt
    rescue => e
     # puts "in first_released #{e}"
      return nil
    end
  end

  def self.genres(data)
    begin
      genres = []
      data["entry"]["media$group"]["media$category"].each do |cat|
        unless cat["scheme"].index('moviegenres.cat').blank?
          genres << cat["$t"] unless cat["$t"].blank?
        end
      end
      return genres
    rescue => e
      puts "in genres: #{e}"
      puts "data: #{data}"
      return nil
    end
  end

  def self.credits(data)
    begin
      credits = []
      data["entry"]["media$group"]["media$credit"].each do |credit|
        name = credit["$t"] unless credit["$t"].blank?
        role = nil
        role = credit["role"] unless credit["role"].blank?
        credits << {"name" => name, "role" => role} unless name.blank?
      end
      return credits
    rescue => e
      puts "in credits: #{e}"
      return nil
    end
  end

  def self.description(data)
    begin
      return data["entry"]["media$group"]["media$description"]["$t"]
    rescue => e
      puts "in description: #{e}"
      return nil
    end
  end

  def self.keywords(data)
    begin
      return data["entry"]["media$group"]["media$keywords"]["$t"]
    rescue => e
      puts "in keywords: #{e}"
      return nil
    end
  end

  def self.thumbnails(data)
    begin
      return data["entry"]["media$group"]["media$thumbnail"]
    rescue => e
      puts "in thumbnails: #{e}"
      return nil
    end
  end

  def self.aspect_ratio(data)
    begin
      return data["entry"]["media$group"]["yt$aspectRatio"]
    rescue => e
      puts "in aspect_ratio: #{e}"
      return nil
    end
  end

  def self.duration(data)
    begin
      return data["entry"]["media$group"]["yt$duration"]["seconds"].to_i
    rescue => e
      puts "in duration: #{e}"
      return nil
    end
  end

  def self.video_id(data)
    begin
      return data["entry"]["media$group"]["yt$videoid"]["$t"]
    rescue => e
      puts "in video_id: #{e}"
      return nil
    end
  end

  def self.avg_rating(data)
    begin
      return data["entry"]["gd$rating"]["average"].to_f
    rescue => e
      puts "in avg_rating: #{e}"
      return nil
    end
  end

  def self.max_rating(data)
    begin
      return data["entry"]["gd$rating"]["max"].to_f
    rescue => e
      puts "in max_rating: #{e}"
      return nil
    end
  end

  def self.min_rating(data)
    begin
      return data["entry"]["gd$rating"]["min"].to_f
    rescue => e
      puts "in min_rating: #{e}"
      return nil
    end
  end


  def self.ratings_count(data)
    begin
      return data["entry"]["gd$rating"]["numRaters"].to_i
    rescue => e
      puts "in ratings_count: #{e}"
      return nil
    end
  end


  def self.favorite_count(data)
    begin
      return data["entry"]["yt$statistics"]["favoriteCount"].to_i
    rescue => e
      puts "in favorite_count: #{e}"
      return nil
    end
  end

  def self.view_count(data)
    begin
      return data["entry"]["yt$statistics"]["viewCount"].to_i
    rescue => e
      puts "in view_count: #{e}"
      return nil
    end
  end

   def self.likes_count(data)
    begin
      return data["entry"]["yt$rating"]["numLikes"].to_i
    rescue => e
      puts "in likes_count: #{e}"
      return nil
    end
  end

 
  def self.dislikes_count(data)
    begin
      return data["entry"]["yt$rating"]["numDislikes"].to_i
    rescue => e
      puts "in dislikes_count: #{e}"
      return nil
    end
  end

  def self.published(data)
    begin
      d = data["entry"]["published"]["$t"]
      dt = nil
      dt = self.datetime_parser(d) unless d.blank?
      return dt
    rescue => e
      puts "in published: #{e}"
      return nil
    end
  end

  def self.updated(data)
    begin
      d = data["entry"]["updated"]["$t"]
      dt = nil
      dt = self.datetime_parser(d) unless d.blank?
      return dt
    rescue => e
      puts "in updated: #{e}"
      return nil
    end
  end


  def self.is_3d(data)
    #needs to be updated
    return false
  end

  def self.is_hd(data)
    #needs to be updated
    return false
  end

  def self.is_paid_content(data)
    #needs to be updated
    return false
  end

  def self.price(data)
    #needs to be updated
    return nil
  end

  def self.price_currency(data)
    #needs to be updated
    return nil
  end

  def self.license(data)
    #needs to be updated
    return nil
  end

  def self.video_json(video, lang)
     thumbnails = YoutubeJson.thumbnails(video)
     thumbnails = [] if thumbnails.nil?
     keywords = YoutubeJson.keywords(video)
     keywords = [] if keywords.nil?
     credits = YoutubeJson.credits(video)
     credits = [] if credits.nil?
     genres = YoutubeJson.genres(video)
     genres = [] if genres.nil?
     orig_date = YoutubeJson.first_released(video)
     year = nil
     year = orig_date.strftime("%Y") unless orig_date.nil?
     video_id = YoutubeJson.video_id(video)
     link = nil
     link = "http://www.youtube.com/v/#{video_id}" unless video_id.blank?
     return {
      :title => YoutubeJson.title(video),
      :desc => YoutubeJson.description(video),
      :thumbnails => thumbnails,
      :language => lang,
      :year => year,
      :orig_rel_date => orig_date.to_s,
      :host => "youtube",
      :link => link,
      :host_video_id => video_id,
      :host_credits => credits,
      :host_aspect_ratio => YoutubeJson.aspect_ratio(video),
      :host_view_count => YoutubeJson.view_count(video),
      :host_rating => YoutubeJson.avg_rating(video),
      :host_likes => YoutubeJson.likes_count(video),
      :host_dislikes => YoutubeJson.dislikes_count(video),
      :host_published => YoutubeJson.published(video).to_s,
      :host_updated => YoutubeJson.updated(video).to_s,
      :host_ratings_count => YoutubeJson.ratings_count(video),
      :host_favorites_count => YoutubeJson.favorite_count(video),
      :host_author_name => YoutubeJson.author_name(video),
      :host_author_uri => YoutubeJson.author_uri(video),
      :host_author_id => YoutubeJson.author_yt_userId(video),
      :duration => YoutubeJson.duration(video),
      :keywords => keywords,
      :is_3d => YoutubeJson.is_3d(video),
      :is_hd => YoutubeJson.is_hd(video),
      :paid_content => YoutubeJson.is_paid_content(video),
      :price => YoutubeJson.price(video),
      :price_currency => YoutubeJson.price_currency(video),
      :license => YoutubeJson.license(video),
      :genres => genres,
      :is_movie => true
    }
  end
end
