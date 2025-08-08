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
    |> Enum.chunk(3)
  end

  def pick_color(%Identicon.Image{hex: hex} = image) do
    [r, b, g | _rest] = hex

    %Identicon.Image{image | color: [r,b,g]}
  end

  def hash(input) do
    hashed_input = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hashed_input}
  end
end
