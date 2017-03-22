defmodule Convertor.ModelToCrdt do
    import Map, only: [from_struct: 1]
    alias Riak.CRDT.{Map, Register, Flag, Set, Counter}
    
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
       flag =  cond do
                    value -> Flag.new |> Flag.enable
                    !value -> Flag.new |> Flag.disable    
                end
       Map.update(map, :flag, to_string(key), fn _ -> flag end)
    end

      defp update_field(map, key, value) when is_integer(value) do
          IO.puts "it is interger yeaah"
       Map.update(map, :counter, to_string(key), fn _ -> Counter.new |> Counter.increment(value) end)
    end

    defp update_field(map, key, value) when is_binary(value) do
       Map.update(map, :register, to_string(key), fn _ -> Register.new(to_string(value)) end)
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