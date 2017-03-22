defmodule Tak.UserRepository do
     alias Ghuguti
     alias Riak.CRDT.Map, as: M
     @bucket_type "maps"
     @bucket_name "users"

    def save(user) do
          user
          |> Ghuguti.to_crdt
          |> Riak.update(@bucket_type, @bucket_name, user.user_id)
    end

    def get(user_id) do
        case Riak.find(@bucket_type,@bucket_name,user_id)  do
           nil  -> {:not_found, "user not found"}
           user -> user
                    |> M.value 
                    |> Ghuguti.to_model(Tak.User)
        end
    end

    def update(:basic_info, id, params) do
        user = Riak.find(@bucket_type, @bucket_name, id) 
                    |> M.value 
                    |> Ghuguti.to_model(Tak.User)
        
        info  = Enum.reduce(params, user.basic_info,
                 fn {key, value}, acc -> Map.put(acc, key, value) end)
      
       Map.put(user, :basic_info, info)
       |> Ghuguti.to_crdt
       |>  Riak.update(@bucket_type, @bucket_name, user.user_id)
    end

    def update(:educational_details, id, params) do
        user = Riak.find(@bucket_type, @bucket_name, id) 
                    |> M.value 
                    |> Ghuguti.to_model(Tak.User)
        
        info  = Enum.reduce(params, user.educational_details,
                 fn {key, value}, acc -> Map.put(acc, key, value) end)
      
       Map.put(user, :educational_details, info)
       |> Ghuguti.to_crdt
       |>  Riak.update(@bucket_type, @bucket_name, user.user_id)
    end
end