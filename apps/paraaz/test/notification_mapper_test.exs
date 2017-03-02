defmodule NotificationMapperTest do
    use ExUnit.Case
    alias Paraaz.Notification
    alias Riak.CRDT.Map
    alias Riak.CRDT.Register
    alias Riak.CRDT.Set
    alias Paraaz.CategoryType.InvitationRequest
    
    import Paraaz.NotificationMapper
    

    test "should be able to convert Notification map crdt into to domain model" do
        user_id = "eren"
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "armin", content: "titans are in city"}
        %{id: notification_id, notification: notification_map} = Notification.new(user_id, category_type, category_fields)
       notification_map |>  Riak.update("maps", "notifications", notification_id)

        notification = Riak.find("maps", "notifications", notification_id) 

       result = to_domain( notification) 
       assert result.user_id == user_id
       assert result.category_type == category_type
       assert %{"sender_id" => "armin", "content" => "titans are in city"} == result.category_fields
       
    end

end