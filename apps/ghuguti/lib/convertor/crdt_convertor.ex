defmodule Ghuguti.CrdtConvertor do
    import Map, only: [from_struct: 1]
    alias Riak.CRDT.Map
    alias Riak.CRDT.Register
    alias Riak.CRDT.Flag
    alias Riak.CRDT.Set
    
    def to_crdt(model) when is_map(model) do
        from_struct(model)
        |> Enum.reduce(Map.new, fn({k, v}, map) -> 
          map |> Map.put(to_string(k), get_crdt_value(v))
        end)
    end

    def update(model, list) do
        Enum.reduce(list, model, fn {k,v}, acc -> update_field(acc, k, v) end)
    end

      defp update_field(map, key, value) when is_boolean(value) do
       IO.puts "inside update flag"
       flag =  cond do
                    value -> Flag.new |> Flag.enable
                    !value -> Flag.new |> Flag.disable    
            end
        IO.inspect flag
       Map.update(map, :flag, to_string(key), fn _ -> flag end)
    end

    defp update_field(map, key, value) when is_binary(value) do
        IO.puts "inside string match in update"
        IO.inspect value 
       Map.update(map, :register, to_string(key), fn _ -> Register.new(to_string(value)) end)
    end

    def get_crdt_value(value) when is_binary(value) do
        Register.new(to_string(value))
    end

     def get_crdt_value(value) when is_integer(value) do
        Register.new(to_string(value))
    end

     def get_crdt_value(value) when is_list(value) do
        Enum.reduce(value, Set.new, fn(x, acc) -> acc |> Set.put(x) end)
    end

     def get_crdt_value(value) when is_map(value) do
         nested_map = from_struct(value)
       Enum.reduce(nested_map, Map.new, fn({k, v}, map) -> 
          map |> Map.put(to_string(k), get_crdt_value(v))
        end)
    end

     def get_crdt_value(value) when is_boolean(value) do
        cond do
            value -> Flag.new |> Flag.enable
            !value -> Flag.new |> Flag.disable    
        end
    end

end