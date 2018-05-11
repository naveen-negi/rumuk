defmodule Kafal.ContentHandlerTest do
  use ExUnit.Case
  alias Kafal.ImageClient
  alias Kafal.ContentHandler
  alias Kafal.User
  alias Kafal.RiakRepo
  alias Kafal.Image
  import Mock

  @moduletag :contentHandler

  test "should be able to save user with image id in Riak" do
    user_id = "rin"
    image_id = "image_1.jpg"
    image_path = "path/to/image"
    image_file_name = "image_file_name"
    user = User.new(user_id)
    image = Image.new(image_id, image_path)

    with_mock ImageClient, save: fn _user, _id, _path -> {:ok, image} end do
      with_mock RiakRepo, save: fn user_id, image_id -> {:ok, user} end do
        response = ContentHandler.save(user_id, image_id, image_path)
        assert response == {:ok, user}
      end
    end
  end

  test "should get all images" do
    user_id = "rin"
    image_id = "image_1.jpg"
    image_path = "path/to/image"
    image = Kafal.Image.new(image_id, image_path)

    user = User.new(user_id)
    |> User.add_image(image_id)

    with_mock RiakRepo, get: fn user_id -> {:ok, user} end do
    with_mock ImageClient, get: fn (_user, _image) -> {:ok, image} end do
      response = ContentHandler.get(user_id)
      {:ok, images} = response
        assert images != nil 
      end
    end
  end

end
