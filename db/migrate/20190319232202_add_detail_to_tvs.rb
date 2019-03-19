class AddDetailToTvs < ActiveRecord::Migration[5.2]
  def change
    add_column :tvs, :backdrop_path, :string
    add_column :tvs, :first_air_date, :date
    add_column :tvs, :homepage, :string
    add_column :tvs, :in_production, :boolean
    add_column :tvs, :last_air_date, :date
    add_column :tvs, :name, :string
    add_column :tvs, :number_of_episodes, :decimal
    add_column :tvs, :number_of_seasons, :decimal
    add_column :tvs, :original_language, :string
    add_column :tvs, :original_name, :string
    add_column :tvs, :overview, :text
    add_column :tvs, :popularity, :float
    add_column :tvs, :poster_path, :string
    add_column :tvs, :status, :string
    add_column :tvs, :type, :string
    add_column :tvs, :vote_average, :float
    add_column :tvs, :vote_count, :decimal
  end
end
