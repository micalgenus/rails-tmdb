class CreateTvs < ActiveRecord::Migration[5.2]
  def change
    create_table :tvs do |t|

      t.timestamps
    end
  end
end
