defmodule CrdtToModelConvertorTest do
  use Ghuguti.Case
  alias Riak
  alias Riak.CRDT.Register
  alias Riak.CRDT.Flag
  alias Riak.CRDT.Map
  alias Riak.CRDT.Counter
  alias Convertor.ModelToCrdt

  test "should convert crdt map to model" do
    key = Ghuguti.Helper.random_key()

    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"

    flag = Flag.new() |> Flag.enable()
    flag_key = "flag_key"

    counter = Counter.new() |> Counter.increment()
    counter_key = "counter_key"

    Map.new()
    |> Map.put(reg_key, reg)
    |> Map.put(flag_key, flag)
    |> Map.update(:counter, counter_key, fn _ -> counter end)
    |> Riak.update("maps", "bucketmap", key)

    map =
      Riak.find("maps", "bucketmap", key)
      |> Map.value()

    user = Convertor.CrdtToModel.to_model(map, TestModel)
    assert user.reg_key == reg_data
    assert user.flag_key == true
    assert user.counter_key == 1
  end

  test "should convert crdt with nested map to model" do
    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"

    key = Ghuguti.Helper.random_key()
    flag = Flag.new() |> Flag.enable()
    flag_key = "flag_key"

    nested = Map.new() |> Map.put(flag_key, flag)
    nested_map = "nested_map"

    Map.new()
    |> Map.put(reg_key, reg)
    |> Map.put(nested_map, nested)
    |> Riak.update("maps", "bucketmap", key)

    map = Riak.find("maps", "bucketmap", key)

    map = map |> Map.value()

    model = Convertor.CrdtToModel.to_model(map, TestModelWithNestedMap)

    assert model.reg_key == reg_data
    assert model.nested_map == %{flag_key: true}
  end

  test "should convert crdt with with nested map to model with nested model" do
    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"

    key = Ghuguti.Helper.random_key()
    flag = Flag.new() |> Flag.enable()
    flag_key = "flag_key"

    nested = Map.new() |> Map.put(flag_key, flag)
    nested_model = "nested_model"

    response =
      Map.new()
      |> Map.put(reg_key, reg)
      |> Map.put(nested_model, nested)
      |> Riak.update("maps", "bucketmap", key)

    assert response == :ok

    map = Riak.find("maps", "bucketmap", key)

    map = map |> Map.value()

    model = Convertor.CrdtToModel.to_model(map, TestModelWithNestedModel)
    n_model = NestedModel.new()
    assert model.reg_key == reg_data
    assert model.nested_model == n_model
  end

  test "should convert crdt with with doubly nested map to model with doubly nested model" do
    key = Ghuguti.Helper.random_key()

    ModelToCrdt.to_crdt(TestModelWithDoublyNestedHierarchy.new())
    |> Riak.update("maps", "bucketmap", key)

    map = Riak.find("maps", "bucketmap", key) |> Map.value()
    model = Convertor.CrdtToModel.to_model(map, TestModelWithDoublyNestedHierarchy)
    assert model.reg_key == "reg_key_top"
    assert model.nested_model_parrent.reg_key == "reg_key"
    assert model.nested_model_parrent.nested_model.flag_key == true
  end

  test "should convert map with multiple nested model" do
    key = Ghuguti.Helper.random_key()

    ModelToCrdt.to_crdt(TestModelWithMultipleChildren.new())
    |> Riak.update("maps", "bucketmap", key)

    map = Riak.find("maps", "bucketmap", key) |> Map.value()
    model = Convertor.CrdtToModel.to_model(map, TestModelWithMultipleChildren)
    assert model.reg_key == "reg_key_top"
    assert model.nested_model_1.reg_key == "reg_key"
    assert model.nested_model_1.nested_model.flag_key == true
    assert model.nested_model_2.flag_key == true
    assert model.nested_model_3.flag_key == false
  end

  test "should convert crdt with set to model with list" do
    key = Ghuguti.Helper.random_key()
    ModelToCrdt.to_crdt(TestModelWithList.new()) |> Riak.update("maps", "bucketmap", key)
    map = Riak.find("maps", "bucketmap", key) |> Map.value()
    model = Convertor.CrdtToModel.to_model(map, TestModelWithList)
    assert model.reg_key == "reg_key"
    assert model.list == Enum.sort(["hello", "world", "I", "am", "here"])
  end
end

defmodule TestModel do
  defstruct reg_key: nil, flag_key: nil, counter_key: nil
end

defmodule NestedModel do
  defstruct flag_key: true

  def new do
    %NestedModel{flag_key: true}
  end
end

defmodule TestModelWithNestedMap do
  defstruct reg_key: nil, nested_map: nil
end

defmodule TestModelWithNestedModel do
  defstruct reg_key: "reg_key", nested_model: %NestedModel{}
end

defmodule TestModelWithDoublyNestedHierarchy do
  defstruct reg_key: "reg_key_top", nested_model_parrent: %TestModelWithNestedModel{}

  def new do
    %TestModelWithDoublyNestedHierarchy{}
  end
end

defmodule TestModelWithMultipleChildren do
  defstruct reg_key: "reg_key_top",
            nested_model_1: %TestModelWithNestedModel{},
            nested_model_2: %TestModel{flag_key: true},
            nested_model_3: %NestedModel{flag_key: false}

  def new do
    %TestModelWithMultipleChildren{}
  end
end

defmodule TestModelWithList do
  defstruct reg_key: "reg_key", list: ["hello", "world", "I", "am", "here"]

  def new do
    %TestModelWithList{}
  end
end
