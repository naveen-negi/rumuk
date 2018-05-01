defmodule Convertor.ModelToCrdt do
    import Map, only: [from_struct: 1, has_key?: 2]
    alias Riak.CRDT.{Map, Register, Flag, Set, Counter}
    
    def to_crdt(model) when is_map(model) do
      IO.puts "******** inside to_crdt map --> start *******"
      IO.inspect model
      IO.puts "******** inside to_crdt map *--> end ******"
        from_struct(model)
        |> Enum.reduce(Map.new, fn({k, v}, map) -> 
                map |> Map.put(to_string(k), get_crdt_value(v))
        end)
    end
    
     def update_crdt(crdt, [key, value] = map) do
        {key_name, key_type} = get_crdt_key(crdt, to_string(key))
         value = get_crdt_value(value)
        Map.update(crdt, key_type, key_name, fn _ -> value end)
    end


     def get_crdt_value(value) when is_integer(value) do
       Counter.new |> Counter.increment(value) 
    end

    def get_crdt_value(value) when is_binary(value) or is_nil(value) do
        cond do
            value != nil -> Register.new(to_string(value))
            value == nil -> Register.new(to_string(""))
        end
    end

     def get_crdt_value(value) when is_list(value) do
      IO.puts "***** inside crdt to list start ******"
      IO.inspect value
      IO.puts "***** inside crdt to list end ******"

         value 
         |> Enum.filter(fn(x) -> x != nil end)
        |> Enum.reduce(Set.new, fn(x, acc) -> acc |> Set.put(x) end)
    end

     def get_crdt_value(value) when is_map(value) do
        
          nested_map = if has_key?(value, :__struct__), do: from_struct(value), else: value
                        
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
    
      defp get_crdt_key(map, key) do
         cond  do
            map |> Map.has_key?({key, :register}) -> {key, :register}
            map |> Map.has_key?({key, :counter})-> {key, :counter}
            map |> Map.has_key?({key, :set}) -> {key, :set}
            map |> Map.has_key?({key, :flag}) -> {key, :flag}
            map |> Map.has_key?({key, :map}) -> {key, :map}
       end 
    end

end
