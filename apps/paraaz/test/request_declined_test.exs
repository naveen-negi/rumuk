defmodule RequestDeclinedTest do
  use ExUnit.Case
  alias Paraaz.CategoryType.RequestDeclined

  test "should be able to create request declined category type" do
    category = RequestDeclined.type()
    assert category.value == "request_declined"
  end
end
