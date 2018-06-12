class ListingsController < ApplicationController


  def index
    if params[:tag]
      @listings = [] 
      params[:tag].split(", ").map do |x|
        if Tag.all.find_by(name: x)
          @listings = Listing.tagged_with(x)
        else
          @listings += []
        end
      end
    else
      @listings = Listing.all
    end
  end

  
  

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user[:id]
    @listing.image = params["listing"]["image"]
    # workaround if you don't want to use javascript to reset the fields
    # @listing.save
    # redirect_to root_path
    respond_to do |format|
      if @listing.save
        format.js # Will search for create.js.erb and reload the create listing field and update the listings
        format.html { redirect_to root_path }
      else
        format.html { render root_path }
        format.json { render root_path }
      end
    end
  end

  def show
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :price, :location, :bedrooms, :bathrooms, :amenities, :description, {image:[]}, :used_date, :all_tags, :tag)
    end
end

