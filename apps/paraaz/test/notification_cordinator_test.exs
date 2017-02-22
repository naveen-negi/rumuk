defmodule NotificationCordinatorTest do
    use ExUnit.Case
    alias Paraaz.User
    alias Paraaz.Notification
    alias Paraaz.CategoryType.InvitationRequest

    test "should be able to save given notification to a new user" do
        user_id = "subaru_kun"
        clean_up(user_id)
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        ok_response = Paraaz.NotificationCordinator.save(user_id , category_type, category_fields)
       
        assert ok_response == :ok
    end

    test "should be able to append new notification to an existing user" do

        user_id = "father"
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
       
    #    given_that_user_already_exists()

        ok_response = Paraaz.NotificationCordinator.save(user_id , category_type, category_fields)

        assert ok_response == :ok
    end

    test "should return all of the notifications for a user" do
        user_id = "homunculi"
        clean_up(user_id)
       given_that_user_already_exists(user_id)
        
        save_notification(user_id)
        save_notification(user_id)
        save_notification(user_id)

   notifications = Paraaz.NotificationCordinator.get_all_notifications(user_id)
   IO.inspect notifications
   assert length(notifications) == 4
    end

    defp clean_up(user_id) do
        Riak.delete("maps", "users", user_id)
    end

    defp save_notification(user_id) do
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        Paraaz.NotificationCordinator.save(user_id , category_type, category_fields)    
    end

    defp given_that_user_already_exists(user_id) do
     created_notification_id = "full_metal_alchemist"

     User.new(user_id, created_notification_id) 
              |> Riak.update("maps", "users", user_id)

    end
end