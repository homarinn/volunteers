class AddImageToVolunteers < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteers, :image, :string
  end
end