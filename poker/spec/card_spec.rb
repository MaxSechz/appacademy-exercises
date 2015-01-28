require 'rspec'
require 'card.rb'

describe Card do
  subject(:card) { Card.new(:king, :club) }

  it "initializes with a suit" do
    expect(card.suit).to eq(:club)
  end

  it "initializes with a face" do
    expect(card.face).to eq(:king)
  end

  describe "#>" do
    let(:larger_card) { Card.new(:ace, :heart) }
    let(:smaller_card) { Card.new(:ten, :diamond) }
    let(:better_suit) { Card.new(:king, :diamond)}
    let(:worse_suit) { Card.new(:king, :heart)}

    it "returns true if left card greater than right card" do
      expect(card > smaller_card).to eq(true)
    end

    it "returns false if left card smaller than right card" do
      expect(card > larger_card).to eq(false)
    end

    it "returns true if faces are equal but left card has better suit" do
      expect(card > worse_suit).to eq(true)
    end

    it "returns false if faces equal but left card has worse suit" do
      expect(card > better_suit).to eq(false)
    end

  end

  describe "#==" do
    let(:equal) { Card.new(:king, :club)}
    let(:different_suit) { Card.new(:king, :heart)}
    let(:different_face) {Card.new(:queen, :club)}
    let(:different) {Card.new(:ace, :diamond)}

    it "returns true if both face and suit are the same" do
      expect(card==equal).to eq(true)
    end

    it "returns false if the suits differ" do
      expect(card==different_suit).to eq(false)
    end

    it "returns false if the faces differ" do
      expect(card==different_face).to eq(false)
    end

    it "returns false if both face and suit differ" do
      expect(card==different).to eq(false)
    end
  end
end
