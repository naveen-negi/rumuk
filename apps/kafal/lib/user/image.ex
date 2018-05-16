defmodule Kafal.Image do

  defstruct [id: nil, path: nil]

  def new(id, path) do
    %Kafal.Image{id: id, path: path}
  end
end
