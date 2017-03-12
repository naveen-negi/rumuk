defmodule UserMapperTest do
    use Ghuguti.Case
    alias Paraaz.UserMapper
    alias Paraaz.User
    alias Paraaz.CategoryType.InvitationRequest

   defp clean_up(user_id) do
         Riak.delete("maps", "users", user_id)
    end

    test "should map User to domain model" do
         user_id = "kanbeneri"
        clean_up(user_id)
        save_notification(user_id)
        save_notification(user_id)
        save_notification(user_id)
        notifications = Paraaz.NotificationService.get_all_notifications(user_id)
         result = UserMapper.to_domain(user_id, notifications)

         assert result.user_id == user_id
         assert length(result.notifications) == 3

         result.notifications |> Enum.each fn x -> 
            assert x.user_id == user_id && x.category_type == InvitationRequest.type.value
             && x.category_fields == %{"sender_id" => "rin"}
             end
        end

    defp save_notification(user_id) do
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        Paraaz.NotificationService.save(user_id , category_type, category_fields)    
    end
end