defmodule Kafal.ImageClientTest do
  use ExUnit.Case
  alias Kafal.ImageClient

  test "should save image for given user " do
    {:ok, img_dir} = Briefly.create(directory: true)
    Application.put_env(:kafal, :img_dir, img_dir)
    user_id = "rin_1"
    image_id = "rin_1.jpg"
    image_path = "rin_1.jpg"
    result = ImageClient.save(user_id, image_id, image_path)

    expected_image_path = Path.join([ImageClient.img_dir(), user_id, image_id])
    assert result == {:ok, image_id}
    assert File.exists?(expected_image_path)
  end
end
