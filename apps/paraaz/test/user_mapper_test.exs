defmodule UserMapperTest do
    use ExUnit.Case
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

        user = Riak.find("maps", "users", user_id)
        
         result = UserMapper.to_domain(user)

         assert result.user_id == user_id
         assert length(result.notifications) == 3
        IO.inspect result
         result.notifications |> Enum.each fn x -> 
            assert x.user_id == user_id && x.category_type == InvitationRequest.type.value
             && x.category_fields == %{"sender_id" => "rin"}
             end
        end

    defp save_notification(user_id) do
        category_type = InvitationRequest.type.value
        category_fields = %{sender_id: "rin"}
        Paraaz.NotificationCordinator.save(user_id , category_type, category_fields)    
    end
end