defmodule Convertor.CrdtToModel do
alias Riak.CRDT.Map, as: M
    
    def to_model(crdt, kind) do
        model = reduce_map(crdt)
        struct(kind, model)
    end

    def reduce_map(map) do
         keys =  :orddict.fetch_keys(map)

       model = Enum.reduce( keys, %{}, fn(x, acc) -> 
                 :maps.put(trim_key(x), 
                 get_value(x, map), acc) end)
    end

     defp get_value({value, type} = key , map) when type==:map do
        :orddict.fetch(key, map)
         |> reduce_map
    end

     defp get_value(key, map) do
       :orddict.fetch(key, map)
    end

     def trim_key(key) do
       case key do
           {value, :register} -> String.to_atom(value)
           {value, :counter} -> String.to_atom(value)
           {value, :set} -> String.to_atom(value)
           {value, :flag} -> String.to_atom(value)
           {value, :map} -> String.to_atom(value)
       end 
    end
end