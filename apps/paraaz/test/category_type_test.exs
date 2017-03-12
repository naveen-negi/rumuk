defmodule CategoryTypeTest do
    use Ghuguti.Case
    alias Paraaz.CategoryType

    test "should be able to create category type" do
        type = %CategoryType{value: "invitation_request"}

        assert type.value == "invitation_request"
    end
end