defmodule Tak.ImageService do
  alias Kafal.ContentHandler

  def save(user_id, image_id, image_path) do
    ContentHandler.save(user_id, image_id, image_path)
    :ok
    end

end
