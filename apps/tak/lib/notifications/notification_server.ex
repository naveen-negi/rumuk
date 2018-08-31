defmodule Tak.NotificationServer do
  use GenServer
  alias Tak.Notifications.{User, Notification}

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def save(pid, user) do
    Enum.each(user.notifications, fn x ->
      GenServer.cast(pid, {:save, user})
    end)
  end

  def lookup(pid, user_id) do
    response = GenServer.call(pid, {:lookup, user_id})

    case response do
      {:ok, user} ->
        notifications =
          Enum.map(
            user.notifications,
            fn x -> Notification.new(x.notification_id, x.category_type, x.category_fields) end
          )

        user = %User{id: user.user_id, notifications: notifications}
        {:ok, user}

      {:error, result} ->
        {:error, "not found"}
    end
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:lookup, user_id}, _from, state) do
    response = Paraaz.NotificationService.get_user(user_id)
    {:reply, response, state}
  end

  def handle_cast({:save, user}, state) do
    Enum.each(user.notifications, fn x ->
      Paraaz.NotificationService.save(user.id, x.category_type, x.category_fields)
    end)

    {:noreply, []}
  end
end
