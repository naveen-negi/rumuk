defmodule NotificationsTest do
    use Tak.Case
    alias Tak.Notifications.Notification

    test "should create a notification" do
        id = Tak.Helper.random_key
        category_type = "invitation_request"
        category_fields = %{sender: "rin", content: "hello there, how are you ?"}
        notification = Notification.new(id, category_type, category_fields)

        assert notification.category_type == category_type
        assert notification.id == id
        assert notification.category_fields == category_fields
    end
end