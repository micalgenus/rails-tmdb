class AddDetailToTvCasts < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_casts, :character, :string
    add_column :tv_casts, :order, :decimal
  end
end
