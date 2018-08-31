defmodule NotificationUserTest do
  use Tak.Case
  alias Tak.Notifications.{User, Notification}

  test "should create user" do
    id = Tak.Helper.random_key()
    user = User.new(id)
    assert user.id == id
  end

  test "should add  and retreive notification for the user " do
    id = Tak.Helper.random_key()
    category_type = "invitation_request"
    category_fields = %{sender: "rin", content: "hello there, how are you ?"}

    notification = Notification.new(id, category_type, category_fields)

    user =
      User.new(Tak.Helper.random_key())
      |> User.add_notification(create_notification(id))
      |> User.add_notification(create_notification(Tak.Helper.random_key()))

    assert Enum.count(user.notifications) == 2

    Enum.any?(user.notifications, fn notification ->
      assert notification.category_type == category_type &&
               assert(
                 notification.id == id && assert(notification.category_fields == category_fields)
               )
    end)
  end

  defp create_notification(id) do
    category_type = "invitation_request"
    category_fields = %{sender: "rin", content: "hello there, how are you ?"}
    notification = Notification.new(id, category_type, category_fields)
  end
end
