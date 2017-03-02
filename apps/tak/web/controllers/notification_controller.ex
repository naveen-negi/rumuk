defmodule Tak.NotificationController do
    use Tak.Web, :controller

    def get(conn, _params) do
         user_id = conn.params["user_id"]
        user = Tak.NotificationServer.lookup(Tak.NotificationServer, user_id)
        
        conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Poison.encode!(user))
    end

    def create(conn, params) do
        user_id = conn.params["user_id"]
        category_fields = params["category_fields"]
        category_type = params["category_type"]
        
        Tak.NotificationServer.save(Tak.NotificationServer, user_id, category_type, category_fields)

        send_resp(conn, 204, "")
    end
end