defmodule Tak.NotificationControllerTest do
    use Tak.ConnCase
    
    # test 'GET 200 on notifications call', %{conn: conn} do
    #     conn  = get conn, "api/users/rin/notifications"
    #     assert conn.status == 200
    # end


    # test "should save notification for the given user", %{conn: conn} do
    #     notification_type = Tak.CategoryType.InvitationRequest.type
    #     category_fields = %{sender_id: "archer"}
    #     conn = post conn, "api/users/rin/notifications", %{category_type: notification_type.value, category_fields: category_fields}
    #     assert conn.status == 204
    # end

    test "should save notification for the given user", %{conn: conn} do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "archer"}
       Paraaz.NotificationCordinator.save("rin", notification_type.value, category_fields)
    end

    #  test "should get notifications for the given user", %{conn: conn} do
    #     notification_type = Tak.CategoryType.InvitationRequest.type
    #     category_fields = %{sender_id: "archer"}
    #     # conn = save()
       
    #    notification = get conn, "api/users/rin/notifications"
    #    assert notification.user_id == "rin"
    #    assert notification.category_type == notification_type
    #    assert notification.category_fields.sender_id == category_fields.sender_id
    # end

    defp save() do
        notification_type = Tak.CategoryType.InvitationRequest.type
        category_fields = %{sender_id: "Lancter"}
        conn = post conn, "api/users/erin/notifications", %{category_type: notification_type.value, category_fields: category_fields}
    end
end