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
    end

end
