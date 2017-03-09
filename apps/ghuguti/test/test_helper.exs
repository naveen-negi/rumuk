ExUnit.start

defmodule Ghuguti.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit fn ->
      #Riak.Helper.clean! pid
      {:ok, users} = Riak.Bucket.keys("maps", "users") 
       Enum.each(users, fn key -> Riak.delete( "users", key) end)
       {:ok, notifications} = Riak.Bucket.keys("maps", "notifications") 
     Enum.each(notifications, fn key -> Riak.delete( "notifications", key) end)
    end
    end
end

defmodule Ghuguti.Helper do
  def clean!(pid) do
    # This is terrible, and should not be used.
    for bucket <- Riak.Bucket.list!(pid), key <- Riak.Bucket.keys!(pid, bucket) do
      Riak.delete(pid, bucket, key)
    end
  end

  def random_key do
    {me, se, mi} = :erlang.timestamp
    "#{me}#{se}#{mi}"
  end

  # helper for chosing the index of a sibling value list
  def index_of(search, [search|_], index) do
    index
  end
  def index_of(search, [_|rest], index) do
    index_of(search, rest, index+1)
  end
  def index_of(search, haystack) do
    index_of(search, haystack, 1)
  end
end
