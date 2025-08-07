defmodule Identicon do
  @moduledoc """
  This module is used for manipulating image
  """

  def main(input) do
    input
    |> hash
  end

  def hash(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end
end
