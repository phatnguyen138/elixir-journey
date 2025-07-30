defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck/0 creates a deck with 52 cards" do
    deck = Cards.create_deck()
    assert length(deck) == 52
    assert Enum.member?(deck, "Ace of Hearts")
    assert Enum.member?(deck, "Two of Diamonds")
  end

  test "shuffle/1 shuffles the deck" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    refute shuffled_deck == deck
    assert length(shuffled_deck) == 52
  end

  test "contains?/2 checks if a deck contains a specific card" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Ace of Hearts")
    refute Cards.contains?(deck, "Ace of Unknown")
  end

  test "deal/2 deals a hand from the deck" do
    deck = Cards.create_deck()
    {hand, remaining_deck} = Cards.deal(deck, 5)
    assert length(hand) == 5
    assert length(remaining_deck) == 47
    assert Enum.all?(hand, fn card -> Enum.member?(deck, card) end)
  end

  test "save/2 saves the deck to a file" do
    deck = Cards.create_deck()
    Cards.save(deck, "files/test_deck")
    assert File.exists?("files/test_deck")
    assert File.read!("files/test_deck") == :erlang.term_to_binary(deck)
  end

  test "load/1 loads a deck from a file" do
    deck = Cards.create_deck()
    Cards.save(deck, "files/test_deck")
    loaded_deck = Cards.load("files/test_deck")
    assert loaded_deck == deck
  end

  test "create_hand/1 creates a hand of specified size" do
    hand_size = 5
    {hand, _left} = Cards.create_hand(hand_size)
    assert length(hand) == hand_size
    assert Enum.all?(hand, fn card -> Enum.member?(Cards.create_deck(), card) end)
  end
end
