defmodule Paraaz.Domain.User do
  defstruct [:user_id, :notifications]

  def new(id) do
    %Paraaz.Domain.User{user_id: id}
  end

  def add_notification(user, notification_id) do
    notifications_list = add_notifications(user.notifications, notification_id)
    %Paraaz.Domain.User{user_id: user.user_id, notifications: notifications_list}
  end

  defp add_notifications(existing_notifications, new_notification)
       when is_nil(existing_notifications) do
    [new_notification]
  end

  defp add_notifications(existing_notifications, new_notification)
       when is_nil(new_notification) do
    existing_notifications
  end

  defp add_notifications(existing_notifications, new_notification) do
    [new_notification] ++ existing_notifications
  end
end
