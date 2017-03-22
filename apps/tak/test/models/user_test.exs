defmodule UserTest do
    use Tak.Case
    alias Tak.User

    test "should populate not nil id in user while creating a new one" do
        id = Tak.Helper.random_key
        user = User.new(id)
        assert user.user_id != nil
    end
    
    test "user should populate basic information" do
        id = Tak.Helper.random_key
        basic_info = %Tak.BasicInfo{name: "osaka", age: "28", gender: "female"}
        user = User.new(id) |> User.update(basic_info)

        assert user.basic_info.name == "osaka"
        assert user.user_id != nil
        assert user.basic_info.age == "28"
        assert user.basic_info.gender == "female"
    end

    test "user should populate educational details" do
        id = Tak.Helper.random_key
        educational_details = %Tak.EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
        user =  User.new(id) |> User.update(educational_details)
        
        assert user.user_id != nil
        assert user.educational_details.graduation == "G.B Pant"
        assert user.educational_details.senior_secondary == "DIS"
        assert user.educational_details.intermediate == "DIS"
    end
end