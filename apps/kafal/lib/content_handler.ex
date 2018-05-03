defmodule Kafal.ContentHandler do
  alias Kafal.ImageClient
  alias Kafal.User
  alias Kafal.RiakRepo

  def save(user_id, image_id, image_path) do
    unique_image_id = UUID.uuid1()
    ImageClient.save(user_id, unique_image_id, image_path)
    RiakRepo.save(user_id, unique_image_id)
  end
end
