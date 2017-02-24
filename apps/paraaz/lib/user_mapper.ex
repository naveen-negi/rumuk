defmodule Paraaz.UserMapper do
    alias Paraaz.NotificationCordinator
    alias Paraaz.NotificationMapper
    alias Paraaz.Domain.User

    def to_domain(user) do
        user_id = user |> Paraaz.User.get_user_id
        IO.puts "userId: is .." 
        IO.puts  user_id

        notifications = NotificationCordinator.get_all_notifications(user_id)
        
        %User{user_id: user_id, notifications: notifications}
    end
end