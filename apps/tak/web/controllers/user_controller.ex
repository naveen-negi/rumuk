defmodule Tak.UserController do
  use Tak.Web, :controller
  alias Tak.User
  alias Tak.User.{BasicInfo, EducationalDetails}
  import Map

  def create_basic_info(conn, %{"age" =>  age, "isMale" =>  is_male, "name" =>  name, "user_id" => user_id} = params) do
    basic_info = %{age: age, name: name, gender: to_gender(is_male)}

    user_id
     |> User.new
     |> User.update(BasicInfo.new(basic_info))
     |> Tak.UserServer.save(:basic_info)

     send_resp(conn, 204,"")
  end


  def get_basic_info(conn, params) do
    # user_id = conn.params["user_id"]
    # user = Tak.UserServer.lookup(user_id) 
    # conn
    # |> put_resp_content_type("application/json")
    # |> send_resp(200, Poison.encode!(user.basic_info))
  end

  def get_educational_details(conn, params) do
    # user_id = conn.params["user_id"]
    # user = Tak.UserServer.lookup(user_id)
    # conn
    # |> put_resp_content_type("application/json")
    # |> send_resp(200, Poison.encode!(user.educational_details))
  end

  def create_educational_details(conn, params) do
    # user_id = conn.params["user_id"]
    # changeset = EducationalDetails.changeset(%EducationalDetails{}, params)
    # case changeset.valid? do
    #   true -> User.new(user_id) 
    #   |> User.update(struct(EducationalDetails, changeset.changes))
    #   |> Tak.UserServer.save(:educational_details)
    #     send_resp(conn, 204,"")

    #   false ->  errors = Tak.ChangesetView.render("error.json", %{changeset: changeset})
    #     conn
    #     |> put_resp_content_type("application/json")
    #     |> send_resp(400, Poison.encode!(errors))
    # end
  end

  def search_users(conn, params) do
    # gender = params["gender"]
    # min_age = params["min_age"]
    # max_age = params["max_age"]

    # results = Tak.UserServer.search(%{gender: gender, min_age: min_age, max_age: max_age})
    # conn
    # |> put_resp_content_type("application/json")
    # |> send_resp(200, Poison.encode!(results))
  end 
  
  defp to_gender(is_male) do
    case is_male do
      true -> "male"
      false -> "female"
    end
  end

end
