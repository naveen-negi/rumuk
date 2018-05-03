defmodule Kafal.ImageClient do
  def img_dir do
    Application.get_env(:kafal, :img_dir)
  end

  def save(user_id, image_id, image_path) do
    image_path = Path.join([img_dir, user_id, image_id])
    File.mkdir_p(image_path)
    File.touch!(image_path)
    {:ok, image_id}
  end
end
