defmodule Tak.NotificationControllerTest do
    use Tak.ConnCase
    
    test "should save notification for the given user", %{conn: conn} do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "archer"}
        conn = post build_conn, "api/users/rin/notifications", %{category_type: notification_type.value, category_fields: category_fields}
        assert conn.status == 204
    end

    #  test "should get notifications for the given user", %{conn: conn} do
    #     notification_type = Tak.CategoryType.InvitationRequest.type
    #     category_fields = %{sender_id: "archer"}
    #     response = get conn, "api/users/rin/notifications" 
    #     IO.inspect response
    #     user = Poison.decode!(response.resp_body, as: %Tak.User{})
    #     assert user.user_id == "rin"
    #  end

     test "should return not found for non existent user" do
          response = get build_conn, "api/users/unknow/notifications" 
          assert response.status == 404
     end



    defp save() do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "Lancter"}
        post conn, "api/users/erin/notifications", %{category_type: notification_type.value, category_fields: category_fields}
    end


end