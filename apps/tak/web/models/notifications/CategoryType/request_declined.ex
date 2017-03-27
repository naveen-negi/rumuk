defmodule TTak.Notifications.CategoryType.RequestDeclined do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.Notifications.CategoryType{value: "request_declined"}
    end
end