defmodule Paraaz.Domain.Notification do
  defstruct [:user_id, :notification_id, :category_type, :category_fields]

  def new(user_id, notification_id, category_type, category_fields) do
    %Paraaz.Domain.Notification{
      user_id: user_id,
      notification_id: notification_id,
      category_type: category_type,
      category_fields: category_fields
    }
  end
end
