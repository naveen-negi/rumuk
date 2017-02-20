defmodule Paraaz.Notification do
 alias Riak.CRDT.Map   
 alias Riak.CRDT.Register   
 alias Riak.CRDT.Set  

    # def new(belongs_to, type, id, category_fields) do
    #     user = Register.new(belongs_to)
    #     category = Register.new(type)
    #     id = Register.new(id)

    #     Map.new
    #     |>Map.put("user-id", user) 
    #     |>Map.put("category-type", category)
    #     |>Map.put("notification-id", id)
    #     |>Map.put("category-fields", category_fields)
    # end

    def new(:declined, belongs_to, category_type, category_fields) do
        
         user_id = Register.new(belongs_to)
        category = Register.new(category_type)
        
        category_fields = create_category_fields(:declined, category_fields)
        
        id_raw = belongs_to <> category_type <> to_string(:os.system_time(:seconds))

        id = Register.new(id_raw)

        map = Map.new
                |>Map.put("user-id", user_id) 
                |>Map.put("category-type", category)
                |>Map.put("notification-id", id)
                |>Map.put("category-fields", category_fields)

        %{id: id_raw, notification: map}
    end

    defp create_category_fields(:declined, category_fields) do
        sender = Register.new(category_fields.sender)
        Map.new 
        |> Map.put("sender", sender)
    end
end