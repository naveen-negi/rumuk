defmodule Paraaz.Domain.User do
    defstruct [:user_id, :notifications]

    def new(id) do
        %Paraaz.Domain.User{user_id: id}
    end

    def add_notification(user, notification_id) do
        notifications_list = [notification_id] ++ [user.notifications]
        %Paraaz.Domain.User{user_id: user.user_id, notifications: notifications_list}
    end

end