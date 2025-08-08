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

  def build_grid(%Identicon.Image{hex: hex, color: color} = image) do
    hex
    |> Enum.chunk_every(3,3,:discard)
    |> Enum.map(&mirror_row/1)
  end

  def mirror_row(row) do
    [first, second | rest_] = row
    row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [r, b, g | _rest]} = image) do
    %Identicon.Image{image | color: [r,b,g]}
  end

  def hash(input) do
    hashed_input = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hashed_input}
  end
end
