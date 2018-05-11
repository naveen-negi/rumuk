defmodule Kafal.ImageClient do
  alias Kafal.Image

  def img_dir do
    Application.get_env(:kafal, :img_dir)
  end

  def save(user_id, image_id, image_path) do
    user_dir = Path.join([img_dir, user_id])
    File.mkdir_p(user_dir)
    dest_path = Path.join(user_dir, image_id)
    File.cp!(image_path, dest_path)
    image = Image.new(image_id, dest_path)
    {:ok, image}
  end

  def get(user_id, image_id) do
    user_dir = Path.join([img_dir, user_id])
    dest_path = Path.join(user_dir, image_id)
    image = Kafal.Image.new(image_id, dest_path)
    {:ok, image}
  end
end
