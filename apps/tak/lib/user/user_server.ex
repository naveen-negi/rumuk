defmodule Tak.UserServer do
  alias Bhaduli.User
  alias Bhaduli.User.BasicInfo
  alias Bhaduli.User.EducationalDetails
  alias Bhaduli.UserService
  import Map

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def save(%Tak.User{} = user, :basic_info) do
    IO.puts("inside user gen server ...")
    basic_info = struct(Bhaduli.User.BasicInfo, from_ecto(user.basic_info))

    UserService.create(user.id)
    |> UserService.update(basic_info)
    |> UserService.save()
  end

  def save(%Tak.User{} = user, :educational_details) do
    educational_details =
      struct(Bhaduli.User.EducationalDetails, from_ecto(user.educational_details))

    UserService.create(user.id)
    |> UserService.update(educational_details)
    |> UserService.save()
  end

  def lookup(user_id) do
    case Bhaduli.UserService.get(user_id) do
      {:ok, user} ->
        basic_info = struct(Tak.User.BasicInfo, from_struct(user.basic_info))

        educational_details =
          struct(Tak.User.EducationalDetails, from_struct(user.educational_details))

        user_dto =
          Tak.User.new(user.user_id)
          |> Tak.User.update(basic_info)
          |> Tak.User.update(educational_details)

        user_dto

      {:error, reasons} ->
        {:error, reasons}
    end
  end

  def search(query) do
    {:ok, count, results} = Bhaduli.UserService.search(query)
    IO.puts("fetched search results .......")
    IO.inspect(results)

    if count == 0 do
      []
    else
      Enum.map(results, fn result -> to_domain(result) end)
    end
  end

  defp to_domain(%Bhaduli.User{} = user) do
    basic_info = struct(Tak.User.BasicInfo, from_struct(user.basic_info))

    educational_details =
      struct(Tak.User.EducationalDetails, from_struct(user.educational_details))

    Tak.User.new(user.user_id)
    |> Tak.User.update(basic_info)
    |> Tak.User.update(educational_details)
  end

  defp from_ecto(model) do
    model |> Map.delete(:__meta__) |> from_struct
  end
end
