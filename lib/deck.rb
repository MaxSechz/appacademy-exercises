require_relative 'card.rb'

class Deck

  attr_reader :cards

  def self.make_deck
    full_deck = []
    Card.suits.each do |suit|
      Card.faces.each do |face|
        full_deck << Card.new(face, suit)
      end
    end

    full_deck
  end

  def initialize
    @cards = Deck.make_deck
  end

  def draw(num = 1)
    cards = []
    num.times do
      cards << @cards.shift
    end

    cards
  end

  def shuffle
    @cards.shuffle!
  end

end
