defmodule Cards do
  @moduledoc """
    This function is used for create and control cards
  """

  @doc """
    This function is used for creating a typical deck with 52 card

  ## Example
      iex> deck = Cards.create_deck()
  """
  def create_deck do
    values = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
     "Jack", "Queen", "King", "Ace"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    cards = for suit <- suits, value <- values  do
        "#{value} of #{suit}"
    end

    List.flatten(cards)
  end

  @doc """
    This function is used for shuffling a deck of cards

  ## Example
      iex> deck = Cards.create_deck()
      iex> shuffled_deck = Cards.shuffle(deck)
  """
  def shuffle(deck \\ ["Hehe"]) do
    Enum.shuffle(deck)
  end

  @doc """
    This function is used for checking if a deck contains a specific hand

  ## Example
      iex> deck = Cards.create_deck()
      iex> hand = ["One of Hearts", "Two of Diamonds"]
      iex> Cards.contains?(deck, hand)
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    This function is used for dealing a hand from a deck of cards

  ## Example
      iex> deck = Cards.create_deck()
      iex> {hand, remaining_deck} = Cards.deal(deck, 5)
      iex> hand
      ["One of Hearts", "Two of Diamonds", "Three of Clubs", "Four of Spades", "Five of Hearts"]
  """
  def deal(decks, hand_size \\ 4) do
    Enum.split(decks, hand_size)
  end

  @doc """
    This function is used for saving a deck to a file

  ## Example
      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "my_deck")
  """
  def save(deck, file_name \\ "my_deck") do
    deck_file = :erlang.term_to_binary(deck)
    File.write(file_name, deck_file)
  end

  @doc """
    This function is used for loading a deck from a file

  ## Example
      iex> Cards.load("my_deck")
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, error }-> "Incorrect file name! #{error}"
    end
  end

  @doc """
    This function is used for creating a hand of cards

  ## Example
      iex> hand = Cards.create_hand(5)
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

end
