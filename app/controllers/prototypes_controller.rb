class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :move_to_index, except: [:index, :show, :new, :create,:edit,:update,:destroy]


  def index
    @prototype = Prototype.all
  end

  def new
     @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end  
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private

   def prototype_params
     params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
   end

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end

end
