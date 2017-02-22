defmodule Paraaz.NotificationCordinator do
    alias Paraaz.Notification
    alias Paraaz.User
    alias Riak.CRDT.Map
    
    def save(user_id , category_type, category_fields) do
         
         %{id: notification_id, notification: notification} =
          Notification.new(user_id,category_type, category_fields)

          notification 
          |> Riak.update("maps", "notifications", notification_id)
          
           user = Riak.find("maps", "users", user_id)
          case user do
             nil  ->    User.new(user_id, notification_id) 
                            |> Riak.update("maps", "users", user_id)
                            :ok
               _ ->      user 
                            |>  User.register_notification(notification_id)
                            |> Riak.update("maps", "users", user_id)
                            :ok
           end
    end

    def get_all_notifications(user_id) do 
        user = Riak.find("maps", "users", user_id)
        case user do
            nil -> {:error, notifications: []}
            _   ->    user_map =   user |> Map.value
                      :orddict.fetch({"notifications", :set}, user_map)
                      |> Enum.map(fn x -> Riak.find("maps","notifications", x) end) 
                      |>  Enum.map(&( Map.value &1 )) 
        end
      

    end
    
end