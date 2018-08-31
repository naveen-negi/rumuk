defmodule Bhaduli.Parser do
  alias Bhaduli.User
  alias Bhaduli.User.{BasicInfo, EducationalDetails}

  def parse(results) do
    {:ok, {:search_results, users, rank, count}} = results
    matches = parse_user_details(users, [])
    {:ok, count, matches}
  end

  def parse_user_details(users, list) when users == [] do
    list
  end

  def parse_user_details(users, list) do
    [h | t] = users
    {_, details_list} = h
    user = get_user_details(details_list)
    list = [user] ++ list
    parse_user_details(t, list)
  end

  def get_user_details(list) do
    Enum.reduce(list, %User{}, fn detail, user -> process(detail, user) end)
  end

  defp process({"user_id_register", id}, user) do
    %User{user | user_id: id}
  end

  defp process({"basic_info_map.age_counter", age}, user) do
    basic_info = %BasicInfo{user.basic_info | age: String.to_integer(age)}
    %User{user | basic_info: basic_info}
  end

  defp process({"basic_info_map.name_register", name}, user) do
    basic_info = %BasicInfo{user.basic_info | name: name}
    %User{user | basic_info: basic_info}
  end

  defp process({"basic_info_map.gender_register", gender}, user) do
    basic_info = %BasicInfo{user.basic_info | gender: gender}
    %User{user | basic_info: basic_info}
  end

  defp process({"educational_details_map.graduation_register", graduation}, user) do
    educational_details = %EducationalDetails{user.educational_details | graduation: graduation}
    %User{user | educational_details: educational_details}
  end

  defp process({"educational_details_map.intermediate_register", intermediate}, user) do
    educational_details = %EducationalDetails{
      user.educational_details
      | intermediate: intermediate
    }

    %User{user | educational_details: educational_details}
  end

  defp process({"educational_details_map.senior_secondary_register", senior_secondary}, user) do
    educational_details = %EducationalDetails{
      user.educational_details
      | senior_secondary: senior_secondary
    }

    %User{user | educational_details: educational_details}
  end

  defp process(details, user) do
    user
  end
end
