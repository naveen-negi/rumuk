defmodule Tak.UserController do
    use Tak.Web, :controller
    alias Tak.User
    alias Tak.User.{BasicInfo, EducationalDetails}

    def get_basic_info(conn, _params) do
        user_id = conn.params["user_id"]
                     basic_info = Tak.UserServer.lookup(self(), user_id)
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(200, Poison.encode!(basic_info))
    end

    def create_educational_details(conn, _params) do
        user_id = conn.params["user_id"]
        changeset = EducationalDetails.changeset(%EducationalDetails{}, _params)
      
        case changeset.valid? do
            true -> User.new(user_id) 
                    |> User.update(changeset.data)
                    |> Tak.UserServer.save(self())
                     
                     send_resp(conn, 204,"")

            false ->  errors = Tak.ChangesetView.render("error.json", %{changeset: changeset})
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(400, Poison.encode!(errors))
                    
        end
    end

end
