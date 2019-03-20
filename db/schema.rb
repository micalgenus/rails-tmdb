# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_20_185234) do

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "headquarters"
    t.string "homepage"
    t.string "logo_path"
    t.string "name"
    t.string "origin_country"
  end

  create_table "countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episode_run_times", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.decimal "run_time", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_id"], name: "index_episode_run_times_on_tv_id"
  end

  create_table "genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_casts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movie_id"
    t.bigint "person_id"
    t.string "character"
    t.decimal "order", precision: 10
    t.index ["movie_id"], name: "index_movie_casts_on_movie_id"
    t.index ["person_id"], name: "index_movie_casts_on_person_id"
  end

  create_table "movie_companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_movie_companies_on_company_id"
    t.index ["movie_id"], name: "index_movie_companies_on_movie_id"
  end

  create_table "movie_countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_movie_countries_on_country_id"
    t.index ["movie_id"], name: "index_movie_countries_on_movie_id"
  end

  create_table "movie_crews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movie_id"
    t.bigint "person_id"
    t.index ["movie_id"], name: "index_movie_crews_on_movie_id"
    t.index ["person_id"], name: "index_movie_crews_on_person_id"
  end

  create_table "movie_genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movie_id"
    t.bigint "genre_id"
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id"
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id"
  end

  create_table "movie_languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_movie_languages_on_language_id"
    t.index ["movie_id"], name: "index_movie_languages_on_movie_id"
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "adult"
    t.string "backdrop_path"
    t.decimal "budget", precision: 10
    t.string "homepage"
    t.string "original_language"
    t.string "original_title"
    t.text "overview"
    t.float "popularity"
    t.string "poster_path"
    t.date "release_date"
    t.decimal "revenue", precision: 10
    t.decimal "runtime", precision: 10
    t.string "status"
    t.string "tagline"
    t.string "title"
    t.float "vote_average"
    t.decimal "vote_count", precision: 10
  end

  create_table "networks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "headquarters"
    t.string "homepage"
    t.string "name"
    t.string "origin_country"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "birthday"
    t.string "known_for_department"
    t.date "deathday"
    t.string "name"
    t.decimal "gender", precision: 10
    t.text "biography"
    t.float "popularity"
    t.string "place_of_birth"
    t.string "profile_path"
    t.boolean "adult"
    t.string "imdb_id"
    t.string "homepage"
  end

  create_table "person_as_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.string "name"
    t.index ["person_id"], name: "index_person_as_names_on_person_id"
  end

  create_table "tv_casts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "character"
    t.decimal "order", precision: 10
    t.index ["person_id"], name: "index_tv_casts_on_person_id"
    t.index ["tv_id"], name: "index_tv_casts_on_tv_id"
  end

  create_table "tv_companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_tv_companies_on_company_id"
    t.index ["tv_id"], name: "index_tv_companies_on_tv_id"
  end

  create_table "tv_crews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_tv_crews_on_person_id"
    t.index ["tv_id"], name: "index_tv_crews_on_tv_id"
  end

  create_table "tv_episode_casts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_episode_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "character"
    t.decimal "order", precision: 10
    t.index ["person_id"], name: "index_tv_episode_casts_on_person_id"
    t.index ["tv_episode_id"], name: "index_tv_episode_casts_on_tv_episode_id"
  end

  create_table "tv_episode_crews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_episode_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_tv_episode_crews_on_person_id"
    t.index ["tv_episode_id"], name: "index_tv_episode_crews_on_tv_episode_id"
  end

  create_table "tv_episode_guests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_episode_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "character"
    t.decimal "order", precision: 10
    t.index ["person_id"], name: "index_tv_episode_guests_on_person_id"
    t.index ["tv_episode_id"], name: "index_tv_episode_guests_on_tv_episode_id"
  end

  create_table "tv_episodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "air_date"
    t.decimal "episode_number", precision: 10
    t.string "name"
    t.text "overview"
    t.string "production_code"
    t.decimal "season_number", precision: 10
    t.string "still_path"
    t.float "vote_average"
    t.decimal "vote_count", precision: 10
  end

  create_table "tv_genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tv_id"
    t.bigint "genre_id"
    t.index ["genre_id"], name: "index_tv_genres_on_genre_id"
    t.index ["tv_id"], name: "index_tv_genres_on_tv_id"
  end

  create_table "tv_last_episode_to_airs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.bigint "tv_episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_episode_id"], name: "index_tv_last_episode_to_airs_on_tv_episode_id"
    t.index ["tv_id"], name: "index_tv_last_episode_to_airs_on_tv_id"
  end

  create_table "tv_networks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.bigint "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_id"], name: "index_tv_networks_on_network_id"
    t.index ["tv_id"], name: "index_tv_networks_on_tv_id"
  end

  create_table "tv_season_casts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_season_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "character"
    t.decimal "order", precision: 10
    t.index ["person_id"], name: "index_tv_season_casts_on_person_id"
    t.index ["tv_season_id"], name: "index_tv_season_casts_on_tv_season_id"
  end

  create_table "tv_season_crews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_season_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_tv_season_crews_on_person_id"
    t.index ["tv_season_id"], name: "index_tv_season_crews_on_tv_season_id"
  end

  create_table "tv_season_episodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_season_id"
    t.bigint "tv_episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_episode_id"], name: "index_tv_season_episodes_on_tv_episode_id"
    t.index ["tv_season_id"], name: "index_tv_season_episodes_on_tv_season_id"
  end

  create_table "tv_seasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "_id"
    t.date "air_date"
    t.string "name"
    t.text "overview"
    t.string "poster_path"
    t.decimal "season_number", precision: 10
  end

  create_table "tv_with_seasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "tv_id"
    t.bigint "tv_season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_id"], name: "index_tv_with_seasons_on_tv_id"
    t.index ["tv_season_id"], name: "index_tv_with_seasons_on_tv_season_id"
  end

  create_table "tvs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "backdrop_path"
    t.date "first_air_date"
    t.string "homepage"
    t.boolean "in_production"
    t.date "last_air_date"
    t.string "name"
    t.decimal "number_of_episodes", precision: 10
    t.decimal "number_of_seasons", precision: 10
    t.string "original_language"
    t.string "original_name"
    t.text "overview"
    t.float "popularity"
    t.string "poster_path"
    t.string "status"
    t.string "type"
    t.float "vote_average"
    t.decimal "vote_count", precision: 10
    t.string "languages"
  end

  add_foreign_key "episode_run_times", "tvs"
  add_foreign_key "movie_casts", "movies"
  add_foreign_key "movie_casts", "people"
  add_foreign_key "movie_companies", "companies"
  add_foreign_key "movie_companies", "movies"
  add_foreign_key "movie_countries", "countries"
  add_foreign_key "movie_countries", "movies"
  add_foreign_key "movie_crews", "movies"
  add_foreign_key "movie_crews", "people"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "movie_languages", "languages"
  add_foreign_key "movie_languages", "movies"
  add_foreign_key "person_as_names", "people"
  add_foreign_key "tv_casts", "people"
  add_foreign_key "tv_casts", "tvs"
  add_foreign_key "tv_companies", "companies"
  add_foreign_key "tv_companies", "tvs"
  add_foreign_key "tv_crews", "people"
  add_foreign_key "tv_crews", "tvs"
  add_foreign_key "tv_episode_casts", "people"
  add_foreign_key "tv_episode_casts", "tv_episodes"
  add_foreign_key "tv_episode_crews", "people"
  add_foreign_key "tv_episode_crews", "tv_episodes"
  add_foreign_key "tv_episode_guests", "people"
  add_foreign_key "tv_episode_guests", "tv_episodes"
  add_foreign_key "tv_genres", "genres"
  add_foreign_key "tv_genres", "tvs"
  add_foreign_key "tv_last_episode_to_airs", "tv_episodes"
  add_foreign_key "tv_last_episode_to_airs", "tvs"
  add_foreign_key "tv_networks", "networks"
  add_foreign_key "tv_networks", "tvs"
  add_foreign_key "tv_season_casts", "people"
  add_foreign_key "tv_season_casts", "tv_seasons"
  add_foreign_key "tv_season_crews", "people"
  add_foreign_key "tv_season_crews", "tv_seasons"
  add_foreign_key "tv_season_episodes", "tv_episodes"
  add_foreign_key "tv_season_episodes", "tv_seasons"
  add_foreign_key "tv_with_seasons", "tv_seasons"
  add_foreign_key "tv_with_seasons", "tvs"
end
