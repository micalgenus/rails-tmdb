class AddDetailToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :description, :text
    add_column :companies, :headquarters, :string
    add_column :companies, :homepage, :string
    add_column :companies, :logo_path, :string
    add_column :companies, :name, :string
    add_column :companies, :origin_country, :string
  end
end
