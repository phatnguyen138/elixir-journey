defmodule Identicon do
  @moduledoc """
  This module is used for manipulating image
  """

  def main(input) do
    input
    |> hash
    |> pick_color
    |> build_grid
    |> filter_even
    |> build_pixel_map
    |> draw_avatar(input)
  end

  def draw_avatar(%Identicon.Image{pixel_map: pixel_map, color: color} = image, image_name) do
    # Create a 250x250 white canvas
    canvas = create_canvas(250, 250, {255, 255, 255})

    # Fill the pixels with the identicon color
    canvas_with_pixels = Enum.reduce(pixel_map, canvas, fn([{start_x, start_y}, {end_x, end_y}], acc) ->
      fill_rectangle(acc, start_x, start_y, end_x - 1, end_y - 1, List.to_tuple(color))
    end)

    # Save as PPM file
    save_ppm(canvas_with_pixels, "#{image_name}.ppm")

    image
  end

  defp create_canvas(width, height, color) do
    row = List.duplicate(color, width)
    List.duplicate(row, height)
  end

  defp fill_rectangle(canvas, start_x, start_y, end_x, end_y, color) do
    canvas
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      if y >= start_y and y <= end_y do
        row
        |> Enum.with_index()
        |> Enum.map(fn {pixel, x} ->
          if x >= start_x and x <= end_x do
            color
          else
            pixel
          end
        end)
      else
        row
      end
    end)
  end

  defp save_ppm(canvas, filename) do
    height = length(canvas)
    width = length(hd(canvas))

    header = "P3\n#{width} #{height}\n255\n"

    pixel_data = canvas
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn {r, g, b} -> "#{r} #{g} #{b}" end)
      |> Enum.join(" ")
    end)
    |> Enum.join("\n")

    File.write!(filename, header <> pixel_data <> "\n")
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn {_numb, index} ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      [top_left, bottom_right]
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_even(%Identicon.Image{grid: grid} = image) do
    new_grid = Enum.filter grid, fn({numb, _index}) ->
      rem(numb,2) == 0
    end
    %Identicon.Image{image | grid: new_grid}
  end

  def build_grid(%Identicon.Image{hex: hex, color: _color} = image) do
    grid = hex
    |> Enum.chunk_every(3,3,:discard)
    |> Enum.map(&Identicon.mirror/1)
    |> List.flatten
    |> Enum.with_index

    %Identicon.Image{image | grid: grid}
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
