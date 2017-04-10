defmodule Tak.Notifications.User do
    defstruct id: nil, notifications: []

    def new(id) do
        %Tak.Notifications.User{id: id}
    end

    def add_notification(user, %Tak.Notifications.Notification{} = notification) do
          notifications =  user.notifications ++ [notification]
          %Tak.Notifications.User{id: user.id, notifications: notifications}
    end
end