defmodule Cards do
  def create_deck do
    values = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
     "Jack", "Queen", "King", "Ace"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    cards = for suit <- suits, value <- values  do
        "#{value} of #{suit}"
    end

    List.flatten(cards)
  end

  def shuffle(deck \\ ["Hehe"]) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  def deal(decks, hand_size \\ 4) do
    Enum.split(decks, hand_size)
  end

end
