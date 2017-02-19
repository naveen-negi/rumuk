defmodule Paraaz.Notification do
 alias Riak.CRDT.Map   
 alias Riak.CRDT.Register   

    def new(belongs_to, type) do
        user = Register.new(belongs_to)
        
        category = Register.new(type)

        Map.new
        |>Map.put("user", user) 
        |>Map.put("category", category)
    end
end