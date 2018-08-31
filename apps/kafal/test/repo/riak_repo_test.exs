defmodule Kafal.RiakRepoTest do
  use ExUnit.Case
  alias Kafal.RiakRepo
  @moduletag :riak

  test "should add image id to a newly created user" do
    image_id = Tak.Helper.random_key()
    user_id = Tak.Helper.random_key()
    {:ok, user} = RiakRepo.save(user_id, image_id)
    assert Enum.member?(user.images, image_id)
  end

  test "should add image id to an existing user" do
    image_id = Tak.Helper.random_key()
    user_id = Tak.Helper.random_key()
    {:ok, user} = RiakRepo.save(user_id, image_id)

    image_id_2 = Tak.Helper.random_key()
    {:ok, user} = RiakRepo.save(user_id, image_id_2)
    assert Enum.member?(user.images, image_id)
    assert Enum.member?(user.images, image_id_2)
  end

  test "should get all images for user" do
    image_id = Tak.Helper.random_key()
    user_id = Tak.Helper.random_key()
    {:ok, user} = RiakRepo.save(user_id, image_id)
    {:ok, user} = RiakRepo.get(user_id)
    assert Enum.member?(user.images, image_id) == true
  end

  test "should delete given image for user" do
    image_id = Tak.Helper.random_key()
    user_id = Tak.Helper.random_key()
    {:ok, user} = RiakRepo.save(user_id, image_id)
    RiakRepo.delete(user_id, image_id)
    {:ok, user} = RiakRepo.get(user_id)
    assert Enum.member?(user.images, image_id) == false
  end
end
