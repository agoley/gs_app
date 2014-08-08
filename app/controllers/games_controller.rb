require 'rubygems'
require 'net/http'
require 'net/https'
require 'open-uri'

class GamesController < ApplicationController
   before_action :signed_in_user, only: [:new]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.seller_id = current_user.id
    gamerevolution_title = @game.title.downcase.gsub(/[ ]/, '-').gsub(/[:.,'"!#$%^*()?<>\/]/, '')
    url = "http://www.gamerevolution.com/game/#{gamerevolution_title}"
    puts url
    uri = URI(url)

    request = Net::HTTP.new uri.host
    response= request.request_head uri.path
    puts "RESPONE CODE = " + response.code.to_s

    game_exists = if (response.code == "200") then true else false end
    if game_exists

      # Scrape valuable data from site
      genre = 'not found'
      publisher = 'not found'
      developer = 'not found'
      previous = ""
      open(url) do |file|
        file.each_line do |line|
          if previous =~ /(.*)GENRE(.*)/ 
            # Found the genre line, now grab the genre
            genre = line.gsub(/<td class="gameinfotd black">/, '')
            genre.gsub!(/&nbsp;<\/td>/, '')
          end 
          if previous =~ /(.*)PUBLISHER(.*)/
            publisher = line.gsub(/<td class="gameinfotd black">/, '')
            publisher.gsub!(/&nbsp;<\/td>/, '')
          end
          if previous =~ /(.*)DEVELOPER(.*)/
            developer = line.gsub(/<td class="gameinfotd black">/, '')
            developer.gsub!(/&nbsp;<\/td>/, '')
          end
          previous = line 
        end
      end
      @game.genre = genre
      @game.publisher = publisher
      @game.developer = developer
      if @game.save
        flash[:success] = "Your game was succesfully posted."
        redirect_to @game
      else
        redirect_to upload_path
        flash[:danger] = "Failed to save, make sure you have entered a title and a console."
      end
    else
      redirect_to upload_path
      flash[:danger] = "We've never heard of that game, please check the spelling and enter the full 
      title as it is on the cover. 
      If you are entering a real game and getting this message please let us know at help@gameswap.com."
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def index
    @games = Game.paginate(page: params[:page])
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
                                   :notes, :original_packaging, :genre)
    end


    def current_user
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end

    def current_user?(user)
      user == current_user
    end
end
