defmodule UserRepositoryTest do
    use Tak.Case
    # import Map, only: [from_struct: 1]
    alias Tak.User
    alias Tak.EducationalDetails
    alias Tak.BasicInfo
    alias Convertor.ModelToCrdt
    alias Convertor.CrdtToModel

    test "should be able to save and retrieve  a user from db" do
       id = Tak.Helper.random_key
       basic_info = %Tak.BasicInfo{name: "osaka", age: 28, gender: "female"}
       educational_details = %Tak.EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
                       
                         response =    User.new(id)
                                        |> User.update(basic_info) 
                                        |> User.update(educational_details)
                                        |> Tak.UserRepository.save
                        
        assert response == :ok
        user = Tak.UserRepository.get(id)
        assert user.user_id == id  
        assert user.basic_info == basic_info
        assert user.educational_details == educational_details
    end

    test "should be able to update a user" do
        id = Tak.Helper.random_key
       basic_info = %Tak.BasicInfo{name: "osaka", age: 28, gender: "female"}
       educational_details = %Tak.EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
                       
                            User.new(id)
                              |> User.update(basic_info) 
                              |> User.update(educational_details)
                              |> Tak.UserRepository.save
                        
        params = %{name: "guilty", age: 33, gender: "female"}
        Tak.UserRepository.update(:basic_info, id, params);

        updated_user = Tak.UserRepository.get(id)
        assert updated_user.basic_info.name == "guilty"
        assert updated_user.basic_info.age == 33
        
    end

    test "should be able to update basic info for a user" do
        id = Tak.Helper.random_key
       basic_info = %Tak.BasicInfo{name: "osaka", age: 28, gender: "female"}
       educational_details = %Tak.EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
                       
                            User.new(id)
                              |> User.update(basic_info) 
                              |> User.update(educational_details)
                              |> Tak.UserRepository.save
                        
        params = %{name: "guilty"}
        Tak.UserRepository.update(:basic_info, id, params);

        updated_user = Tak.UserRepository.get(id)
        assert updated_user.basic_info.name == "guilty"
        assert updated_user.basic_info.age == 28
        assert updated_user.basic_info.gender == "female"
    end

    test "should be able to update educational details for a user" do
       id = Tak.Helper.random_key
       educational_details = %Tak.EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
                       
                            User.new(id)
                              |> User.update(educational_details)
                              |> Tak.UserRepository.save
                        
        params = %{senior_secondary: "Doon International school"}
        Tak.UserRepository.update(:educational_details, id, params);

        updated_user = Tak.UserRepository.get(id)
        assert updated_user.educational_details.senior_secondary == "Doon International school"
    end
end