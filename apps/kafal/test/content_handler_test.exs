defmodule Kafal.ContentHandlerTest do
  use ExUnit.Case
  alias Kafal.ImageClient
  alias Kafal.ContentHandler
  alias Kafal.User
  alias Kafal.RiakRepo
  import Mock

  test "should be able to save user with image name in Riak" do
    user_id = "rin"
    image_id = "image_1.jpg"
    image_path = "path/to/image"
    image_file_name = "image_file_name"
    user = User.new(user_id)

    with_mock ImageClient, save: fn _user, _id, _path -> {:ok, image_file_name} end do
      with_mock RiakRepo, save: fn user_id, image_id -> {:ok, user} end do
        response = ContentHandler.save(user_id, image_id, image_path)
        assert response == {:ok, user}
      end
    end
  end

  test "should return error on when image is not save for user on file system" do
    user_id = "rin"
    image_id = "image_1.jpg"
    image_path = "path/to/image"
    image_file_name = "image_file_name"
    user = User.new(user_id)

    with_mock ImageClient, save: fn _user, _id, _path -> {:error, "reasons"} end do
      with_mock RiakRepo, save: fn user_id, image_id -> {:ok, user} end do
        response = ContentHandler.save(user_id, image_id, image_path)
        assert response == {:error, "reasons"}
      end
    end
  end

end
