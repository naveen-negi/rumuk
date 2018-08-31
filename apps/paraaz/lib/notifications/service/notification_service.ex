defmodule Paraaz.NotificationService do
  alias Paraaz.Domain.Notification
  alias Paraaz.Domain.User
  alias Riak.CRDT.Map
  alias Ghuguti

  def bucket_type do
    Application.get_env(:paraaz, :bucket_type)
  end

  def bucket_name do
    Application.get_env(:paraaz, :bucket_name)
  end

  def save(user_id, category_type, category_fields) do
    notification_id = get_new_notification_id(user_id, category_type)

    Notification.new(user_id, notification_id, category_type, category_fields)
    |> Ghuguti.to_crdt()
    |> Riak.update(bucket_type, bucket_name, notification_id)

    user = Riak.find(bucket_type, bucket_name, user_id)

    result =
      case user do
        nil ->
          User.new(user_id)
          |> User.add_notification(notification_id)
          |> Ghuguti.to_crdt()
          |> Riak.update(bucket_type, bucket_name, user_id)

        _ ->
          user_model =
            user
            |> Map.value()
            |> Ghuguti.to_model(User)
            |> User.add_notification(notification_id)

          Ghuguti.update_crdt(user, [:notifications, user_model.notifications])
          |> Riak.update(bucket_type, bucket_name, user_id)
      end
  end

  defp get_new_notification_id(user_id, category_type) do
    user_id <> "_" <> category_type <> "_" <> UUID.uuid1()
  end

  def get_all_notifications(user_id) do
    user = Riak.find(bucket_type, bucket_name, user_id)

    case user do
      nil ->
        {:error, notifications: []}

      _ ->
        user_map = user |> Map.value()
        IO.puts("inside paraz")
        IO.inspect(user_map)

        :orddict.fetch({"notifications", :set}, user_map)
        |> Enum.map(fn x -> Riak.find(bucket_type, bucket_name, x) |> Map.value() end)
        |> Enum.filter(fn x -> !is_nil(x) end)
        |> Enum.map(fn x -> Ghuguti.to_model(x, Paraaz.Domain.Notification) end)
    end
  end

  def get_user(user_id) do
    notification = get_all_notifications(user_id)

    case notification do
      {:error, notifications: []} ->
        {:error, "user not found"}

      _ ->
        user = %Paraaz.Domain.User{
          user_id: user_id,
          notifications: get_all_notifications(user_id)
        }

        {:ok, user}
    end
  end
end
