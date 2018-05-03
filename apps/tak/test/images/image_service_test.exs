defmodule Tak.ImageServiceTest do
  use ExUnit.Case
  alias Tak.ImageService
  import Mock

  test "should return ok if image is save" do
    user_id = "rin_1"
    image_id = "rin_1.jpg"
    image_path = "path/to/image"
    with_mock Kafal.ContentHandler, [save: fn(_user, _id, _path) -> {:ok, "somefileName"} end] do
      result = ImageService.save(user_id, image_id, image_path)
      assert result == :ok
    end
  end

  test "should return error if fails to save image" do
    user_id = "rin_1"
    image_id = "rin_1.jpg"
    image_path = "path/to/image"
    with_mock Kafal.ContentHandler, [save: fn(_user, _id, _path) -> {:error, "failure reasons"} end] do
      result = ImageService.save(user_id, image_id, image_path)
      assert result == :error
      end
  end

end
