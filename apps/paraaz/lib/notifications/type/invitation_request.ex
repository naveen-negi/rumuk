defmodule Paraaz.CategoryType.InvitationRequest do
  @behaviour Paraaz.CategoryType

  def type do
    %Paraaz.CategoryType{value: "invitation_request"}
  end
end
