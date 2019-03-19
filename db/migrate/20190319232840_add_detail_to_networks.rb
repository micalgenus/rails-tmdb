class AddDetailToNetworks < ActiveRecord::Migration[5.2]
  def change
    add_column :networks, :headquarters, :string
    add_column :networks, :homepage, :string
    add_column :networks, :name, :string
    add_column :networks, :origin_country, :string
  end
end
