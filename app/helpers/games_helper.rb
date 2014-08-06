module GamesHelper
  def gravatar_for_game(game, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(game.title.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: game.title, class: "gravatar")
   end
end
