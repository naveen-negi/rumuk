defmodule Bhaduli.UserService do
    alias Bhaduli.UserRepository
    alias Bhaduli.User
    alias Bhaduli.UserSupervisor
    alias Bhaduli.User.{BasicInfo, EducationalDetails}
    
    def create(id) do
        UserSupervisor.start_user(id)
        User.get(id)
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
       |> UserRepository.save
    end

    def get(id) do
        case UserRepository.get(id) do
            {:error, _} -> {:error, :not_found}
            {:ok, user} ->  UserSupervisor.start_user(id)
                            {:ok, user}
        end
    end
end