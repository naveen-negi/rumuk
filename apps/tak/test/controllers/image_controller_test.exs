defmodule Tak.ImageControllerTest do
  use Tak.ConnCase
  alias Tak.ImageService
  require Plug
 @moduletag :images
  import Mock

    test "should be able to save image for given user" do
      user_id = Tak.Helper.random_key
      upload = %Plug.Upload{path: "test/fixtures/image.jpg", filename: "image.jpg"}
      with_mock ImageService, [save: fn(_user, _id, _path) -> :ok end] do
      conn = conn() |> post("api/users/#{user_id}/images", %{:image => upload})
      assert conn.status == 201
      end

end
