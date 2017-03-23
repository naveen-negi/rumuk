ExUnit.start

defmodule Bhaduli.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit fn ->
      #Riak.Helper.clean! pid
      {:ok, users} = Riak.Bucket.keys("maps", "users") 
       Enum.each(users, fn key -> Riak.delete("maps", "users", key) end)
      
       {:ok, notifications} = Riak.Bucket.keys("maps", "notifications") 
      Enum.each(notifications, fn key -> Riak.delete("maps", "notifications", key) end)
    end
    end
end

defmodule Bhaduli.Helper do
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
end
