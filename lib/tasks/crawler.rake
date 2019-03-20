require 'dotenv/load'
require 'open-uri'
require 'json'

namespace :crawler do
  desc ''
  task :all => :environment do
  end

  desc ''
  task :movie, [:search] => :environment do |t, args|
    if args.search.blank?
      abort 'require search keywords'
    end

    $page = 1
    loop do
      $results = searchItems("movie", { :query => args.search, :page => $page })
      puts $results

      break if ($page >= $results["total_pages"] || $page >= 1000)
      $page += 1
    end
  end

  desc ''
  task :tv, [:search] => :environment do |t, args|
    if args.search.blank?
      abort 'require search keywords'
    end

    $page = 1
    loop do
      $results = searchItems("tv", { :query => args.search, :page => $page })
      puts $results

      break if ($page >= $results["total_pages"] || $page >= 1000)
      $page += 1
    end
  end

  # desc ''
  # task :movies, [:search] => :environment do |t, args|
  #   crawlingMovie(args.search)
  # end

  def crawlingMovie(movie_id)
    puts "crawlingMovie#{movie}"
    getRequestDataFromApi(movie)
  end

  def searchItems(type, options)
    if type == "movie"
      return getRequestDataFromApi(createRequestUrl("/search/movie", options ))
    end
    if type == "tv"
      return getRequestDataFromApi(createRequestUrl("/search/tv", options ))
    end
    
    abort "invalid search type"
  end

  def createRequestUrl(url, args)
    $API_URL = "https://api.themoviedb.org/3"
    $RESULT_URL = $API_URL + url
    args[:api_key] = ENV["TMDBAPI_KEY"]

    if not args.to_query.blank?
      $RESULT_URL += ('?' + args.to_query)
    end
    
    return $RESULT_URL
  end

  def getRequestDataFromApi(url)
    json = open(url).read
    return JSON.parse(json)
  end
end
