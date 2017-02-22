defmodule Paraaz.Notification do
 alias Riak.CRDT.Map   
 alias Riak.CRDT.Register   
 alias Riak.CRDT.Set  

    def new(belongs_to, category_type, category_fields) do
        
        user_id = Register.new(belongs_to)
        category = Register.new(category_type)
        
        category_fields = create_category_fields(category_fields)
        
        id_raw = belongs_to <> category_type <> to_string(:os.system_time(:seconds))

        id = Register.new(id_raw)

        map = Map.new
                |>Map.put("user_id", user_id) 
                |>Map.put("category_type", category)
                |>Map.put("notification_id", id)
                |>Map.put("category_fields", category_fields)

        %{id: id_raw, notification: map}
    end

    # def new(:invitation_received, belongs_to, category_type, category_fields) do
            
    #         user_id = Register.new(belongs_to)
    #         category = Register.new(category_type)
            
    #         category_fields = create_category_fields(category_fields)
            
    #         id_raw = belongs_to <> category_type <> to_string(:os.system_time(:seconds))

    #         id = Register.new(id_raw)

    #         map = Map.new
    #                 |>Map.put("user_id", user_id) 
    #                 |>Map.put("category_type", category)
    #                 |>Map.put("notification_id", id)
    #                 |>Map.put("category_fields", category_fields)

    #         %{id: id_raw, notification: map}
    #     end

    # def new(:message_received, belongs_to, category_type, category_fields) do
                
    #             user_id = Register.new(belongs_to)
    #             category = Register.new(category_type)
                
    #             category_fields = create_category_fields(category_fields)
                
    #             id_raw = belongs_to <> category_type <> to_string(:os.system_time(:seconds))

    #             id = Register.new(id_raw)

    #             map = Map.new
    #                     |>Map.put("user_id", user_id) 
    #                     |>Map.put("category_type", category)
    #                     |>Map.put("notification_id", id)
    #                     |>Map.put("category_fields", category_fields)

    #             %{id: id_raw, notification: map}
    # end
    def new(:user_activated, belongs_to, category_type) do
                
                user_id = Register.new(belongs_to)
                category = Register.new(category_type)
                
                id_raw = belongs_to <> category_type <> to_string(:os.system_time(:seconds))

                id = Register.new(id_raw)

                map = Map.new
                        |>Map.put("user_id", user_id) 
                        |>Map.put("category_type", category)
                        |>Map.put("notification_id", id)

                %{id: id_raw, notification: map}
    end

    # defp create_category_fields(category_fields) do
    #     sender = Register.new(category_fields.sender)
    #     Map.new 
    #     |> Map.put("sender-id", sender)
    # end

     def create_category_fields(category_fields) do

      Enum.reduce(category_fields, Map.new, fn({k, v}, map) -> 
          map |> Map.put(to_string(k), Register.new(v))
        end)

    end

    # defp create_category_fields(:message_received, category_fields) do
    #     sender = Register.new(category_fields.sender)
    #     content = Register.new(category_fields.content)

    #     Map.new 
    #     |> Map.put("sender-id", sender)
    #     |> Map.put("content", content)

    # end
end