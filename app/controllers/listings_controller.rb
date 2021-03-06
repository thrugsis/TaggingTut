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
      @listings = Listing.paginate(page: params[:page]).order('created_at DESC')
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  
  

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user[:id]
    @listing.image = params["listing"]["image"]
    @listing.save
     respond_to do |format|
        format.js
        format.html { redirect_to root_path }
      end
  end

  def show
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to root_path
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:id, :page, :title, :price, :location, :bedrooms, :bathrooms, :amenities, :description, {image:[]}, :used_date, :all_tags, :tag)
    end
end

