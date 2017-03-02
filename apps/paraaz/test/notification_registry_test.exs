defmodule NotificationServiceTest do
    use ExUnit.Case

    setup do
        {:ok, pid} = Paraaz.NotificationRegistry.start_link
        {:ok, pid: pid}
    end

    test "should be able to create a user", %{pid: pid} do
        user_id = "Archer"
        clean_up(user_id)
        category_type = Paraaz.CategoryType.MessageReceived.type.value
        category_fields = %{"sender_id"=> "Saber", "content"=> "Rin has called for a fight"}
        Paraaz.NotificationService.save(pid, user_id, category_type, category_fields)

        archer = Paraaz.NotificationService.lookup(pid, user_id)
        IO.inspect archer.notifications
        assert archer.user_id == user_id
        assert Enum.any? archer.notifications, fn x -> x.category_type==category_type
                                                    && x.category_fields==category_fields
                                                    end
    end

    def clean_up(user_id) do
        Riak.delete("maps", "users", user_id)
    end
end