defmodule Tak.CategoryType.RequestDeclined do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.CategoryType{value: "request_declined"}
    end
end