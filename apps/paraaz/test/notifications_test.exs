defmodule NotificationTest do
  use Paraaz.Case
  alias Riak.CRDT.Map
  alias Riak.CRDT.Register
  alias Riak.CRDT.Flag
  alias Paraaz.Notification
  doctest Paraaz

  test "should create and save request declined notification" do
    belongs_to = "naveen"
    category_type = "invitation_declined"

    sender = "sender_id_1"
    category_fields = %{sender_id: sender}

    %{id: id, notification: notification} =
      Paraaz.Notification.new(belongs_to, category_type, category_fields)

    notification |> Riak.update("maps", "notifications", id)

    map = Riak.find("maps", "notifications", id) |> Map.value()

    assert :orddict.size(map) == 4
    map_keys = :orddict.fetch_keys(map)
    validate_structure(map_keys)

    data = :orddict.to_list(map)

    assert {{"user_id", :register}, "naveen"} in data
    assert {{"category_type", :register}, category_type} in data
    assert {{"notification_id", :register}, id} in data

    nested_map = get_nested_map("category_fields", map)

    sender_id = :orddict.fetch({"sender_id", :register}, nested_map)

    assert sender_id == "sender_id_1"
  end

  test "should be able to create and save invitation received notification" do
    belongs_to = "user123"
    category_type = "invitation_received"

    sender = "sender_id_1"

    category_fields = %{sender: "sender_1"}

    %{id: id, notification: notification} =
      Paraaz.Notification.new(belongs_to, category_type, category_fields)

    notification |> Riak.update("maps", "notifications", id)

    map = Riak.find("maps", "notifications", id) |> Map.value()

    assert :orddict.size(map) == 4
  end

  test "should be able to create and save a message received notification" do
    belongs_to = "user123"
    category_type = "invitation_received"
    sender = "sender_id_1"
    content = "Hello there ! how are you"

    category_fields = %{sender_id: sender, content: content}

    %{id: id, notification: notification} =
      Paraaz.Notification.new(belongs_to, category_type, category_fields)

    notification |> Riak.update("maps", "notifications", id)

    map = Riak.find("maps", "notifications", id) |> Map.value()

    assert :orddict.size(map) == 4
    map_keys = :orddict.fetch_keys(map)
    validate_structure(map_keys)

    data = :orddict.to_list(map)

    assert {{"user_id", :register}, belongs_to} in data
    assert {{"category_type", :register}, category_type} in data
    assert {{"notification_id", :register}, id} in data

    nested_map = get_nested_map("category_fields", map)

    assert :orddict.fetch({"sender_id", :register}, nested_map) == sender
    assert :orddict.fetch({"content", :register}, nested_map) == content
  end

  test "basic" do
    register = Register.new("some string")
    flag = Flag.new() |> Flag.enable()

    Map.new()
    |> Map.put("k1", register)
    |> Map.put("k2", flag)
    |> Riak.update("maps", "my_map_bucket", "map_key")

    map = Riak.find("maps", "my_map_bucket", "map_key") |> Map.value()
    assert map != nil
  end

  defp validate_structure(map_keys) do
    assert {"user_id", :register} in map_keys
    assert {"category_type", :register} in map_keys
    assert {"notification_id", :register} in map_keys
    assert {"category_fields", :map} in map_keys
  end

  defp get_nested_map(key, map) do
    :orddict.fetch({key, :map}, map)
  end
end
