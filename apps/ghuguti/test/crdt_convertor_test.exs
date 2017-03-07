defmodule CrdtConvertorTest do
  use ExUnit.Case
  doctest Ghuguti
  import Map
  alias Ghuguti.CrdtConvertor
  alias Riak.CRDT.Map
  
  test "should be able to convert a struct into crdt" do
     model = BasicMap.new
     model_map = from_struct(model)

      CrdtConvertor.to_crdt(model)
      |> Riak.update("maps", "bucketmap", model.name)

    map = Riak.find("maps", "bucketmap", model.name) |> Map.value
     IO.inspect map

    map_keys = :orddict.fetch_keys(map)

    assert {"is_interested", :flag} in map_keys
    assert {"name", :register} in map_keys
    assert {"age", :register} in map_keys
    assert :orddict.size(map) == 3

    data = :orddict.to_list(map)
    assert {{"name", :register}, "subaru"} in data
    assert {{"age", :register}, "30"} in data
    assert {{"is_interested", :flag}, true} in data
 end

  test "should convert struct with list to CRDT with Set" do
     model = BasicMapWithSet.new

      CrdtConvertor.to_crdt(model)
      |> Riak.update("maps", "bucketmap", model.name)

    map = Riak.find("maps", "bucketmap", model.name) |> Map.value

    map_keys = :orddict.fetch_keys(map)

    assert {"is_interested", :flag} in map_keys
    assert {"name", :register} in map_keys
    assert {"age", :register} in map_keys
    assert {"interests", :set} in map_keys
    assert :orddict.size(map) == 4

    data = :orddict.to_list(map)
    assert {{"name", :register}, model.name} in data
    assert {{"age", :register}, to_string(model.age)} in data
    assert {{"is_interested", :flag}, false} in data
    assert {{"is_interested", :flag}, false} in data

    set = :orddict.fetch({"interests", :set}, map)
    assert "shopping" in set
    assert "watching movies" in set
 end

  test "should update a register type" do
     user_id = "saber"
     given_that_user_already_exists(user_id)
     key = "age"
     updated_value = "20"
     user = Riak.find("maps", "bucketmap", user_id) 

    updated_map = CrdtConvertor.update(user, [age: updated_value])
     
     updated_map |> Riak.update("maps", "bucketmap",user_id)

     map = Riak.find("maps", "bucketmap", user_id) |> Map.value
     IO.inspect map
    map_keys = :orddict.fetch_keys(map)

    data = :orddict.to_list(map)
    assert {{"age", :register}, to_string(updated_value)} in data
  end

  test "should update a Flag(boolean) type" do
       user_id = "wrath"
       user = BasicMap.new(user_id)
 
       user = %{ user | is_interested: true}
      
        user 
        |> CrdtConvertor.to_crdt
        |> Riak.update("maps", "bucketmap", user_id)

     user = Riak.find("maps", "bucketmap", user_id) 

    updated_map = CrdtConvertor.update(user, [is_interested: false])
     IO.inspect updated_map
     updated_map |> Riak.update("maps", "bucketmap",user_id)

     map = Riak.find("maps", "bucketmap", user_id) |> Map.value
     IO.inspect map
    map_keys = :orddict.fetch_keys(map)

    data = :orddict.to_list(map)
    assert {{"is_interested", :flag}, false} in data
  end

def given_that_user_already_exists(user_id) do
   
     BasicMap.new(user_id)
      |> CrdtConvertor.to_crdt
      |> Riak.update("maps", "bucketmap", user_id)
end

end

defmodule BasicMap do
  defstruct name: "subaru", age: 30, is_interested: true

  def new do
    %BasicMap{}
  end

  def new(name) do
    %BasicMap{name: name} 
  end
end

defmodule BasicMapWithSet do
  defstruct [name: "rin_osaka", age: 23, is_interested: false, interests: ["shopping", "watching movies"]]

  def new do
    %BasicMapWithSet{} 
  end
end

defmodule BasicMapWithCounter do
  defstruct [name: "rin_osaka", age: 23, is_interested: false, visists: 2, interests: ["shopping", "watching movies"] ]

  def new do
    %BasicMapWithCounter{}
  end
end


