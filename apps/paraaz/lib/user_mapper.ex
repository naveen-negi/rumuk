defmodule Paraaz.UserMapper do
    alias Paraaz.NotificationCordinator
    alias Paraaz.NotificationMapper
    alias Paraaz.Domain.User

    def to_domain(user_id, notifications) do
        %User{user_id: user_id, notifications: notifications}
    end
end