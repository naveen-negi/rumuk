defmodule Tak.NotificationServer do
    use GenServer
    ##Client API

    def start_link(name) do
        GenServer.start_link(__MODULE__, :ok, name: name)
    end

    def save(pid, user_id, category_type, category_fields) do
       
        GenServer.cast(pid, {:save, user_id, category_type, category_fields})
    end

    def lookup(pid, user_id) do
        GenServer.call(pid, {:lookup, user_id})
    end

    def init(:ok) do
        {:ok, []}
    end

    def handle_call({:lookup, user_id}, _from, state) do
        user = Paraaz.NotificationCordinator.get_user(user_id)
        {:reply, user, state}
    end

   def handle_cast({:save, user_id, category_type, category_fields}, state) do
        Paraaz.NotificationCordinator.save(user_id, category_type, category_fields)
        {:noreply, []}
   end

end