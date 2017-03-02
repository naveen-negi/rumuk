defmodule Tak.NotificationControllerTest do
    use Tak.ConnCase
    
    test "should save notification for the given user", %{conn: conn} do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "archer"}
        conn = post conn, "api/users/rin/notifications", %{category_type: notification_type.value, category_fields: category_fields}
        assert conn.status == 204
    end

    # test "should save notification for the given user", %{conn: conn} do
    #     notification_type = Tak.CategoryType.InvitationRequest.type
    #     category_fields = %{sender_id: "archer"}
    #    Paraaz.NotificationCordinator.save("rin", notification_type.value, category_fields)

    # end

     test "should get notifications for the given user", %{conn: conn} do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "archer"}
        response = get conn, "api/users/rin/notifications" 
        user = Poison.decode!(response.resp_body, as: %Tak.User{})
        assert user.user_id == "rin"
        # assert user.category_type == notification_type
        # assert user.category_fields.sender_id == category_fields.sender_id
     end

    defp save() do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "Lancter"}
        post conn, "api/users/erin/notifications", %{category_type: notification_type.value, category_fields: category_fields}
    end
end