module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Game Swap"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def genre?
    @game = Game.find(params[:id])
    !@game.genre == ""
  end 

  def developer?
   @game = Game.find(params[:id])
   !@game.developer == ""
  end  
end
