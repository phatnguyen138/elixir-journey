defmodule MyElixirWeb.PageController do
  use MyElixirWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
