defmodule CrdtToModelConvertorTest do
    use Ghuguti.Case
    alias Riak

    test "should convert crdt map to model" do
         key = Ghuguti.Helper.random_key

    reg_data = "Register data"
    reg = Register.new(reg_data)
    reg_key = "register_key"

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
      model = TestModel.new 
     user =  CrdtToModelConvertor.to_model(map, as: model)
     
     assert user.reg_key == reg_data
     assert user.flag_key == true
     assert user.counter_key == 1
    end
end

defmodule TestModel do
    defstruct reg_key: nil, flag_key: nil, counter_key: nil

    def new do
        %TestModel{}
    end
end