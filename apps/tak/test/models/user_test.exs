defmodule UserTest do
    use ExUnit.Case
    alias Tak.User
    use Tak.Case

    test "should be able to create user" do
        basic_info = %{age: 42, contact_number: 42, current_city: "some content", date_of_birth: 42, hometown: "some content", name: "some content"}
        educational_details = %{graduation: "some content", intermediate: "some content", senior_secondary: "some content", user_id: 42}
        changeset = User.changeset(%Tak.User{}, %{basic_info: basic_info, educational_details: educational_details})
        assert changeset.valid?
    end

    test "should fail for invalid basic info format" do
        educational_details = %{graduation: 23232, intermediate: "some content", senior_secondary: "some content", user_id: 42}
        changeset = User.changeset(%Tak.User{}, %{educational_details: educational_details})
        refute changeset.valid?
    end
    
    test "should fail for invalid educational details" do
        basic_info = %{age: 42, hometown: "some content", name_incorrect: "some content"}
        changeset = User.changeset(%Tak.User{}, %{basic_info: basic_info})
        refute changeset.valid?
    end

end