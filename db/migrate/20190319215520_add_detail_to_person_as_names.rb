class AddDetailToPersonAsNames < ActiveRecord::Migration[5.2]
  def change
    add_reference :person_as_names, :person, foreign_key: true
    add_column :person_as_names, :name, :string
  end
end
