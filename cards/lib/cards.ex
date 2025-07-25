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

  def save(deck, file_name \\ "my_deck") do
    deck_file = :erlang.term_to_binary(deck)
    File.write(file_name, deck_file)
  end

  def load(filename) do
    {status,binary} = File.read(filename)

    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "Incorrect file name!"
    end
  end

end
