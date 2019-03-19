class CreatePersonAsNames < ActiveRecord::Migration[5.2]
  def change
    create_table :person_as_names do |t|

      t.timestamps
    end
  end
end
