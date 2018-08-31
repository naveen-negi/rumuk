defmodule GhugutiTest do
  use Ghuguti.Case
  import Map
  alias Riak.CRDT.{Map, Register, Flag, Counter}

  test "should convert crdt to domain model" do
    key = Ghuguti.Helper.random_key()
    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"
    flag = Flag.new() |> Flag.enable()
    flag_key = "flag_key"
    counter = Counter.new() |> Counter.increment()
    counter_key = "counter_key"

    response =
      Map.new()
      |> Map.put(reg_key, reg)
      |> Map.put(flag_key, flag)
      |> Map.update(:counter, counter_key, fn _ -> counter end)
      |> Riak.update("maps", "bucketmap", key)

    assert response == :ok

    map =
      Riak.find("maps", "bucketmap", key)
      |> Map.value()

    user = Ghuguti.to_model(map, UserModel)
    assert user.reg_key == reg_data
    assert user.flag_key == true
    assert user.counter_key == 1
  end

  test "should be able to convert model into crdt" do
    model = BasicMapModel.new()
    model_map = from_struct(model)

    Ghuguti.to_crdt(model)
    |> Riak.update("maps", "bucketmap", model.name)

    map = Riak.find("maps", "bucketmap", model.name) |> Map.value()
    map_keys = :orddict.fetch_keys(map)

    assert {"is_interested", :flag} in map_keys
    assert {"name", :register} in map_keys
    assert {"age", :counter} in map_keys
    assert :orddict.size(map) == 3

    data = :orddict.to_list(map)
    assert {{"name", :register}, "subaru"} in data
    assert {{"age", :counter}, 30} in data
    assert {{"is_interested", :flag}, true} in data
  end
end

defmodule UserModel do
  defstruct reg_key: nil, flag_key: nil, counter_key: nil
end

defmodule BasicMapModel do
  defstruct name: "subaru", age: 30, is_interested: true

  def new do
    %BasicMapModel{}
  end
end
