defmodule Identicon do
  @moduledoc """
  This module is used for manipulating image
  """

  def main(input) do
    input
    |> hash
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex, color: _color} = _image) do
    hex
    |> Enum.chunk_every(3,3,:discard)
    |> Enum.map(&Identicon.mirror/1)
  end

  def mirror(row) do
    [first, second | _left] = row
    row ++ [second, first]
  end

  @doc """
  Use for pick RBG color from hex list
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _rest]} = image) do
    %Identicon.Image{image | color: [r, g, b]}
  end


  @doc """
  This function return a struct of image struct with hex list from a string

  ## Example
      iex> Identicon.hash("string")
  """
  def hash(input) do
    hashed_input = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hashed_input}
  end
end
