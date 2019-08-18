class CreateVolunteers < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteers do |t|
      t.string :title, null: false
      t.text :summary
      t.string :location
      t.string :date

      t.timestamps
    end
  end
end
