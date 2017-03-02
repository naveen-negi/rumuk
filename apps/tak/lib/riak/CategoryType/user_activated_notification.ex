defmodule Tak.CategoryType.UserActivated do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.CategoryType{value: "user_activated"}
    end
end