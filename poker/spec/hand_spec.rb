require 'rspec'
require 'hand.rb'

describe Hand do
  subject(:hand) {Hand.new}

  describe '#<<' do
    let(:cards) {[:ace, :king, :queen]}
    it "accepts cards" do
      hand << cards
      expect(hand.cards).to eq(cards)
    end
  end
  describe '#discard' do
    let(:cards)  {[
                    double("king", face: :king, suit: :heart),
                    double("queen of clubs", face: :queen, suit: :club),
                    double("five", face: :five, suit: :diamond),
                    double("queen of diamongs", face: :queen, suit: :diamond),
                    double("ten", face: :ten, suit: :club)
                  ]}

    it 'removes the correct number of cards' do
      hand << cards
      hand.discard([[:queen, :club]])
      expect(hand.count).to eq(4)
    end

    it 'removes the correct cards' do
      hand << cards
      expect(hand.discard([[:king, :heart]])).to eq(cards[0])
    end
  end

  describe '#straight?' do

    let(:straight)  {[
      double("nine", value: 9),
      double("ten", value: 10),
      double("jack", value: 11),
      double("queen", value: 12),
      double("king", value: 13)
      ]}

    let(:not_straight)  {[
      double("king", value: 13),
      double("queen of clubs", value: 12),
      double("five", value: 5),
      double("queen of diamongs", value: 12),
      double("ten", value: 10)
      ]}

    it 'returns true if your hand is a straight' do
      hand << straight
      expect(hand.straight?).to eq(true)
    end

    it 'returns false if your hand is not a straight' do
      hand << not_straight
      expect(hand.straight?).to eq(false)
    end
  end

  describe '#flush?' do
    let(:flush)  {[
      double("king", face: :king, suit: :diamond),
      double("queen of clubs", face: :six, suit: :diamond),
      double("five", face: :five, suit: :diamond),
      double("queen of diamongs", face: :queen, suit: :diamond),
      double("ten", face: :ten, suit: :diamond)
      ]}

    let(:not_flush)  {[
      double("king", face: :king, suit: :heart),
      double("queen of clubs", face: :queen, suit: :club),
      double("five", face: :five, suit: :diamond),
      double("queen of diamongs", face: :queen, suit: :diamond),
      double("ten", face: :ten, suit: :club)
      ]}

      it 'returns true if all the cards in your hand have the same suit' do
        hand << flush
        expect(hand.flush?).to eq(true)
      end

      it 'returns false if any card does not match the suit of the rest' do
        hand << not_flush
        expect(hand.flush?).to eq(false)
      end
    end

    describe '#of_a_kind' do
      let(:pair)  {[
        double("king", face: :king, suit: :heart),
        double("queen of clubs", face: :queen, suit: :club),
        double("five", face: :five, suit: :diamond),
        double("queen of diamongs", face: :queen, suit: :diamond),
        double("ten", face: :ten, suit: :club)
        ]}

      let(:none)  {[
        double("king", face: :king, suit: :heart),
        double("queen of clubs", face: :queen, suit: :club),
        double("five", face: :five, suit: :diamond),
        double("queen of diamongs", face: :deuce, suit: :diamond),
        double("ten", face: :ten, suit: :club)
        ]}

      let(:three)  {[
        double("king", face: :queen, suit: :heart),
        double("queen of clubs", face: :queen, suit: :club),
        double("five", face: :five, suit: :diamond),
        double("queen of diamongs", face: :queen, suit: :diamond),
        double("ten", face: :ten, suit: :club)
        ]}

      let(:four)  {[
        double("king", face: :queen, suit: :heart),
        double("queen of clubs", face: :queen, suit: :club),
        double("five", face: :queen, suit: :spade),
        double("queen of diamongs", face: :queen, suit: :diamond),
        double("ten", face: :king, suit: :club)
        ]}

      let(:full_house)  {[
        double("king", face: :king, suit: :heart),
        double("queen of clubs", face: :queen, suit: :club),
        double("five", face: :king, suit: :diamond),
        double("queen of diamongs", face: :queen, suit: :diamond),
        double("ten", face: :king, suit: :club)
        ]}

      let(:two_pair)  {[
        double("king", face: :king, suit: :heart),
        double("queen of clubs", face: :queen, suit: :club),
        double("five", face: :five, suit: :diamond),
        double("queen of diamongs", face: :queen, suit: :diamond),
        double("ten", face: :king, suit: :club)
        ]}

      it 'returns pair when only two cards have the same face' do
        hand << pair
        expect(hand.of_a_kind).to eq(:pair)
      end

      it 'returns three when three cards have the same face but not full house' do
        hand << three
        expect(hand.of_a_kind).to eq(:three)
      end

      it 'returns four when 4 cards have the same face' do
        hand << four
        expect(hand.of_a_kind).to eq(:four)
      end

      it 'returns full house when 3 of a kind AND a pair' do
        hand << full_house
        expect(hand.of_a_kind).to eq(:full_house)
      end

      it 'returns two pair when there are two pairs' do
        hand << two_pair
        expect(hand.of_a_kind).to eq(:two_pair)
      end

      it 'returns none if there are no matching faces' do
        hand << none
        expect(hand.of_a_kind).to eq(:none)
      end
    end
end
