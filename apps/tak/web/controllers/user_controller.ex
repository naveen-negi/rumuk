defmodule Tak.UserController do
    use Tak.Web, :controller
    alias Tak.User
    alias Tak.User.{BasicInfo, EducationalDetails}
    import Map

    def create_basic_info(conn, params) do
        user_id = conn.params["user_id"]
        changeset = BasicInfo.changeset(%BasicInfo{}, params)

        case changeset.valid? do
          true ->
                    user_id
                    |> User.new
                    |> User.update(struct(BasicInfo, changeset.changes))
                    |> Tak.UserServer.save(:basic_info)

                     send_resp(conn, 204,"")

            false ->  errors = Tak.ChangesetView.render("error.json", %{changeset: changeset})
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(400, Poison.encode!(errors))
        end
    end

    def get_basic_info(conn, params) do
        user_id = conn.params["user_id"]
             user = Tak.UserServer.lookup(user_id) 
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(200, Poison.encode!(user.basic_info))
    end

    def get_educational_details(conn, params) do
        user_id = conn.params["user_id"]
             user = Tak.UserServer.lookup(user_id)
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(200, Poison.encode!(user.educational_details))
    end

    def create_educational_details(conn, params) do
        user_id = conn.params["user_id"]
        changeset = EducationalDetails.changeset(%EducationalDetails{}, params)
      
        case changeset.valid? do
            true -> User.new(user_id) 
                    |> User.update(struct(EducationalDetails, changeset.changes))
                    |> Tak.UserServer.save(:educational_details)
                     
                     send_resp(conn, 204,"")

            false ->  errors = Tak.ChangesetView.render("error.json", %{changeset: changeset})
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(400, Poison.encode!(errors))
                    
        end
    end
end
