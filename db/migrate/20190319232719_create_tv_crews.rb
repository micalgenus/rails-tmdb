class CreateTvCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_crews do |t|
      t.references :tv, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
