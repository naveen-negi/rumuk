defmodule NotificationServiceTest do
    use Paraaz.Case
    alias Paraaz.User
    alias Paraaz.Notification
    alias Paraaz.CategoryType.InvitationRequest

    defp clean_up(user_id) do
         Riak.delete("maps", "users", user_id)
    end
 
    test "should be able to save given notification to a new user" do
        user_id = "subaru_kun"
        clean_up(user_id)
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        ok_response = Paraaz.NotificationService.save(user_id , category_type, category_fields)
       
        assert ok_response == :ok
        clean_up(user_id)
    end

    test "should be able to append new notification to an existing user" do
        user_id = "father"
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        ok_response = Paraaz.NotificationService.save(user_id , category_type, category_fields)
        assert ok_response == :ok
    end

    test "should return all of the notifications for a user" do
        user_id = "homunculi"
        response = save_notification(user_id)
        assert response == :ok
        response = save_notification(user_id)
        assert response == :ok
        response = save_notification(user_id)
        assert response == :ok

        notifications = Paraaz.NotificationService.get_all_notifications(user_id)
        assert length(notifications) == 3
        Enum.each(notifications, fn(x) -> assert x.category_type == InvitationRequest.type.value &&
                                          assert x.category_fields == %{sender_id: "rin"} 
                                        end) 

    end
   
    defp save_notification(user_id) do
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        Paraaz.NotificationService.save(user_id , category_type, category_fields)    
    end
end