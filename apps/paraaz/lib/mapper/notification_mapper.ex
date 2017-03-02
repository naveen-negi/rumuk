defmodule Paraaz.NotificationMapper do
    alias Riak.CRDT.Map

    def to_domain(notification) do
        
    notification_map = notification |> Map.value
        user_id = :orddict.fetch({"user_id", :register}, notification_map)
        notification_id = :orddict.fetch({"notification_id", :register}, notification_map)
        category_type = :orddict.fetch({"category_type", :register}, notification_map)
        category_fields_map = :orddict.fetch({"category_fields", :map}, notification_map)
        keys = :orddict.fetch_keys(category_fields_map)

         reduced_category_fields = Enum.reduce( keys, %{}, fn(x, acc) -> 
                                    :maps.put(trim_key(x), 
                                    :orddict.fetch(x, category_fields_map), acc) end)
        notification = Paraaz.Domain.Notification.new(user_id, notification_id, category_type,reduced_category_fields)

        
    end

    def trim_key(key) do
       case key do
           {value, :register} -> value
           {value, :map} -> value
           {value, :set} -> value
       end 
    end

end