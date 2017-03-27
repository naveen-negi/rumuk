defmodule Paraaz.NotificationService do
    alias Paraaz.Notification
    alias Paraaz.User
    alias Riak.CRDT.Map
    alias Ghuguti
    alias Paraaz.NotificationMapper

    @bucket_type "maps"
    @bucket_name "notifications"

    def save(user_id , category_type, category_fields) do
         %{id: notification_id, notification: notification} =
          Notification.new(user_id, category_type, category_fields)

          notification
          |> Riak.update("maps", "notifications", notification_id)
           user = Riak.find("maps", "notification_users", user_id)
         
         result =  case user do
                    nil  ->    User.new(user_id, notification_id) 
                                    |> Riak.update("maps", "notification_users", user_id)
                    _ ->      user 
                                    |>  User.register_notification(notification_id)
                                    |> Riak.update("maps", "notification_users", user_id)
                   end
    end

    def get_all_notifications(user_id) do 
        user = Riak.find("maps", "notification_users", user_id)
        case user do
            nil -> {:error, notifications: []}
            _   ->    user_map =   user |> Map.value
                      :orddict.fetch({"notifications", :set}, user_map)
                      |> Enum.map(fn x -> Riak.find("maps","notifications", x) end) 
                      |> Enum.filter(fn x -> !is_nil(x) end)
                      |> Enum.map(fn x -> NotificationMapper.to_domain(x) end)
            end
        end

        def get_user(user_id) do
            notification = get_all_notifications(user_id)
            
            case notification do
                {:error, notifications: []} -> {:error, "user not found"}
                _ -> user = Paraaz.UserMapper.to_domain(user_id, get_all_notifications(user_id))
                    {:ok, user}
            end
        end
end