defmodule Kafal.RiakRepo do
  alias Kafal.User
  alias Riak.CRDT.Map

  def bucket_type do
    Application.get_env(:kafal, :bucket_type)
  end

  def bucket_name do
    Application.get_env(:kafal, :bucket_name)
  end

  def save(user_id, image_id) do
    user = Riak.find(bucket_type, bucket_name, user_id)
    IO.puts "inside riak repo"
    IO.inspect user
    save(user, user_id, image_id)
  end

  def save(user, user_id, image_id) when is_nil(user) do
    user =
      user_id
      |> User.new()
      |> User.add_image(image_id)

    user
    |> Ghuguti.to_crdt()
    |> Riak.update(bucket_type, bucket_name, user_id)

    {:ok, user}
  end

  def save(user, user_id, image_id) do
    riak_user = Riak.find(bucket_type, bucket_name, user_id)

    user =
      riak_user
      |> Map.value()
      |> Ghuguti.to_model(User)
      |> User.add_image(image_id)

    riak_user
    |> Ghuguti.update_crdt([:images, user.images])
    |> Riak.update(bucket_type, bucket_name, user_id)
    {:ok, user}
  end

  def get(user_id) do
   riak_user = Riak.find(bucket_type, bucket_name, user_id)
   user =
     riak_user
     |> Map.value()
     |> Ghuguti.to_model(User)
   {:ok, user}
  end
end
