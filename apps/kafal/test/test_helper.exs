ExUnit.start()

defmodule Tak.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit(fn ->
      {:ok, users} = Riak.Bucket.keys("test-media", "test-media")
      Enum.each(users, fn key -> Riak.delete("test-media", "test-media", key) end)
    end)
  end
end

defmodule Tak.Helper do
  def clean!(pid) do
    # This is terrible, and should not be used.
    for bucket <- Riak.Bucket.list!(pid),
        key <- Riak.Bucket.keys!(pid, bucket) do
      Riak.delete(pid, bucket, key)
    end
  end

  def random_key do
    {me, se, mi} = :erlang.timestamp()
    "#{me}#{se}#{mi}"
  end
end
