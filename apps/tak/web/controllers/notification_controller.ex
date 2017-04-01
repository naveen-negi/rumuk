defmodule Tak.NotificationController do
    use Tak.Web, :controller
    alias Tak.Notifications.Notification
    alias Tak.Notifications.User

    def get(conn, _params) do
         user_id = conn.params["user_id"]
        case Tak.NotificationServer.lookup(Tak.NotificationServer, user_id) do
                 {:ok, user} ->     IO.inspect user
                                    conn
                                    |> put_resp_content_type("application/json")
                                    |> send_resp(200, Poison.encode!(user))
            {:error, reason} ->     
                                  conn
                                    |> put_resp_content_type("application/json")
                                    |> send_resp(404, "")
        end
    end

    def create(conn, params) do
        user_id = conn.params["user_id"]
        category_fields = params["category_fields"]
        category_type = params["category_type"]
         
         notification_id = UUID.uuid1
         notification = Notification.new(notification_id, category_type, category_fields)

         user = User.new(user_id)
                |> User.add_notification(notification)
       
        Tak.NotificationServer.save(Tak.NotificationServer, user)

        send_resp(conn, 204, "")
    end

end