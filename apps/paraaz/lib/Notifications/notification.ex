defmodule Paraaz.Notification do
 alias Riak.CRDT.Map   
 alias Riak.CRDT.Register   
 alias Riak.CRDT.Set  

    def new(belongs_to, category_type, category_fields) do
        
        user_id = Register.new(belongs_to)
        category = Register.new(category_type)
        
        category_fields = create_category_fields(category_fields)
        
        id_raw = belongs_to <> "_" <> category_type <> "_"  <> UUID.uuid1()

        id = Register.new(id_raw)

        map = Map.new
                |>Map.put("user_id", user_id) 
                |>Map.put("category_type", category)
                |>Map.put("notification_id", id)
                |>Map.put("category_fields", category_fields)

        %{id: id_raw, notification: map}
    end

     def create_category_fields(category_fields) do

      Enum.reduce(category_fields, Map.new, fn({k, v}, map) -> 
          map |> Map.put(to_string(k), Register.new(v))
        end)

    end
end