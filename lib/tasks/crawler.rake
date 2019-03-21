require 'dotenv/load'
require 'net/http'
require 'json'

namespace :crawler do
  $allowSearchTypes = ["movie", "tv"]
  $allowGenreTypes = ["movie", "tv"]
  API_URL = "https://api.themoviedb.org/3"

  ################################################################
  #                         Task Methods                         #
  ################################################################

  desc 'Search all items'
  task :search, [:keyword] => :environment do |t, args|
    search("movie", args.keyword)
    search("tv", args.keyword)
  end

  desc 'Search movies'
  task :movie, [:search] => :environment do |t, args|
    search("movie", args.search)
  end

  desc 'Search tvs'
  task :tv, [:search] => :environment do |t, args|
    search("tv", args.search)
  end

  ################################################################
  #                       Crwaling Methods                       #
  ################################################################

  def crwalingMovies(movie_lists, now, total)
    t = total > 1000 ? 1000 : total
    for movie in movie_lists
      puts "movie crawling: #{now} / #{t}"
      crawlingMovie(movie["id"])
      now += 1
    end
  end

  def crawlingMovie(movie_id)
    movie = updateMovie(movie_id)

    if not movie["genres"].blank?
      # Update genre
      for genre in movie["genres"]
        updateGenre("movie", genre["id"], genre["name"])
      end
      # Update Relationship
      for genre in movie["genres"]
        addRelationMovieGenre(movie_id, genre["id"])
      end
    end
    
    if not movie["production_companies"].blank?
      # Update company
      for company in movie["production_companies"]
        updateCompany(company["id"])
      end
      # Update Relationship
      for company in movie["production_companies"]
        addRelationMovieCompany(movie_id, company["id"])
      end
    end
    
    if not movie["production_countries"].blank?
      # Update country
      for country in movie["production_countries"]
        updateCountry(country["iso_3166_1"])
      end
      # Update Relationship
      for country in movie["production_countries"]
        addRelationMovieCountry(movie_id, country["iso_3166_1"])
      end
    end
    
    if not movie["spoken_languages"].blank?
      # Update country
      for language in movie["spoken_languages"]
        updateLanguage(language["iso_639_1"])
      end
      # Update Relationship
      for language in movie["spoken_languages"]
        addRelationMovieLanguage(movie_id, language["iso_639_1"])
      end
    end

    people = getMoviePeople(movie_id)
    if not people["cast"].blank?
      # Update person
      for cast in people["cast"]
        updatePerson(cast["id"])
      end
      # Update Relationship
      for cast in people["cast"]
        addRelationMovieCast(movie_id, cast["id"], cast["character"])
      end
    end
    
    if not people["crew"].blank?
      # Update person
      for crew in people["crew"]
        updatePerson(crew["id"])
      end
      # Update Relationship
      for crew in people["crew"]
        addRelationMovieCrew(movie_id, crew["id"])
      end
    end
  end

  def crwalingTvs(tv_list, now, total)
    t = total > 1000 ? 1000 : total
    for tv in tv_list
      puts "tv crawling: #{now} / #{t}"
      crwalingTv(tv["id"])
      now += 1
    end
  end

  def crwalingTv(tv_id)
    tv = updateTv(tv_id)

    if not tv["created_by"].blank?
      # Update company
      for person in tv["created_by"]
        updatePerson(person["id"])
      end
      # Update Relationship
      for person in tv["created_by"]
        addRelationTvCrew(tv_id, person["id"])
      end
    end

    if not tv["episode_run_time"].blank?
      # Update company
      for run_time in tv["episode_run_time"]
        updateTvRuntime(tv_id, run_time)
      end
    end

    if not tv["genres"].blank?
      # Update genre
      for genre in tv["genres"]
        updateGenre("tv", genre["id"], genre["name"])
      end
      # Update Relationship
      for genre in tv["genres"]
        addRelationTvGenre(tv_id, genre["id"])
      end
    end

    if not tv["networks"].blank?
      # Update genre
      for network in tv["networks"]
        updateNetwork(network["id"])
      end
      # Update Relationship
      for network in tv["networks"]
        addRelationTvNetwork(tv_id, network["id"])
      end
    end

    if not tv["production_companies"].blank?
      # Update company
      for company in tv["production_companies"]
        updateCompany(company["id"])
      end
      # Update Relationship
      for company in tv["production_companies"]
        addRelationTvCompany(tv_id, company["id"])
      end
    end

    if not tv["seasons"].blank?
      # Update season
      for season in tv["seasons"]
        crawlingSeason(tv_id, season["season_number"])
      end
    end

    people = getTvPeople(tv_id)
    if not people["cast"].blank?
      # Update person
      for cast in people["cast"]
        updatePerson(cast["id"])
      end
      # Update Relationship
      for cast in people["cast"]
        addRelationTvCast(tv_id, cast["id"], cast["character"])
      end
    end
    
    if not people["crew"].blank?
      # Update person
      for crew in people["crew"]
        updatePerson(crew["id"])
      end
      # Update Relationship
      for crew in people["crew"]
        addRelationTvCrew(tv_id, crew["id"])
      end
    end
  end

  def crawlingSeason(tv_id, season_id)
    season = updateSeason(tv_id, season_id)
    id = season["id"].blank? ? season.id : season["id"]

    if not season["episodes"].blank?
      # Update episode
      for episode in season["episodes"]
        crawlingEpisode(tv_id, season_id, episode["episode_number"])
      end
    end
    
    people = getSeasonPeople(tv_id, season_id)
    if not people["cast"].blank?
      # Update person
      for cast in people["cast"]
        updatePerson(cast["id"])
      end
      # Update Relationship
      for cast in people["cast"]
        addRelationSeasonCast(id, cast["id"], cast["character"])
      end
    end
    
    if not people["crew"].blank?
      # Update person
      for crew in people["crew"]
        updatePerson(crew["id"])
      end
      # Update Relationship
      for crew in people["crew"]
        addRelationSeasonCrew(id, crew["id"])
      end
    end
  end

  def crawlingEpisode(tv_id, season_id, episode_id)
    episode = updateEpisode(tv_id, season_id, episode_id)
    id = episode["id"].blank? ? episode.id : episode["id"]
    
    people = getEpisodePeople(tv_id, season_id, episode_id)
    if not people["cast"].blank?
      # Update person
      for cast in people["cast"]
        updatePerson(cast["id"])
      end
      # Update Relationship
      for cast in people["cast"]
        addRelationEpisodeCast(id, cast["id"], cast["character"])
      end
    end
    
    if not people["crew"].blank?
      # Update person
      for crew in people["crew"]
        updatePerson(crew["id"])
      end
      # Update Relationship
      for crew in people["crew"]
        addRelationEpisodeCrew(id, crew["id"])
      end
    end
    
    if not people["guest_stars"].blank?
      # Update person
      for guest in people["guest_stars"]
        updatePerson(guest["id"])
      end
      # Update Relationship
      for guest in people["guest_stars"]
        addRelationEpisodeGuest(id, guest["id"], guest["character"])
      end
    end
  end

  ################################################################
  #                 Database Relationship Methods                #
  ################################################################

  def addRelationMovieGenre(movie, genre)
    r = MovieGenre.where("movie_id = :movie and genre_id = :genre", { movie: movie, genre: genre }).take
    if r.blank?
      MovieGenre.new(:movie_id => movie, :genre_id => genre).save()
    end
    # todo: update?
  end

  def addRelationMovieCompany(movie, company)
    r = MovieCompany.where("movie_id = :movie and company_id = :company", { movie: movie, company: company }).take
    if r.blank?
      MovieCompany.new(:movie_id => movie, :company_id => company).save()
    end
    # todo: update?
  end

  def addRelationMovieCountry(movie, country)
    c = Country.where(:name => country).take
    if c.blank?
      abort "Database not found error Country"
    end

    r = MovieCountry.where("movie_id = :movie and country_id = :country", { movie: movie, country: c["id"] }).take
    if r.blank?
      MovieCountry.new(:movie_id => movie, :country_id => c["id"]).save()
    end
    # todo: update?
  end

  def addRelationMovieCast(movie, cast, character)
    r = MovieCast.where("movie_id = :movie and person_id = :cast", { movie: movie, cast: cast }).take
    if r.blank?
      MovieCast.new(:movie_id => movie, :person_id => cast, :character => character).save()
    end
    # todo: update?
  end

  def addRelationMovieCrew(movie, crew)
    r = MovieCrew.where("movie_id = :movie and person_id = :crew", { movie: movie, crew: crew }).take
    if r.blank?
      MovieCrew.new(:movie_id => movie, :person_id => crew).save()
    end
    # todo: update?
  end

  def addRelationMovieLanguage(movie, language)
    l = Language.where(:name => language).take
    if l.blank?
      abort "Database not found error Language"
    end

    r = MovieLanguage.where("movie_id = :movie and language_id = :language", { movie: movie, language: l["id"] }).take
    if r.blank?
      MovieLanguage.new(:movie_id => movie, :language_id => l["id"]).save()
    end
    # todo: update?
  end

  def addRelationTvCompany(tv, company)
    r = TvCompany.where("tv_id = :tv and company_id = :company", { tv: tv, company: company }).take
    if r.blank?
      TvCompany.new(:tv_id => tv, :company_id => company).save()
    end
    # todo: update?
  end

  def addRelationTvCrew(tv, crew)
    r = TvCrew.where("tv_id = :tv and person_id = :crew", { tv: tv, crew: crew }).take
    if r.blank?
      TvCrew.new(:tv_id => tv, :person_id => crew).save()
    end
    # todo: update?
  end

  def addRelationTvGenre(tv, genre)
    r = TvGenre.where("tv_id = :tv and genre_id = :genre", { tv: tv, genre: genre }).take
    if r.blank?
      TvGenre.new(:tv_id => tv, :genre_id => genre).save()
    end
    # todo: update?
  end

  def addRelationTvNetwork(tv, network)
    r = TvNetwork.where("tv_id = :tv and network_id = :network", { tv: tv, network: network }).take
    if r.blank?
      TvNetwork.new(:tv_id => tv, :network_id => network).save()
    end
    # todo: update?
  end

  def addRelationTvCast(tv, cast, character)
    r = TvCast.where("tv_id = :tv and person_id = :cast", { tv: tv, cast: cast }).take
    if r.blank?
      TvCast.new(:tv_id => tv, :person_id => cast, :character => character).save()
    end
    # todo: update?
  end

  def addRelationTvCrew(tv, crew)
    r = TvCrew.where("tv_id = :tv and person_id = :crew", { tv: tv, crew: crew }).take
    if r.blank?
      TvCrew.new(:tv_id => tv, :person_id => crew).save()
    end
    # todo: update?
  end

  def addRelationEpisodeCast(episode, cast, character)
    r = TvEpisodeCast.where("tv_episode_id = :episode and person_id = :cast", { episode: episode, cast: cast }).take
    if r.blank?
      TvEpisodeCast.new(:tv_episode_id => episode, :person_id => cast, :character => character).save()
    end
    # todo: update?
  end

  def addRelationEpisodeCrew(episode, crew)
    r = TvEpisodeCrew.where("tv_episode_id = :episode and person_id = :crew", { episode: episode, crew: crew }).take
    if r.blank?
      TvEpisodeCrew.new(:tv_episode_id => episode, :person_id => crew).save()
    end
    # todo: update?
  end

  def addRelationEpisodeGuest(episode, cast, character)
    r = TvEpisodeGuest.where("tv_episode_id = :episode and person_id = :cast", { episode: episode, cast: cast }).take
    if r.blank?
      TvEpisodeGuest.new(:tv_episode_id => episode, :person_id => cast, :character => character).save()
    end
    # todo: update?
  end

  def addRelationSeasonCast(season, cast, character)
    r = TvSeasonCast.where("tv_season_id = :season and person_id = :cast", { season: season, cast: cast }).take
    if r.blank?
      TvSeasonCast.new(:tv_season_id => season, :person_id => cast, :character => character).save()
    end
    # todo: update?
  end

  def addRelationSeasonCrew(season, crew)
    r = TvSeasonCrew.where("tv_season_id = :season and person_id = :crew", { season: season, crew: crew }).take
    if r.blank?
      TvSeasonCrew.new(:tv_season_id => season, :person_id => crew).save()
    end
    # todo: update?
  end
  
  ################################################################
  #                       Database Methods                       #
  ################################################################

  def updateGenre(type, id, genre)
    if not ($allowGenreTypes.include? type)
      abort "allow type is #{$allowGenreTypes}"
    end

    begin
      Genre.find(id)
      # todo: update genre?
    rescue ActiveRecord::RecordNotFound
      Genre.new(:id => id, :name => genre).save()
    end
  end

  def updateCompany(id)
    begin
      Company.find(id)
      # todo: update company?
    rescue ActiveRecord::RecordNotFound
      company = getCompanyDetails(id)
      Company.new(
        :id => company["id"],
        :description => company["description"],
        :headquarters => company["headquarters"],
        :homepage => company["homepage"],
        :logo_path => company["logo_path"],
        :name => company["name"],
        :origin_country => company["origin_country"]
      ).save()
    end
  end

  def updateCountry(name)
    r = Country.where(:name => name).take
    if r.blank?
      Country.new(:name => name).save()
    end
    # todo: update?
  end

  def updateMovie(id)
    begin
      return Movie.find(id)
      # todo: update movie?
    rescue ActiveRecord::RecordNotFound
      movie = getMovieDetails(id)
      Movie.new(
        :adult => movie["adult"],
        :backdrop_path => movie["backdrop_path"],
        :budget => movie["budget"],
        :homepage => movie["homepage"],
        :id => movie["id"],
        :original_language => movie["original_language"],
        :original_title => movie["original_title"],
        :overview => movie["overview"],
        :popularity => movie["popularity"],
        :poster_path => movie["poster_path"],
        :release_date => movie["release_date"],
        :revenue => movie["revenue"],
        :runtime => movie["runtime"],
        :title => movie["title"],
        :tagline => movie["tagline"],
        :vote_average => movie["vote_average"],
        :vote_count => movie["vote_count"],
        :status => movie["status"]
      ).save()
      return movie
    end
  end

  def updatePerson(id)
    begin
      Person.find(id)
    rescue ActiveRecord::RecordNotFound
      # "also_known_as"=>[]
      person = getPerson(id)
      Person.new(
        :birthday => person["birthday"],
        :known_for_department => person["known_for_department"],
        :deathday => person["deathday"],
        :id => person["id"],
        :name => person["name"],
        :gender => person["gender"],
        :biography => person["biography"],
        :popularity => person["popularity"],
        :place_of_birth => person["place_of_birth"],
        :profile_path => person["profile_path"],
        :adult => person["adult"],
        :homepage => person["homepage"]
      ).save()

      if not person["also_known_as"].blank?
        for name in person["also_known_as"]
          n = PersonAsName.where("name = :name and person_id = :person", { person: id, name: name }).take
          if n.blank?
            PersonAsName.new(:person_id => id, :name => name).save()
          end
        end
      end
    end
  end

  def updateLanguage(name)
    r = Language.where(:name => name).take
    if r.blank?
      Language.new(:name => name).save()
    end
    # todo: update?
  end

  def updateTv(id)
    begin
      Tv.find(id)
      return tv = getTvDetails(id)
      # todo: update tv?
    rescue ActiveRecord::RecordNotFound
      tv = getTvDetails(id)
      Tv.new(
        :backdrop_path => tv["backdrop_path"],
        :first_air_date => tv["first_air_date"],
        :homepage => tv["homepage"],
        :id => tv["id"],
        :in_production => tv["in_production"],
        :last_air_date => tv["last_air_date"],
        :name => tv["name"],
        :languages => tv["languages"].join(","),
        :number_of_episodes => tv["number_of_episodes"],
        :number_of_seasons => tv["number_of_seasons"],
        :original_name => tv["original_name"],
        :original_language => tv["original_language"],
        :overview => tv["overview"],
        :popularity => tv["popularity"],
        :poster_path => tv["poster_path"],
        :status => tv["status"],
        :tv_type => tv["type"],
        :vote_average => tv["vote_average"],
        :vote_count => tv["vote_count"]
      ).save()
      return tv
    end
  end

  def updateTvRuntime(tv, runtime)
    r = EpisodeRunTime.where("tv_id = :tv and run_time = :runtime", { tv: tv, runtime: runtime }).take
    if r.blank?
      EpisodeRunTime.new(:tv_id => tv, :run_time => runtime).save()
    end
  end

  def updateNetwork(id)
    begin
      Network.find(id)
      # todo: update network?
    rescue ActiveRecord::RecordNotFound
      network = getNetworkDetails(id)
      Network.new(
        :id => network["id"],
        :headquarters => network["headquarters"],
        :homepage => network["homepage"],
        :name => network["name"],
        :origin_country => network["origin_country"],
      ).save()
    end
  end

  def updateSeason(tv_id, season_id)
    r = TvSeason.where("tv_id = :tv_id and season_number = :season_number", { tv_id: tv_id, season_number: season_id }).take
    if r.blank?
      season = getTvSeasonDetails(tv_id, season_id)
      TvSeason.new(
        :tv_id => tv_id,
        :_id => season["_id"],
        :air_date => season["air_date"],
        :name => season["name"],
        :overview => season["overview"],
        :id => season["id"],
        :poster_path => season["poster_path"],
        :season_number => season["season_number"]
      ).save()
      return season
    end

    return r
  end

  def updateEpisode(tv_id, season_id, episode_id)
    r = TvEpisode.where(
      "tv_id = :tv_id and season_number = :season_number and episode_number = :episode_number",
      { tv_id: tv_id, season_number: season_id, episode_number: episode_id }
    ).take
    if r.blank?
      episode = getTvEpisodeDetails(tv_id, season_id, episode_id)
      TvEpisode.new(
        :tv_id => tv_id,
        :air_date => episode["air_date"],
        :episode_number => episode["episode_number"],
        :name => episode["name"],
        :overview => episode["overview"],
        :id => episode["id"],
        :production_code => episode["production_code"],
        :season_number => episode["season_number"],
        :still_path => episode["still_path"],
        :vote_average => episode["vote_average"],
        :vote_count => episode["vote_count"],
      ).save()
      return episode
    end

    return r
  end

  def updateTvLastEpisode(tv_id, episode_id)
    r = TvLastEpisodeToAir.where("tv_id = :tv_id and tv_episode_id = :episode_id", { tv_id: tv_id, episode_id: episode_id }).take
    if r.blank?
      TvLastEpisodeToAir.new(:tv_id => tv_id, :tv_episode_id => episode_id).save()
    end
  end

  ################################################################
  #                       TMDB API Methods                       #
  ################################################################

  def getMovieDetails(movie_id)
    return getRequestDataFromApi(createRequestUrl("/movie/#{movie_id}", {}))
  end

  def getMoviePeople(movie_id)
    return getRequestDataFromApi(createRequestUrl("/movie/#{movie_id}/credits", {}))
  end

  def getCompanyDetails(company_id)
    return getRequestDataFromApi(createRequestUrl("/company/#{company_id}", {}))
  end

  def getPerson(person_id)
    return getRequestDataFromApi(createRequestUrl("/person/#{person_id}", {}))
  end

  def getTvDetails(tv_id)
    return getRequestDataFromApi(createRequestUrl("/tv/#{tv_id}", {}))
  end

  def getNetworkDetails(network_id)
    return getRequestDataFromApi(createRequestUrl("/network/#{network_id}", {}))
  end

  def getTvPeople(tv_id)
    return getRequestDataFromApi(createRequestUrl("/tv/#{tv_id}/credits", {}))
  end

  def getTvSeasonDetails(tv_id, season_id)
    return getRequestDataFromApi(createRequestUrl("/tv/#{tv_id}/season/#{season_id}", {}))
  end

  def getTvEpisodeDetails(tv_id, season_id, episode_id)
    return getRequestDataFromApi(createRequestUrl("/tv/#{tv_id}/season/#{season_id}/episode/#{episode_id}", {}))
  end

  def getEpisodePeople(tv_id, season_id, episode_id)
    return getRequestDataFromApi(createRequestUrl("/tv/#{tv_id}/season/#{season_id}/episode/#{episode_id}/credits", {}))
  end

  def getSeasonPeople(tv_id, season_id)
    return getRequestDataFromApi(createRequestUrl("/tv/#{tv_id}/season/#{season_id}/credits", {}))
  end
  
  def search(type, keyword)
    if not ($allowSearchTypes.include? type)
      abort "allow type is #{$allowSearchTypes}"
    end

    if keyword.blank?
      abort 'require search keywords'
    end

    page = 1
    loop do
      results = searchItems(type, { :query => keyword, :page => page })
      now = ((results["total_results"].to_f / results["total_pages"]).ceil * (page - 1))
      
      if type == "movie"
        crwalingMovies(results["results"], now + 1, results["total_results"])
      end

      if type == "tv"
        crwalingTvs(results["results"], now + 1, results["total_results"])
      end

      break if (page >= results["total_pages"] || page >= 1000)
      page += 1
    end
  end

  def searchItems(type, options)
    if not ($allowSearchTypes.include? type)
      abort 'allow type is [movie, tv]'
    end

    return getRequestDataFromApi(createRequestUrl("/search/#{type}", options ))
  end

  def createRequestUrl(url, args)
    result = API_URL + url
    args[:api_key] = ENV["TMDBAPI_KEY"]

    if not args.to_query.blank?
      result += ('?' + args.to_query)
    end
    
    return result
  end

  def getRequestDataFromApi(url)
    return JSON.parse(Net::HTTP.get(URI(url)))
  end
end
