defmodule Tak.UserController do
    use Tak.Web, :controller
    alias Tak.User
    alias Tak.User.{BasicInfo, EducationalDetails}
    import Map

    def create_basic_info(conn, _params) do
        user_id = conn.params["user_id"]
        changeset = BasicInfo.changeset(%BasicInfo{}, _params)
      
        case changeset.valid? do
            true -> User.new(user_id) 
                    |> User.update(struct(BasicInfo, changeset.changes))
                    |> Tak.UserServer.save

                     send_resp(conn, 204,"")

            false ->  errors = Tak.ChangesetView.render("error.json", %{changeset: changeset})
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(400, Poison.encode!(errors))
        end
    end

    def get_basic_info(conn, _params) do
        user_id = conn.params["user_id"]
             user = Tak.UserServer.lookup(user_id)
            #  basic_info = from_ecto(user.basic_info)
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(200, Poison.encode!(user.basic_info))
    end

    def create_educational_details(conn, _params) do
        user_id = conn.params["user_id"]
        changeset = EducationalDetails.changeset(%EducationalDetails{}, _params)
      
        case changeset.valid? do
            true -> User.new(user_id) 
                    |> User.update(struct(EducationalDetails, changeset.changes))
                    |> Tak.UserServer.save
                     
                     send_resp(conn, 204,"")

            false ->  errors = Tak.ChangesetView.render("error.json", %{changeset: changeset})
                      conn
                      |> put_resp_content_type("application/json")
                      |> send_resp(400, Poison.encode!(errors))
                    
        end
    end

      defp from_ecto(model) do
      model |> Map.delete(:__meta__) |> from_struct
   end

end
