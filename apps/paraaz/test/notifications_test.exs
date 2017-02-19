defmodule NotificationTest do
  use ExUnit.Case
  alias Riak.CRDT.Map
  alias Riak.CRDT.Register
  alias Riak.CRDT.Flag

  doctest Paraaz

  test "should be able to create and save a notification" do
    belongs_to = "naveen"
    type = "request_received"
    id = belongs_to <> "_" <> type <> "_3";
    
    notification = Paraaz.Notification.new(belongs_to, type)
    # %{id: value} = notification
    # Map.new
    # |> Map.put("notification", notification)
     notification |> Riak.update("maps", "notifications", id)

    map = Riak.find("maps", "notifications", id) |> Map.value
    
    IO.inspect map
    assert :orddict.size(map) == 2
  
  map_keys = :orddict.fetch_keys(map)
  IO.puts "keys"
  IO.inspect map_keys
    assert {"user", :register} in map_keys
    assert {"category", :register} in map_keys


    data = :orddict.to_list(map)
    IO.puts "data"
    IO.inspect data
    assert {{"user", :register}, "naveen"} in data
    assert {{"category", :register}, "request_received"} in data
  end

  test "basic" do
    register = Register.new("some string")
    flag = Flag.new |> Flag.enable
    Map.new
      |> Map.put("k1", register)
      |> Map.put("k2", flag)
      |> Riak.update("maps", "my_map_bucket", "map_key")

      map = Riak.find("maps", "my_map_bucket", "map_key") |> Map.value
      # IO.inspect map
      assert map != nil
  end
end
