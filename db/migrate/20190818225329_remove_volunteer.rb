class RemoveVolunteer < ActiveRecord::Migration[5.2]
  def change
    drop_table :volunteers
  end
end
