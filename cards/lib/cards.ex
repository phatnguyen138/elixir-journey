defmodule Cards do
  @moduledoc """
    This function is used for create and control cards
  """

  @doc """
    This function is used for creating a typical deck with 52 card

  ## Example
      iex> deck = Cards.create_deck()
      iex> deck
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
     "Jack", "Queen", "King"]
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
      iex> shuffled_deck
  """
  def shuffle(deck \\ ["Hehe"]) do
    Enum.shuffle(deck)
  end

  @doc """
    This function is used for checking if a deck contains a specific hand

  ## Example
      iex> deck = Cards.create_deck()
      iex> hand = "Ace of Hearts"
      iex> is_contains = Cards.contains?(deck, hand)
      iex> is_contains
      :true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    This function is used for dealing a hand from a deck of cards

  ## Example
      iex> deck = Cards.create_deck()
      iex> {hand, remaining_deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Hearts"]
      iex> remaining_deck
  """
  def deal(decks, hand_size \\ 4) do
    Enum.split(decks, hand_size)
  end

  @doc """
    This function is used for saving a deck to a file

  ## Example
      iex> deck = Cards.create_deck()
      iex> Cards.save(deck, "files/my_deck")
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
      iex> hand
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

  @doc """
    This function use the map a key to map with pattern matching

  ## Example
      iex> colors = Cards.mapping_pattern()
      iex> colors
      "red"
  """
  def mapping_pattern do
    colors = %{primary: "red", secondary: "blue"}
    %{primary: first_color} = colors
    first_color
  end

  @doc """
    This function represent how to update a value of key in map

  ## Example
      iex> new_colors = Cards.replace_in_map()
      iex> new_colors
      %{primary: "green", secondary: "blue"}
  """
  def replace_in_map do
    colors = %{primary: "red", secondary: "blue"}
    new_colors = Map.put(colors,:primary, "green")
    new_colors
  end

  @doc """
    This function represent how to update a value of key in map in a new way
    **Note:** The key must have existed in that map

  ## Example
      iex> new_colors = Cards.replace_in_map()
      iex> new_colors
      %{primary: "green", secondary: "blue"}
  """
  def replace_in_map_v2 do
    colors = %{primary: "red", secondary: "blue"}
    new_colors = %{colors | primary: "green"}
    new_colors
  end

end
