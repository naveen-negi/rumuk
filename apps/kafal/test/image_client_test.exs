defmodule Kafal.ImageClientTest do use ExUnit.Case
  alias Kafal.ImageClient

  @moduletag :imageClient

  test "should save image for given user " do
    user_id = "rin_1"
    upload =  get_image()
    result = ImageClient.save(user_id, upload.filename, upload.path)

    expected_image_path = Path.join([ImageClient.img_dir(), user_id, upload.filename])
    expected_image = Kafal.Image.new(upload.filename, expected_image_path)
    assert result == {:ok, expected_image}
    assert File.exists?(expected_image_path)
  end

  test "should retrieve saved image for user" do
    upload = get_image()
    user_id = "rin_1"
    expected_image_path = Path.join([ImageClient.img_dir(), user_id, upload.filename])

    result = ImageClient.save(user_id, upload.filename, upload.path)
    {:ok, image} = ImageClient.get(user_id, upload.filename)
    assert image.path == expected_image_path
  end

  test "should be able to delete image for given user and id" do
    upload = get_image()
    user_id = "rin_1"
    expected_image_path = Path.join([ImageClient.img_dir(), user_id, upload.filename])
    ImageClient.save(user_id, upload.filename, upload.path)

    response = ImageClient.delete(user_id, upload.filename) 
    assert response == :ok
    assert false == File.exists?(expected_image_path)
  end

  defp get_image do
    {:ok, img_dir} = Briefly.create(directory: true)
    Application.put_env(:kafal, :img_dir, img_dir)
    upload = %Plug.Upload{path: "test/fixtures/image.jpeg", filename: "image.jpeg"}
  end

end
