class AddDetailToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :birthday, :date
    add_column :people, :known_for_department, :string
    add_column :people, :deathday, :date
    add_column :people, :name, :string
    add_column :people, :gender, :decimal
    add_column :people, :biography, :text
    add_column :people, :popularity, :float
    add_column :people, :place_of_birth, :string
    add_column :people, :profile_path, :string
    add_column :people, :adult, :boolean
    add_column :people, :imdb_id, :string
    add_column :people, :homepage, :string
  end
end
