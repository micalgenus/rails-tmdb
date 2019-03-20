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

  def crwalingMovies(movie_lists)
    for movie in movie_lists
      crawlingMovie(movie["id"])
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

    people = getMoviePeoples(movie_id)
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
        :biography => person["biography"].strip,
        :popularity => person["popularity"],
        :place_of_birth => person["place_of_birth"],
        :profile_path => person["profile_path"],
        :adult => person["adult"],
        :homepage => person["homepage"]
      ).save()

      for name in person["also_known_as"]
        n = PersonAsName.where("name = :name and person_id = :person", { person: id, name: name }).take
        if n.blank?
          PersonAsName.new(:person_id => id, :name => name).save()
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

  ################################################################
  #                       TMDB API Methods                       #
  ################################################################

  def getMovieDetails(movie_id)
    return getRequestDataFromApi(createRequestUrl("/movie/#{movie_id}", {}))
  end

  def getMoviePeoples(movie_id)
    return getRequestDataFromApi(createRequestUrl("/movie/#{movie_id}/credits", {}))
  end

  def getCompanyDetails(company_id)
    return getRequestDataFromApi(createRequestUrl("/company/#{company_id}", {}))
  end

  def getPerson(person_id)
    return getRequestDataFromApi(createRequestUrl("/person/#{person_id}", {}))
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
      if type == "movie"
        crwalingMovies(results["results"])
      end

      break
      # break if (page >= results["total_pages"] || page >= 1000)
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
