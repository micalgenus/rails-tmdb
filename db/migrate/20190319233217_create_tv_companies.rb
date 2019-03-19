class CreateTvCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_companies do |t|
      t.references :tv, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
