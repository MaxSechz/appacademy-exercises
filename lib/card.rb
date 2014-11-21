class Card

  FACE_HIERARCHY = {
              deuce: 2,
              three: 3,
              four: 4,
              five: 5,
              six: 6,
              seven: 7,
              eight: 8,
              nine: 9,
              ten: 10,
              jack: 11,
              queen: 12,
              king: 13,
              ace: 14
  }

  SUIT_HIERARCHY = {
    heart: 0,
    club: 1,
    diamond: 2,
    spade: 3
  }

  attr_reader :face, :suit

  def initialize(face, suit)
    @face, @suit = face, suit
  end

  def >(other_card)
    if FACE_HIERARCHY[self.face] == FACE_HIERARCHY[other_card.face]
      return SUIT_HIERARCHY[self.suit] > SUIT_HIERARCHY[other_card.suit]
    end

    FACE_HIERARCHY[self.face] > FACE_HIERARCHY[other_card.face]
  end

  def ==(other_card)
    @face == other_card.face && @suit == other_card.suit
  end

  def <=>(other_card)
    return 1 if self > other_card
    return 0 if self == other_card
    return -1
  end

  def Card.suits
    SUIT_HIERARCHY.keys
  end

  def Card.faces
    FACE_HIERARCHY.keys
  end

  def value
    FACE_HIERARCHY[self]
  end

end
