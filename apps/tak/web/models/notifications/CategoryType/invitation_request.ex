defmodule Tak.Notifications.CategoryType.InvitationRequest do
    @behaviour Paraaz.CategoryType

    def type do
        %Tak.Notifications.CategoryType{value: "invitation_request"}
    end
end