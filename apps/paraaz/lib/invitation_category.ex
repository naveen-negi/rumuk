defmodule Paraaz.InvitationCategory do
    
    alias Riak.CRDT.Map
    alias Riak.CRDT.Register

    def new(sender) do
        sender_id = Register.new(sender)

         Map.new
        |>Map.put("sender-id", sender_id) 
        
    end
end