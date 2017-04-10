defmodule UserTest do
    use Bhaduli.Case
    alias Bhaduli.User
    alias Bhaduli.User.{EducationalDetails, BasicInfo}
    alias Bhaduli.Helper
    @moduletag :user_gensever

    def setup_all do
        Registry.start_link(:unique, :user_process_registry)
    end
    # test "should populate not nil id in user while creating a new one" do
    #     id = Helper.random_key
    #     user = User.new(id)
    #     assert user.user_id != nil
    # end
    
    # test "user should populate basic information" do
    #     id = Helper.random_key
    #     basic_info = %BasicInfo{name: "osaka", age: "28", gender: "female"}
    #     user = User.new(id) |> User.update(basic_info)

    #     assert user.basic_info.name == "osaka"
    #     assert user.user_id != nil
    #     assert user.basic_info.age == "28"
    #     assert user.basic_info.gender == "female"
    # end

    # test "user should populate educational details" do
    #     id = Helper.random_key
    #     educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
    #     user =  User.new(id) |> User.update(educational_details)
        
    #     assert user.user_id != nil
    #     assert user.educational_details.graduation == "G.B Pant"
    #     assert user.educational_details.senior_secondary == "DIS"
    #     assert user.educational_details.intermediate == "DIS"
    # end

    test "should start user aggregate process " do
       Registry.start_link(:unique, :user_process_registry)
        id = Helper.random_key
        {:ok, pid} = User.start_link(id)
        assert pid != nil
    end

    test "should update basic information for user" do
        Registry.start_link(:unique, :user_process_registry)
        id = Helper.random_key
        basic_info = %BasicInfo{name: "osaka", age: "28", gender: "female"}
        {:ok, _} = User.start_link(id)
       
        User.update(id, basic_info)
        basic_info = User.get_basic_info(id)
       
        assert basic_info.name == "osaka"
        # assert user_id != nil
        assert basic_info.age == "28"
        assert basic_info.gender == "female"
    end

    test "should update educational details for user" do
        Registry.start_link(:unique, :user_process_registry)
        id = Helper.random_key
        educational_details_model = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
        {:ok, _} = User.start_link(id)
        User.update(id, educational_details_model)
        educational_details = User.get_educational_details(id)
       
        assert educational_details.graduation == "G.B Pant"
        assert educational_details.senior_secondary == "DIS"
        assert educational_details.intermediate == "DIS"
    end

    test "should be able to access process with given name" do
        Registry.start_link(:unique, :user_process_registry)
        id = Helper.random_key
        basic_info = %BasicInfo{name: "osaka", age: "28", gender: "female"}
        {:ok, _} = User.start_link(id)
        User.update(id, basic_info)
        basic_info = User.get_basic_info(id)
       
        assert basic_info.name == "osaka"
        assert basic_info.age == "28"
        assert basic_info.gender == "female"
    end

    test "should be able update and retrieve user" do
        Registry.start_link(:unique, :user_process_registry)
        id = Helper.random_key
        basic_info = %BasicInfo{name: "osaka", age: "28", gender: "female"}
        educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
        {:ok, _} = User.start_link(id)
        User.update(id, basic_info)
        User.update(id, educational_details)

        user = User.get(id)
        
        assert user.educational_details.graduation == "G.B Pant"
        assert user.educational_details.senior_secondary == "DIS"
        assert user.educational_details.intermediate == "DIS"
       
        assert user.basic_info.name == "osaka"
        assert user.basic_info.age == "28"
        assert user.basic_info.gender == "female"
    end
end