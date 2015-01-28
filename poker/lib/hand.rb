require 'deck.rb'

class Hand

  def initialize
    @cards = []
  end

  def <<(card_array)
    @cards.concat(card_array)
  end

  def discard(faces_and_suits)
    faces_and_suits.each do |(face, suit)|
      @cards.each do |card|
        return @cards.delete(card) if card.face == face && card.suit == suit
      end
    end
  end

  def cards
    @cards.sort!
  end

  def count
    @cards.count
  end

  def best
  end

  def straight?
    @cards.each_with_index do |card, index|
      break if index + 1 == @cards.count
      return false if @cards[index+1].value - card.value != 1
    end

    true
  end

  def flush?
    test_suit = @cards[0].suit
    return true if @cards.all? {|card| card.suit == test_suit}
    false
  end


end
