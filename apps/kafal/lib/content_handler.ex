defmodule Kafal.ContentHandler do
  alias Kafal.ImageClient
  alias Kafal.User
  alias Kafal.RiakRepo

  def save(user_id, image_id, image_path) do
    unique_image_id = UUID.uuid1() <> Path.extname(image_path)
    {:ok, image} = ImageClient.save(user_id, unique_image_id, image_path)
    RiakRepo.save(user_id, image.id)
  end

  def get(user_id) do
    {:ok, user} = RiakRepo.get(user_id)
    images = Enum.map(user.images, fn image_id -> get_image(user.user_id, image_id) end)
    {:ok, images}
  end

  def get(user_id, image_id) do
    ImageClient.get(user_id, image_id)
  end

  def get_image(user_id, image_id) do
    {:ok, image} = ImageClient.get(user_id, image_id)
    image
  end

end
