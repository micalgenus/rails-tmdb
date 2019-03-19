class AddLanguagesToTvs < ActiveRecord::Migration[5.2]
  def change
    add_column :tvs, :languages, :string
  end
end
