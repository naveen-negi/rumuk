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
                |> Map.put("user_id", id)
                |> Map.put("notifications", notifications)
    end

    def register_notification(user, notification_id) do
         user |> Map.update(:set, "notifications", fn set -> set |> Set.put(notification_id) end)
    end

    def get_all_notifications(user) do
         user |> Map.get(:set, "notifications")
    end

    def get_all_notification_ids(user) do
       user_map = user |> Map.value 
       notifications = :orddict.fetch({"notifications", :set}, user_map)
       :ordset.to_list(notifications)
    end

    def get_user_id(user) do
        user_map = user |> Map.value 
       :orddict.fetch({"user_id", :register}, user_map)
    end
end