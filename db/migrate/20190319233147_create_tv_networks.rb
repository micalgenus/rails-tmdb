class CreateTvNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_networks do |t|
      t.references :tv, foreign_key: true
      t.references :network, foreign_key: true

      t.timestamps
    end
  end
end
