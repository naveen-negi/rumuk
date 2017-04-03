defmodule Tak.Notifications.CategoryType.MessageReceived do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.Notifications.CategoryType{value: "message_received"}
    end
end