defmodule Tak.Notification do
    defstruct [notification_id: "", notification_type: "", notification_fields: %{} ]

    def new(notification_id, notification_type, notification_fields) do
        %Tak.Notification{notification_id: notification_id, notification_type: notification_type, notification_fields: notification_fields}
end
end