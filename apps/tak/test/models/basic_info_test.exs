defmodule BasicInfoTest do
  use Tak.Case

  alias Tak.BasicInfo

  @valid_attrs %{age: 42, contact_number: 42, current_city: "some content", date_of_birth: 42, hometown: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BasicInfo.changeset(%BasicInfo{}, @valid_attrs)
    IO.inspect changeset
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BasicInfo.changeset(%BasicInfo{}, @invalid_attrs)
    assert changeset.valid? == false
  end
  
end
