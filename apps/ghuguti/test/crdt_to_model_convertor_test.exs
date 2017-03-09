defmodule CrdtToModelConvertorTest do
    use Ghuguti.Case
    alias Riak
    alias Riak.CRDT.Register
    alias Riak.CRDT.Flag
    alias Riak.CRDT.Map
    alias Riak.CRDT.Counter

    test "should convert crdt map to model" do
         key = Ghuguti.Helper.random_key

    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"

    flag = Flag.new |> Flag.enable
    flag_key = "flag_key"

    counter = Counter.new |> Counter.increment
    counter_key = "counter_key"

    Map.new
      |> Map.put(reg_key, reg)
      |> Map.put(flag_key, flag)
      |> Map.update(:counter, counter_key, fn _ -> counter end)
      |> Riak.update("maps", "bucketmap", key)

    map = Riak.find("maps", "bucketmap", key)
      |> Map.value

     user =  Convertor.CrdtToModel.to_model(map, TestModel)
     IO.inspect user
     assert user.reg_key == reg_data
     assert user.flag_key == true
     assert user.counter_key == 1
    end

test "should convert crdt with nested map to model" do
    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"

    key = Ghuguti.Helper.random_key
    flag = Flag.new |> Flag.enable
    flag_key = "flag_key"

    nested = Map.new |> Map.put(flag_key, flag)
    nested_map = "nested_map"

    Map.new
    |> Map.put(reg_key, reg)
    |> Map.put(nested_map, nested)
    |> Riak.update("maps", "bucketmap", key)

    map = Riak.find("maps", "bucketmap", key)

    map = map |> Map.value

    model = Convertor.CrdtToModel.to_model(map, TestModelWithNestedMap)

    assert model.reg_key == reg_data
    assert model.nested_map == %{flag_key: true}
end

test "should convert crdt with with nested map to model with nested model" do
    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "reg_key"

    key = Ghuguti.Helper.random_key
    flag = Flag.new |> Flag.enable
    flag_key = "flag_key"

    nested = Map.new |> Map.put(flag_key, flag)
    nested_model = "nested_model"

    Map.new
    |> Map.put(reg_key, reg)
    |> Map.put(nested_model, nested)
    |> Riak.update("maps", "bucketmap", key)

    map = Riak.find("maps", "bucketmap", key)

    map = map |> Map.value

    model = Convertor.CrdtToModel.to_model(map, TestModelWithNestedModel)
    n_model = NestedModel.new
    assert model.reg_key == reg_data
    assert model.nested_model == n_model
end

end


defmodule TestModel do
    defstruct reg_key: nil, flag_key: nil, counter_key: nil
end

defmodule NestedModel do
    defstruct flag_key: nil

    def new do
        %NestedModel{flag_key: true}
    end
end

defmodule TestModelWithNestedMap do
    defstruct reg_key: nil, nested_map: nil
end

defmodule TestModelWithNestedModel do
    defstruct reg_key: nil, nested_model: %NestedModel{}
end