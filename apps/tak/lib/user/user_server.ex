defmodule Tak.UserServer do
    use GenServer
    alias Bhaduli.User
    alias Bhaduli.User.BasicInfo
    alias Bhaduli.User.EducationalDetails
    import Map

    def start_link(name) do
        GenServer.start_link(__MODULE__, :ok, name: name)
    end

    def save(%Tak.User{} = user) do
        GenServer.cast(__MODULE__, {:save, user})
    end

    def lookup(user_id) do
       GenServer.call(__MODULE__, {:lookup, user_id})
    end

    def init(:ok) do
        {:ok, []}
    end

    def handle_call({:lookup, user_id}, _from, state) do
         case Bhaduli.UserRepository.get(user_id) do
                {:ok, user} ->  basic_info = struct(Tak.User.BasicInfo, from_struct(user.basic_info))
                                educational_details = struct(Tak.User.EducationalDetails, from_struct(user.educational_details))
                                user_dto = Tak.User.new(user.user_id)
                                            |> Tak.User.update(basic_info)
                                            |> Tak.User.update(educational_details)
                                {:reply, user_dto, state}
             {:error, reasons} -> {:error, reasons}
            end
    end

   def handle_cast({:save, user}, state) do
        basic_info = struct(Bhaduli.User.BasicInfo, from_ecto(user.basic_info))
        educational_details = struct(Bhaduli.User.EducationalDetails, from_ecto(user.educational_details))
                              response = User.new(user.id)
                                        |> User.update(basic_info)
                                        |> User.update(educational_details)
                                        |> Bhaduli.UserRepository.save
              {:noreply, []}
   end

   defp from_ecto(model) do
      model |> Map.delete(:__meta__) |> from_struct
   end
end