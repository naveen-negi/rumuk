defmodule Tak.NotificationControllerTest do
  use Tak.ConnCase
  alias Tak.Notifications.Notification
  alias Tak.Notifications.User
  @moduletag :notifications

  # setup do
  #     # {:ok, pid} = Tak.NotificationServer.start_link(Tak.NotificationServer)
  #     # {:ok, server: pid}

  #     # on_exit fn ->
  #     #     GenServer.stop(pid)
  #     #     end
  # end

  test "should save notification for the given user", %{conn: conn} do
    notification_type = Tak.Notifications.CategoryType.InvitationRequest.type()
    category_fields = %{sender_id: "archer"}

    conn =
      post(build_conn, "api/users/rin/notifications", %{
        category_type: notification_type.value,
        category_fields: category_fields
      })

    assert conn.status == 204
  end

  test "should get notifications for the given user", %{conn: conn} do
    given_that_notifications_exists_for_user("rin")
    conn = get(build_conn, "api/users/rin/notifications")
    user = Poison.decode!(conn.resp_body, as: %Tak.Notifications.User{})
    assert user.id == "rin"
    assert conn.status == 200
  end

  #    test "should return not found for non existent user" do
  #           response = get build_conn, "api/users/unknow/notifications" 
  #           assert response.status == 404
  #      end

  def given_that_notifications_exists_for_user(user_id) do
    notification_type = Tak.Notifications.CategoryType.InvitationRequest.type()
    category_fields = %{sender_id: "Lancter"}
    #  user = User.new(user_id)
    #             |> User.add_notification(Notification.new(Tak.Helper.random_key,notification_type, category_fields ))
    #             |> User.add_notification(Notification.new(Tak.Helper.random_key,notification_type, category_fields ))

    notification_type = Tak.Notifications.CategoryType.InvitationRequest.type()
    category_fields = %{sender_id: "archer"}

    conn =
      post(build_conn, "api/users/" <> user_id <> "/notifications", %{
        category_type: notification_type.value,
        category_fields: category_fields
      })
  end

  defp save() do
    notification_type = Tak.CategoryType.InvitationRequest.type()
    category_fields = %{sender_id: "Lancter"}

    post(conn, "api/users/rin/notifications", %{
      category_type: notification_type.value,
      category_fields: category_fields
    })
  end
end
