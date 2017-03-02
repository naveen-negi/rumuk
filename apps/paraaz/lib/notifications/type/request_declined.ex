defmodule Paraaz.CategoryType.RequestDeclined do
    @behaviour Paraaz.CategoryType

    def type do
        %Paraaz.CategoryType{value: "request_declined"}
    end
end