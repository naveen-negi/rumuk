defmodule NotificationserverTest do
  use Tak.Case
  alias Tak.Notifications.{User, Notification}
  alias Tak.NotificationServer

  @moduletag :notification_server
  # setup do
  # {:ok, server} = NotificationServer.start_link

  # on_exit fn -> 
  #                 GenServer.stop(server)
  #         end   
  # {:ok, process: server} 
  # end

  test "should be able to create  user notifications" do
    user_id = Tak.Helper.random_key()

    user =
      User.new(user_id)
      |> User.add_notification(create_notification(Tak.Helper.random_key()))
      |> User.add_notification(create_notification(Tak.Helper.random_key()))

    assert {:noreply, []} == NotificationServer.handle_cast({:save, user}, %{})
  end

  test "should be able to retrieve all user notifications" do
    user_id = "test_notification_user" <> Tak.Helper.random_key()
    given_that_notifications_exists_for_user(user_id)

    {:reply, {:ok, user}, state} = NotificationServer.handle_call({:lookup, user_id}, self, %{})
    assert user != nil
    assert Enum.count(user.notifications) == 2

    assert Enum.any?(user.notifications, fn x ->
             assert x.category_type == "invitation_request" &&
                      assert(
                        x.category_fields ==
                          %{:content => "hello there, how are you ?", :sender => "rin"}
                      )
           end)
  end

  defp create_notification(id) do
    category_type = "invitation_request"
    category_fields = %{sender: "rin", content: "hello there, how are you ?"}
    notification = Notification.new(id, category_type, category_fields)
  end

  defp given_that_notifications_exists_for_user(user_id) do
    user =
      User.new(user_id)
      |> User.add_notification(create_notification(Tak.Helper.random_key()))
      |> User.add_notification(create_notification(Tak.Helper.random_key()))

    NotificationServer.handle_cast({:save, user}, %{})
  end
end
