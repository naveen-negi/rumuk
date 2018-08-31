ExUnit.start()

defmodule Paraaz.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit(fn ->
      # Riak.Helper.clean! pid
      {:ok, notifications} = Riak.Bucket.keys("test-notifications", "test-notifications")

      Enum.each(notifications, fn key ->
        Riak.delete("test-notifications", "test-notifications", key)
      end)

      Enum.each(notifications, fn key ->
        Riak.find("test-notifications", "test-notifications", key)
      end)

      {:ok, keys} = Riak.Bucket.keys("test-notification-users", "test-notification-users")

      Enum.each(keys, fn key ->
        Riak.delete("test-notification-users", "test-notification-users", key)
      end)

      Enum.each(keys, fn key ->
        Riak.find("test-notifications-users", "test-notification_users", key)
      end)
    end)
  end
end

defmodule Ghuguti.Helper do
  def random_key do
    {me, se, mi} = :erlang.timestamp()
    "#{me}#{se}#{mi}"
  end
end
