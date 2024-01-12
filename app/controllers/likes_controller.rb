class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]

  # GET /likes or /likes.json
  def index
    @likes = current_user.likes
    @categories = current_user.categories


    if params[:category_id].present?
      @likes = @likes.where(category_id: params[:category_id])
    end

    puts "Categories: #{@categories.inspect}" # Add this line

  end

  # GET /likes/1 or /likes/1.json
  def show
  end


  # GET /likes/new
  def new
    @like = Like.new
    @categories = current_user.categories
  end

  # GET /likes/1/edit
  def edit

  end

  # POST /likes or /likes.json
  def create
    @photo = Photo.find(params[:photo_id])

    # Find or create the category with the given name
    category = current_user.categories.find_or_create_by(name: params[:category_name])

    # Build a new like with the given attributes and associated category
    @like = current_user.likes.build(
      photo: @photo,
      caption: @photo.caption,
      image: @photo.image,
      category: category
    )

    respond_to do |format|
      if @like.save
        format.html { redirect_to likes_path(@like), notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end




  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to like_url(@like), notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy

    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:photo_id, :user_id, :category_name, :image, :caption)
    end
end
