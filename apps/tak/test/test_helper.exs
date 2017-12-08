ExUnit.start

defmodule Tak.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit fn ->
      
      {:ok, users} = Riak.Bucket.keys("maps", "test-users") 
       Enum.each(users, fn key -> Riak.delete("maps", "test-users", key) end)
       Enum.each(users, fn key -> Riak.find("maps", "test-users", key) end)
      
       Enum.each(users, fn key -> Riak.delete("maps", "test-notification_users", key) end)
       Enum.each(users, fn key -> Riak.delete("maps", "test-notification_users", key) end)
       Enum.each(users, fn key -> Riak.delete("maps", "test-notification_users", key) end)
       Enum.each(users, fn key -> Riak.find("maps", "test-notification_users", key) end)
      
      {:ok, notifications} = Riak.Bucket.keys("maps", "test-notifications") 
      Enum.each(notifications, fn key -> Riak.delete("maps", "test-notifications", key) end)
      Enum.each(notifications, fn key -> Riak.find("maps", "test-notifications", key) end)
     end
    end
end

defmodule Tak.Helper do
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
