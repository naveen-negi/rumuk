ExUnit.start()

defmodule Ghuguti.Case do
  use ExUnit.CaseTemplate

  setup_all do
    on_exit(fn ->
      {:ok, keys} = Riak.Bucket.keys("maps", "bucketmap")
      Enum.each(keys, fn key -> Riak.delete("maps", "bucketmap", key) end)
      Enum.each(keys, fn key -> Riak.find("maps", "bucketmap", key) end)
    end)
  end
end

defmodule Ghuguti.Helper do
  def random_key do
    {me, se, mi} = :erlang.timestamp()
    "#{me}#{se}#{mi}"
  end
end
