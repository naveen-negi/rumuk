defmodule Tak.ImageController do
  use Tak.Web, :controller
  alias Tak.ImageService

  def upload(conn, %{"image" => image, "user_id" => user_id} = params) do
    case ImageService.save(user_id, image.filename, image.path) do
      :ok -> conn
              |> send_resp(201, "")
      :error -> conn
                |> send_resp(500, "failed to save image")
    end
  end

end
