defmodule Tak.CategoryType.InvitationRequest do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.CategoryType{value: "invitation_request"}
    end
end