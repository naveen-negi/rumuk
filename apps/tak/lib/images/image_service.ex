defmodule Tak.ImageService do
  alias Kafal.ContentHandler
  alias Kafal.Image

  def save(user_id, image_id, image_path) do
    ContentHandler.save(user_id, image_id, image_path)
    :ok
  end

  def get(user_id, image_id) do
    ContentHandler.get(user_id, image_id)
  end

  def get(user_id) do
    ContentHandler.get(user_id)
  end

  def delete(user_id, image_id) do
    ContentHandler.delete(user_id, image_id)
  end
end
