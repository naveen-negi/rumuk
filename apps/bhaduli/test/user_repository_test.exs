defmodule Bhaduli.UserRepositoryTest do
  use Bhaduli.Case
  alias Bhaduli.User
  alias Bhaduli.User.{EducationalDetails, BasicInfo}
  alias Bhaduli.Helper
  alias Bhaduli.UserRepository

  test "should be able to save and retrieve  a user from db" do
    id = Helper.random_key
    basic_info = %BasicInfo{name: "osaka", age: 28, gender: "female"}
    educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
    
    {:ok, _} = User.start_link(id)
    User.update(id, basic_info)
    User.update(id, educational_details)
    User.get(id) |>  UserRepository.save
    {:ok, user} = UserRepository.get(id)
    assert user.user_id == id
    assert user.basic_info == basic_info
    assert user.educational_details == educational_details
  end

  test "should be able to update a user" do
    id = Helper.random_key
    basic_info = %BasicInfo{name: "osaka", age: 28, gender: "female"}
    educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
    {:ok, _} = User.start_link(id)
    User.update(id, basic_info)
    User.update(id, educational_details)
    User.get(id) |>  UserRepository.save
    params = %{name: "guilty", age: 33, gender: "female"}

    UserRepository.update(:basic_info, id, params);

    {:ok, updated_user} = UserRepository.get(id)
    assert updated_user.basic_info.name == "guilty"
    assert updated_user.basic_info.age == 33
  end

  test "should be able to update basic info for a user" do
    id = Helper.random_key
    basic_info = %BasicInfo{name: "osaka", age: 28, gender: "female"}
    educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
    
    {:ok, _} = User.start_link(id)
    User.update(id, basic_info)
    User.update(id, educational_details)
    User.get(id) |>  UserRepository.save
    
    params = %{name: "guilty"}
    UserRepository.update(:basic_info, id, params);

    {:ok, updated_user} = UserRepository.get(id)
    assert updated_user.basic_info.name == "guilty"
    assert updated_user.basic_info.age == 28
    assert updated_user.basic_info.gender == "female"
  end

  test "should be able to update educational details for a user" do
    id = Helper.random_key
    educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
    {:ok, _} = User.start_link(id)
    User.update(id, educational_details)
    User.get(id) |>  UserRepository.save
    params = %{senior_secondary: "Doon International school"}
    UserRepository.update(:educational_details, id, params);

    {:ok, updated_user} = UserRepository.get(id)
    assert updated_user.educational_details.senior_secondary == "Doon International school"
  end
end
