class GamesController < ApplicationController
   before_action :signed_in_user, only: [:new]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.seller_id = current_user.id
    if @game.save
      flash[:success] = "Your game was succesfully posted."
      redirect_to @game
    else
      puts " ****************************GAME FAILED TO SAVE*********************"
      flash.now[:danger] = 'Failed to save, check that you have entered a title, and console.'
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

   def game_params
      params.require(:game).permit(:title, :console, :condition, :ask_price,
                                   :notes, :original_packaging)
    end


    def current_user
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end

    def current_user?(user)
      user == current_user
    end
end
