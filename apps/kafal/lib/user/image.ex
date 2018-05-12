defmodule Kafal.Image do

  defstruct [id: nil, path: nil]

  def new(id, path) do
    %Kafal.Image{id: id, path: path}
  end

  defimpl Poison.Encoder, for: Person do
    def encode(%{name: name, age: age}, options) do
      Poison.Encoder.BitString.encode("#{name} (#{age})", options)
    end
  end

end
