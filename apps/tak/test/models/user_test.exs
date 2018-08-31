# defmodule Tak.UserTest do
#     use ExUnit.Case
#     alias Tak.User
#     use Tak.Case
#     import Tak.Helper

#     @basic_info %Tak.BasicInfo{age: 42, contact_number: 42, current_city: "some content", date_of_birth: 42, hometown: "some content", name: "some content"}
#     @ed %Tak.EducationalDetails{graduation: "some content", intermediate: "some content", senior_secondary: "some content", user_id: 42}

#     test "should be able to update basic info for a user" do
#         user = User.new(random_key)
#                 |> User.update(@basic_info)

#         assert user.basic_info == @basic_info
#     end

#     test "should update user with educational details" do
#         user = User.new(random_key)
#                 |> User.update(@ed)

#         assert user.educational_details == @ed
#     end

#     test "should populate basic info and educational details" do
#        user =  User.new(random_key)
#             |> User.update(@basic_info)
#             |> User.update(@ed)

#          assert user.educational_details == @ed
#          assert user.basic_info == @basic_info
#     end

#     test "should create user with a unique Id" do
#         user = User.new(random_key)
#         assert user.id != nil        

#     end
# end
