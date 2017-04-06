defmodule UserServiceTest do
    use Tak.Case
    alias Tak.User
    alias Tak.User.{BasicInfo, EducationalDetails}
    alias Tak.UserServer

    @moduletag  :user_server

    test "should be able to save and retrieve a user" do
      id = Tak.Helper.random_key
       basic_info = %BasicInfo{name: "osaka", age: 28, gender: "female"}
       educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
                       
                            user =    User.new(id)
                                        |> User.update(basic_info) 
                                        |> User.update(educational_details)
                                        |> UserServer.save


      user = UserServer.lookup(id)
      assert user.basic_info == basic_info
      assert user.educational_details == educational_details
      assert user.id == id
     
    end


end