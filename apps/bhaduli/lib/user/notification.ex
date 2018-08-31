defmodule Bhaduli.User.Notification do
  defstruct notification_id: "", notification_type: "", notification_fields: %{}

  def new(notification_id, notification_type, notification_fields) do
    %Bhaduli.User.Notification{
      notification_id: notification_id,
      notification_type: notification_type,
      notification_fields: notification_fields
    }
  end
end
