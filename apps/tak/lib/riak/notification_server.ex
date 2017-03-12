defmodule Tak.NotificationServer do
    use GenServer

    def start_link(name) do
        GenServer.start_link(__MODULE__, :ok, name: name)
    end

    def save(pid, user_id, category_type, category_fields) do
        GenServer.cast(pid, {:save, user_id, category_type, category_fields})
    end

    def lookup(pid, user_id) do
         response = GenServer.call(pid, {:lookup, user_id})
         IO.inspect response
         case response do
             {:ok, user} -> notifications = Enum.map(user.notifications, 
                                                fn x -> Tak.Notification.new(x.notification_id, x.category_type, x.category_fields)
                                                 end )
                                                user = %Tak.User{user_id: user.user_id, notifications: notifications}
                                                {:ok, user}
            {:error, result} ->   {:error, "not found"}
         end
    end

    def init(:ok) do
        {:ok, []}
    end

    def handle_call({:lookup, user_id}, _from, state) do
        user = Paraaz.NotificationService.get_user(user_id)
        {:reply, user, state}
    end

   def handle_cast({:save, user_id, category_type, category_fields}, state) do
        Paraaz.NotificationService.save(user_id, category_type, category_fields)
        {:noreply, []}
   end

end