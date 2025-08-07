defmodule Identicon do
  @moduledoc """
  This module is used for manipulating image
  """

  def main(input) do
    input
    |> hash
  end

  def hash(input) do
    hashed_input = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hashed_input}
  end
end
