defmodule Tak.ImageControllerTest do
  use Tak.ConnCase
  alias Tak.ImageService
  require Plug
 @moduletag :images

  import Mock

  setup_all do
    on_exit fn ->
      File.rm_rf!(Path.join(File.cwd!, "test-media-dir"))
    end
  end

    test "should be able to save user image" do
      user_id = Tak.Helper.random_key
      image_id = "image.jpg"
      upload = %Plug.Upload{path: "test/fixtures/image.jpeg", filename: "image.jpeg"}
      conn = conn() |> post("api/users/#{user_id}/images", %{:image => upload})
      conn.status == 201
    end

    test "should be able to get all user image ids" do
      user_id = Tak.Helper.random_key
      image_id = "image.jpg"
      upload = %Plug.Upload{path: "test/fixtures/image.jpeg", filename: "image.jpeg"}
      conn = conn() |> post("api/users/#{user_id}/images", %{:image => upload})
      conn = get build_conn, "api/users/#{user_id}/images"
      assert conn.status == 200 
       %{"images" => images} = Poison.decode!(conn.resp_body)
       assert images != nil
    end

    test "should be able to get user image by image id" do
      user_id = "rin"
      image = Kafal.Image.new("image_id", "test/fixtures/image.jpeg")
      with_mock ImageService, [get: fn (user_id, image_id) -> {:ok, image} end] do
        conn = get build_conn, "api/users/#{user_id}/images/image_id"
        assert conn.status == 200 
      end
    end

    test "should be able to delete image for given id" do
      user_id = Tak.Helper.random_key
      image_id = "image.jpg"
      with_mock ImageService, [delete: fn(user_id, image_id) -> :ok end] do
        conn = delete build_conn, "api/users/#{user_id}/images/#{image_id}"
        assert conn.status == 200 
      end
    end
end
