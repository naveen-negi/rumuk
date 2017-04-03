defmodule Tak.Notifications.CategoryType.UserActivated do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.Notifications.CategoryType{value: "user_activated"}
    end
end