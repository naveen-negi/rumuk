defmodule Kafal.ContentHandler do
  alias Kafal.ImageClient
  alias Kafal.User
  alias Kafal.RiakRepo
def save(user_id, image_id, image_path) do
    unique_image_id = UUID.uuid1() <> Path.extname(image_id)
    {:ok, image} = ImageClient.save(user_id, unique_image_id, image_path)
    response = RiakRepo.save(user_id, image.id)
    IO.inspect response
    response
  end

  def get(user_id) do
    {:ok, user} = RiakRepo.get(user_id)
    {:ok, user.images}
  end

  def get(user_id, image_id) do
    IO.puts "***** inside get image *******"
    {:ok, user} = RiakRepo.get(user_id)

    case Enum.member?(user.images, image_id) do
      true ->
        IO.puts "****** file retrieved *****"
        ImageClient.get(user_id, image_id)
      false ->
        IO.puts "****** file not found *****"
        {:not_found, "not found"}
    end
  end

  def get_image(user_id, image_id) do
      case ImageClient.get(user_id, image_id) do
        {:ok, image} -> image
        _ -> nil
      end
  end

  def delete(user_id, image_id) do
    case RiakRepo.get(user_id) do
      {:ok, user} ->
                images =
                  user.images
                  |> Enum.filter(fn image -> image != image_id end)

                ImageClient.delete(user_id, image_id)

                user = User.new(user_id, images)
                result = RiakRepo.update(user)
                IO.puts "***** image deleted  *******"
                result
    end
  end

end
