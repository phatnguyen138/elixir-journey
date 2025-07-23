defmodule Cards do
  def create_deck do
    values = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
     "Jack", "Queen", "King", "Ace"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    cards = for suit <- suits  do
      for value <- values  do
        "#{value} of #{suit}"
      end
    end

    List.flatten(cards)
  end

  def shuffle(deck \\ ["Hehe"]) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

end
