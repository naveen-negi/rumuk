defmodule NotificationTest do
  use ExUnit.Case
  alias Riak.CRDT.Map
  alias Riak.CRDT.Register
  alias Riak.CRDT.Flag
  doctest Paraaz

  # test "should be able to save  and retrieve a notification" do
  #   belongs_to = "naveen"
  #   type = "request_received"
  #   id = belongs_to <> "_" <> type <> "_3";
  #   sender = "sender_id_1"
  #   category = Paraaz.InvitationCategory.new(sender)

  #   notification = Paraaz.Notification.new(belongs_to, type, id, category)
    
    
    
  #   notification |> Riak.update("maps", "notifications", id, category)

  #   map = Riak.find("maps", "notifications", id) |> Map.value
    
  #   IO.inspect map
  #   assert :orddict.size(map) == 3
  
  # map_keys = :orddict.fetch_keys(map)
  # IO.puts "keys"
  # IO.inspect map_keys
  #   assert {"user", :register} in map_keys
  #   assert {"category", :register} in map_keys
  #   assert {"notification-id", :register} in map_keys

  #   data = :orddict.to_list(map)
  #   IO.puts "data"
  #   IO.inspect data
  #   assert {{"user", :register}, "naveen"} in data
  #   assert {{"category", :register}, "request_received"} in data
  #   assert {{"notification-id", :register}, id} in data
  # end

defp clean_up(id) do
Riak.delete("maps", "notifications", id)
end

  # test "should contain category fields for for invitation request" do
  #   belongs_to = "naveen"
  #   type = "invitation_request"
  #   id = belongs_to <> "_" <> type <> "_4";
  #   clean_up(id)
   
  #   sender = "sender_id_1"
  #   category = Paraaz.InvitationCategory.new(sender)
  #   IO.inspect category

  #   notification = Paraaz.Notification.new(belongs_to, type, id, category)

  #  notification |> Riak.update("maps", "notifications", id)

  #   map = Riak.find("maps", "notifications", id) |> Map.value
    
  #   IO.inspect map
  #   assert :orddict.size(map) == 4
  
  # map_keys = :orddict.fetch_keys(map)
  
  # IO.puts "keys"
  # IO.inspect map_keys
  # IO.puts "==========================================="
  #   assert {"user-id", :register} in map_keys
  #   assert {"category-type", :register} in map_keys
  #   assert {"notification-id", :register} in map_keys
  #   assert {"category-fields", :map} in map_keys

  #   data = :orddict.to_list(map)
  #   IO.puts "data"
  #   IO.inspect data
  #   IO.puts "==========================================="
  #   assert {{"user-id", :register}, "naveen"} in data
  #   assert {{"category-type", :register}, type} in data
  #   assert {{"notification-id", :register}, id} in data
    
  #     nested_map = :orddict.fetch({"category-fields", :map}, map)
  #     sender_id = :orddict.fetch({"sender-id", :register}, nested_map)

  #     assert sender_id == "sender_id_1"
  # end

  test "should create and save request declined notification" do
     belongs_to = "naveen"
    category_type  = "invitation_declined"
   
    sender = "sender_id_1"
    category_fields = %{sender: "user_1"}

    %{id: id, notification: notification} = Paraaz.Notification.new(:declined, belongs_to, category_type, category_fields)

    notification |> Riak.update("maps", "notifications", id)

    map = Riak.find("maps", "notifications", id) |> Map.value
    
    IO.inspect map

     assert :orddict.size(map) == 4
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
