defmodule Bhaduli.UserServiceTest do
    use Bhaduli.Case
    alias Bhaduli.UserService
    alias Bhaduli.User.{BasicInfo, EducationalDetails}
    alias Bhaduli.User

    test "should be able to create and update user" do
        Bhaduli.UserSupervisor.start_link
        id = Bhaduli.Helper.random_key
        basic_info = %BasicInfo{name: "osaka", age: "28", gender: "female"}
        educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
           
                 UserService.create(id)
                    |> UserService.update(basic_info)
                    |> UserService.update(educational_details)
                    |> UserService.save
        
        {:ok, user} = UserService.get(id)

        assert user.user_id == id
        assert user.basic_info == basic_info
        assert user.educational_details == educational_details
    end
end