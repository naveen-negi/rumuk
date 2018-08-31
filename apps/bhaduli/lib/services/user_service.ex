defmodule Bhaduli.UserService do
  alias Bhaduli.UserRepository
  alias Bhaduli.User
  alias Bhaduli.UserSupervisor
  alias Bhaduli.User.{BasicInfo, EducationalDetails}
  alias Bhaduli.Parser

  def create(id) do
    case User.get(id) do
      {:error, :not_found} ->
        UserSupervisor.start_user(id)
        User.get(id)

      user ->
        user
    end
  end

  def update(%User{} = user, %BasicInfo{} = basic_info) do
    User.update(user.user_id, basic_info)
    User.get(user.user_id)
  end

  def update(%User{} = user, %EducationalDetails{} = educational_details) do
    User.update(user.user_id, educational_details)
    User.get(user.user_id)
  end

  def save(%User{} = user) do
    user
    |> UserRepository.save()
  end

  def get(id) do
    case User.get(id) do
      {:error, :not_found} -> get_user_from_db(id)
      user -> {:ok, user}
    end
  end

  def search(query) do
    search_results = UserRepository.search(query)
    Parser.parse(search_results)
  end

  defp get_user_from_db(id) do
    case UserRepository.get(id) do
      {:error, _} ->
        {:error, :not_found}

      {:ok, user} ->
        UserSupervisor.start_user(id)
        {:ok, user}
    end
  end
end
