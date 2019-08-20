class RemoveOffer < ActiveRecord::Migration[5.2]
  def change
    drop_table :offers
  end
end
