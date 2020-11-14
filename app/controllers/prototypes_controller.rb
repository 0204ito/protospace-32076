class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index,except: [:index, :show]

  def index
    @prototypes = Prototype.includes(:user)
    
  end
 
  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
 

  def new
    @prototype = Prototype.new
  end

  def edit
  
    unless user_signed_in?&& current_user.id == @prototype.user_id
     redirect_to action: :index
    end

  end  
 
  def update
    @prototype.update(prototype_params)

    if @prototype.update(prototype_params)
      redirect_to prototypes_path
    else
      render :edit 
    end
  end

  def destroy
    @prototype.destroy
    render :index
  end



  def create
    @prototype=Prototype.new(prototype_params)
    if @prototype.save
      redirect_to prototypes_path
    else
      render :new 
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  
  
  def move_to_index
   unless user_signed_in?
    redirect_to action: :index
   end
  end
end
