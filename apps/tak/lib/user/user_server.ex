defmodule Tak.UserServer do
    use GenServer
    alias Bhaduli.User
    alias Bhaduli.User.BasicInfo
    alias Bhaduli.User.EducationalDetails
    import Map

    def start_link(name) do
        # GenServer.start_link(__MODULE__, :ok, name: name)
    end

    def save(%Tak.User{} = user, pid) do
        GenServer.cast(pid, {:save, user})
    end

    def lookup(pid, user_id) do
        #  response = GenServer.call(pid, {:lookup, user_id})
        #  case response do
        #      {:ok, user} -> notifications = Enum.map(user.notifications, 
        #                                         fn x -> Notification.new(x.notification_id, x.category_type, x.category_fields)
        #                                          end )
        #                                         user = %User{user_id: user.user_id, notifications: notifications}
        #                                         {:ok, user}
        #     {:error, result} ->   {:error, "not found"}
        #  end
    end

    def init(:ok) do
        {:ok, []}
    end

    def handle_call({:lookup, user_id}, _from, state) do
        user = Bhaduli.UserRepository.get(user_id)

        basic_info = struct(Tak.BasicInfo, from_struct(user.basic_info))
        educational_details = struct(Tak.EducationalDetails, from_struct(user.educational_details))
        user_dto = Tak.User.new(user.user_id)
                    |> Tak.User.update(basic_info)
                    |> Tak.User.update(educational_details)

        {:reply, user_dto, state}
    end

   def handle_cast({:save, user}, state) do
        basic_info = struct(Bhaduli.User.BasicInfo, from_ecto(user.basic_info))
        educational_details = struct(Bhaduli.User.EducationalDetails, from_ecto(user.educational_details))

        User.new(user.id)
        |> User.update(basic_info)
        |> User.update(educational_details)
        |> Bhaduli.UserRepository.save

        {:noreply, []}
   end

   defp from_ecto(model) do
      model |> Map.delete(:__meta__) |> from_struct
   end
end