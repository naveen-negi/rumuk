defmodule UserControllerTest do
     use Tak.ConnCase

      test "should be able to create user with basic info" do
        conn = post conn, "api/users/", %{name: "erin", age: 33, isMale: false}
        assert conn.status == 204
    end

end