defmodule Tak.CategoryType.MessageReceived do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.CategoryType{value: "message_received"}
    end
end