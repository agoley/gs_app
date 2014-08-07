require 'rubygems'
require 'net/http'
require 'net/https'

module GamesHelper
# Returns an image for the given game.
  def image_for(game)
    game_console_id = game.console.downcase.gsub(/\s/, '_')
    game_console_id = game_console_id.prepend("_")
    game_image_id = game_console_id.prepend(game.title.gsub(/\s/, '_').downcase).gsub(/[:.,'"!#$%^*()?<>\/]/, '')
    image_url = "https://s3.amazonaws.com/gs_game_covers/#{game_image_id}.jpeg"

    uri = URI(image_url)

    request = Net::HTTP.new uri.host
    response= request.request_head uri.path

    if ( response.code == "200" ) then
      image_tag(image_url, alt: game.title, class: "gamecover")
    else
      game_console_id = game.console.downcase.sub(/\s/, '_')
      image_url = "https://s3.amazonaws.com/gs_game_covers/#{game_console_id}.jpeg"
      image_tag(image_url, alt: game.title, class: "consolepic")
    end
  end
end
