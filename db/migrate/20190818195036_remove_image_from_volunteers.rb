class RemoveImageFromVolunteers < ActiveRecord::Migration[5.2]
  def change
    remove_column :volunteers, :image, :string
  end
end
