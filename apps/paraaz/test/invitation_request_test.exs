defmodule InvitationRequestTest do
  use Paraaz.Case
  alias Paraaz.CategoryType.InvitationRequest

  test "should get invitation request Category Type" do
    category_type = InvitationRequest.type().value

    assert category_type == "invitation_request"
  end
end
