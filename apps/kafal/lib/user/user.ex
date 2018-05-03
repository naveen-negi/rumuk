defmodule Kafal.User do
  defstruct user_id: nil, images: []

  def new(user_id) do
    %Kafal.User{user_id: user_id}
  end

  def add_image(user, image_id) do
    images = user.images ++ [image_id]
    user = %Kafal.User{user | images: images}
    user
  end
end
