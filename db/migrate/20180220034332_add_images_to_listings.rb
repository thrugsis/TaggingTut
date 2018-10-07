class AddImagesToListings < ActiveRecord::Migration
  def change
    add_column :listings, :image, :string
  end
end
