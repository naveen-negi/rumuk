ExUnit.start

defmodule Paraaz.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit fn ->
      # Riak.Helper.clean! pid
       {:ok, notifications} = Riak.Bucket.keys("maps", "notifications") 
     Enum.each(notifications, fn key -> Riak.delete("maps", "notifications", key) end)
     Enum.each(notifications, fn key -> Riak.find("maps", "notifications", key) end)

       {:ok, keys} = Riak.Bucket.keys("maps", "notification_users") 
       Enum.each(keys, fn key -> Riak.delete("maps", "notification_users", key) end)
       Enum.each(keys, fn key -> Riak.find("maps", "notification_users", key) end)
     
    end
    end
end

defmodule Ghuguti.Helper do
  def random_key do
    {me, se, mi} = :erlang.timestamp
    "#{me}#{se}#{mi}"
  end
end
