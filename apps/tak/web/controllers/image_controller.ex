defmodule Tak.ImageController do
  use Tak.Web, :controller
  alias Tak.ImageService
  alias Tak.Images.User

  def upload(conn, %{"image" => image, "user_id" => user_id} = params) do
    IO.inspect params
    case ImageService.save(user_id, image.filename, image.path) do
      :ok -> conn
              |> send_resp(201, "")
      :error -> conn
                |> send_resp(500, "failed to save image")
    end
  end

  def get(conn, params) do
    user_id = params["user_id"]
    image_id = params["image_id"]
    case ImageService.get(user_id, image_id) do
      {:ok, image} ->
        conn
        |> put_resp_content_type("application/octet-stream", nil)
        |> put_resp_header("content-disposition", ~s[attachment; filename=#{image.id}])
        |> send_file(200, image.path)
      _ -> conn
      |> send_resp(404, "not found")
    end
  end

  def get_all(conn, params) do
    user_id = params["user_id"]
    {:ok, image_ids} = ImageService.get(user_id)
    # image_ds = Enum.map(images, &(&1.id))
    user = User.new(user_id, image_ids)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(user))
  end

  def delete(conn, params) do
    user_id = params["user_id"]
    image_id = params["image_id"]
    case ImageService.delete(user_id, image_id) do
      {:ok, user} -> conn
      |> send_resp(200, "sucessfully deleted image")
    end
  end


end
