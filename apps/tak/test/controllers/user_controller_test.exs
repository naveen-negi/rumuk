defmodule UserControllerTest do
     use Tak.ConnCase
     alias Tak.User
     alias Tak.User.{BasicInfo, EducationalDetails}
    @moduletag :user     

      test "should be able to create user with basic info" do
        key = Tak.Helper.random_key
        conn = post build_conn, "api/users/rin/basic_info", %{name: "erin", age: 33, isMale: false}
        assert conn.status == 204
    end

      test "should return with 400 when incorrect data is supplied" do
        conn = post build_conn, "api/users/rin/basic_info", %{name: "erin", age: "notknow", isMale: false}
        assert conn.status == 400
    end

    test "should be able to create user with educational Details" do
        key = Tak.Helper.random_key
        educational_details = %{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
        conn = post build_conn, "api/users/rin/educational_details", educational_details
        assert conn.status == 204
    end

    test "should return error for user with invalid educational Details" do
        key = Tak.Helper.random_key
        educational_details = %{graduation: "G.B Pant", senior_secondary_invalid: "DIS", intermediate: "DIS"}
        conn = post build_conn, "api/users/rin/educational_details", educational_details
        assert conn.status == 400
    end

    test "should be able to get basic info with given id" do
        user_id = Tak.Helper.random_key
       conn = post build_conn, "api/users/#{user_id}/basic_info", %{name: "erin", age: 33, gender: "female"}
        assert conn.status == 204

        conn = get build_conn, "api/users/#{user_id}/basic_info"
        assert conn.status == 200

    end
end