defmodule UserTest do
  use Paraaz.Case
  alias Riak
  alias Paraaz.Domain.User
  alias Riak.CRDT.Map
  alias Riak.CRDT.Register
  alias Riak.CRDT.Flag

test "user should be able to save and retreive notifications" do
    created_notification_id = "full_metal_alchemist"
     sender_id = "wrath"
     user_id = "Erin1"
   message_received_notification_id = "wrath_message"
     
              User.new(user_id) 
              |> User.add_notification(created_notification_id) 
              |> User.add_notification(message_received_notification_id) 
              |> Ghuguti.to_crdt
              |> Riak.update("maps", "notification_users", user_id)
     
      user_map = Riak.find("maps", "notification_users", user_id) |> Map.value
      map_keys = :orddict.fetch_keys(user_map)
    
      assert {"user_id", :register} in map_keys
      assert {"notifications", :set} in map_keys

      
     assert  :orddict.fetch({"user_id", :register}, user_map) == user_id
      notifications_set = :orddict.fetch({"notifications", :set}, user_map)

     assert created_notification_id in  notifications_set
     assert message_received_notification_id in  notifications_set
  end

# test "should get all notifications from user" do
   
#    created_notification_id = "mustang activated"
#      sender_id = "envy"
#      user_id = "mustang"
#      User.new(user_id) 
#      |> User.add_notification(created_notification_id)
#      |> Ghuguti.to_crdt
#     |> Riak.update("maps", "notification_users", user_id)
     
#      user = Riak.find("maps", "notification_users", user_id)

#    envy_notification_id = "envy_message"
    
#     User.register_notification(user, envy_notification_id)
#               |>  Riak.update("maps", "users", user_id)
 
#     updated_user = Riak.find("maps", "users", user_id) 

#     notifications = updated_user |> User.get_all_notifications

#      assert created_notification_id in  notifications
#      assert envy_notification_id in  notifications
# end
end