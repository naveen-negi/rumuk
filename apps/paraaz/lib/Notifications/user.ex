defmodule Paraaz.User do
alias Riak
alias Riak.CRDT.Map   
alias Riak.CRDT.Register   
alias Riak.CRDT.Set 
alias Paraaz.Notification

    def new(user_id, notification_id) do
         id = Register.new(user_id)

        notifications = Set.new |> Set.put(notification_id)

                Map.new 
                |> Map.put("user-id", id)
                |> Map.put("notifications", notifications)
    end

    def register_notification(user, notification_id) do
         user |> Map.update(:set, "notifications", fn set -> set |> Set.put(notification_id) end)
    end

    def get_all_notifications(user) do
         user |> Map.get(:set, "notifications")
    end

    def get_all_notification_ids(user_id) do
       user_map = Riak.find("maps", "users", user_id) |> Map.value 
       notifications = :orddict.fetch({"notifications", :set}, user_map)
       :ordset.to_list(notifications)

    #    Enum.reduce notification_list, [], fn x -> Riak.fetch("maps", "notifications", x) |> Map.value end

    end
end