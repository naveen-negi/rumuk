ExUnit.start

defmodule Tak.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit fn ->
      {:ok, users} = Riak.Bucket.keys("test-users", "test-users") 
       Enum.each(users, fn key -> Riak.delete("test-users", "test-users", key) end)
       Enum.each(users, fn key -> Riak.find("test-users", "test-users", key) end)
       Enum.each(users, fn key -> Riak.delete("test-notification_users", "test-notification_users", key) end)
       Enum.each(users, fn key -> Riak.delete("test-notification-users", "test-notification-users", key) end)
       Enum.each(users, fn key -> Riak.delete("test-notification-users", "test-notification-users", key) end)
       Enum.each(users, fn key -> Riak.find("test-notification-users", "test-notification-users", key) end)
      {:ok, notifications} = Riak.Bucket.keys("test-notifications", "test-notifications") 
      Enum.each(notifications, fn key -> Riak.delete("test-notifications", "test-notifications", key) end)
      Enum.each(notifications, fn key -> Riak.find("test-notifications", "test-notifications", key) end)
      IO.puts "current working dir"
      IO.inspect File.cwd!
      IO.puts "******************************"
      File.rmdir("test-media_dir")
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
