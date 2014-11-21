require 'rspec'
require 'deck.rb'

describe Deck do
  describe '::make_deck' do
    subject(:all_cards) {Deck.make_deck}

    it 'has 52 cards' do
      expect(all_cards.count).to eq(52)
    end

    it 'does not have any duplicates' do
      expect(all_cards.uniq.count).to eq(52)
    end

    it 'is composed of only card objects' do
      expect(all_cards.all? { |card| card.class == Card }).to eq(true)
    end
  end

  describe "#draw" do
    subject(:deck) {Deck.new}
    it 'returns the correct number of cards' do
      expect(deck.draw(5).count).to eq(5)
      expect(deck.draw(0).count).to eq(0)
    end

    it 'removes drawn cards from deck' do
      first_five = deck.cards.take(5)
      deck.draw(5)
      expect(first_five.any? { |card| deck.cards.include?(card) }).to eq(false)
    end

    it 'draws cards from the top of the deck' do
      first_five = deck.cards.take(5)
      expect(deck.draw(5)).to eq(first_five)
    end

  end

  describe "#shuffle" do
    subject(:deck) {Deck.new}

    it 'retains the length of the deck' do
      duped = deck.cards.dup
      expect(deck.shuffle.size).to eq(duped.size)
    end

    it 'has the same cards as the original' do
      duped = deck.cards.dup
      expect(deck.shuffle.sort).to eq(duped.sort)
    end

    it 'is in a different order than the original deck' do
      duped = deck.cards.dup
      expect(deck.shuffle).not_to eq(duped)
    end
  end
end
