defmodule UserTest do
  use ExUnit.Case
  alias Riak
  alias Paraaz.User
  alias Riak.CRDT.Map
  alias Riak.CRDT.Register
  alias Riak.CRDT.Flag


test "should be able to create and save user in db" do
    user_id = "rin_1234"
    notification_id = "rin_1234_user_activated"

                   User.new(user_id, notification_id)
                   |> Riak.update("maps", "users", user_id) 

    user_map = Riak.find("maps", "users", user_id)
                |> Map.value

     map_keys = :orddict.fetch_keys(user_map)
    
      assert {"user-id", :register} in map_keys
      assert {"notifications", :set} in map_keys

    data = :orddict.to_list(user_map)

     assert  :orddict.fetch({"user-id", :register}, user_map) == user_id
      notifications_set = :orddict.fetch({"notifications", :set}, user_map)

     assert notification_id in  notifications_set
end

test "user should be able to save and retreive notification" do
    
    created_notification_id = "full_metal_alchemist"
     sender_id = "wrath"
     user_id = "Erin"
     User.new(user_id, created_notification_id) 
              |> Riak.update("maps", "users", user_id)
     
     user = Riak.find("maps", "users", user_id)

   message_received_notification_id = "wrath_message"
    
    User.register_notification(user, message_received_notification_id)
              |>  Riak.update("maps", "users", user_id)
 
    user_map = Riak.find("maps", "users", user_id) |> Map.value

     map_keys = :orddict.fetch_keys(user_map)
    
      assert {"user-id", :register} in map_keys
      assert {"notifications", :set} in map_keys

      
     assert  :orddict.fetch({"user-id", :register}, user_map) == user_id
      notifications_set = :orddict.fetch({"notifications", :set}, user_map)

     assert created_notification_id in  notifications_set
     assert message_received_notification_id in  notifications_set
  end

test "should get all notifications from user" do
   
   created_notification_id = "mustang activated"
     sender_id = "envy"
     user_id = "mustang"
     User.new(user_id, created_notification_id) 
              |> Riak.update("maps", "users", user_id)
     
     user = Riak.find("maps", "users", user_id)

   envy_notification_id = "envy_message"
    
    User.register_notification(user, envy_notification_id)
              |>  Riak.update("maps", "users", user_id)
 
    updated_user = Riak.find("maps", "users", user_id) 

    notifications = updated_user |> User.get_all_notifications

     assert created_notification_id in  notifications
     assert envy_notification_id in  notifications
end
end