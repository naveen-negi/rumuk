defmodule Tak.ImageService do
  alias Kafal.ContentHandler
  alias Kafal.Image

  def save(user_id, image_id, image_path) do
    IO.puts "inside image service ... save ****************"
    ContentHandler.save(user_id, image_id, image_path)
    :ok
    end

  def get(user_id, image_id) do
    ContentHandler.get(user_id, image_id)
  end

  def get(user_id) do
    ContentHandler.get(user_id)
  end

end
