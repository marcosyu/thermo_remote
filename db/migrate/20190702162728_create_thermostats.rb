class CreateThermostats < ActiveRecord::Migration[5.2]
  def change
    create_table :thermostats do |t|
      t.string :location
      t.string :household_token

      t.timestamps
    end
  end
end
