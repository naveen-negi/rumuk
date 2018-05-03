defmodule Kafal.ImageClient do

  def img_dir do
    Application.get_env(:kafal, :img_dir)
  end

  def save(user_id, image_id, image_path) do
    user_dir = Path.join([img_dir, user_id])
    IO.inspect user_dir
    File.mkdir_p(user_dir)
    dest_path = Path.join(user_dir, image_id)
    File.cp!(image_path, dest_path)
    {:ok, image_id}
  end
end
