require 'spec_helper'

describe Game do

  before { @game = Game.new(title: "Test Game", console: "PS4", ask_price: 0,
		condition: "Good", original_packaging: true, seller_id: 1,
		notes: "this is a test game") }

  subject { @game }

  it { should respond_to(:title) }
end
