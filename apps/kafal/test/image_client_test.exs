defmodule Kafal.ImageClientTest do
  use ExUnit.Case
  alias Kafal.ImageClient

  @moduletag :imageClient

  test "should save image for given user " do
    {:ok, img_dir} = Briefly.create(directory: true)
    Application.put_env(:kafal, :img_dir, img_dir)
    user_id = "rin_1"
    upload = %Plug.Upload{path: "test/fixtures/image.jpeg", filename: "image.jpeg"}
    result = ImageClient.save(user_id, upload.filename, upload.path)

    expected_image_path = Path.join([ImageClient.img_dir(), user_id, upload.filename])
    assert result == {:ok, upload.filename}
    assert File.exists?(expected_image_path)
  end
end
