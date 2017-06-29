defmodule Bhaduli.UserRepository do
     alias Riak.CRDT.Map, as: M
     alias Bhaduli.User
     @bucket_type "maps"
     @bucket_name "users"

    def save(user) do
          user
          |> Ghuguti.to_crdt
          |> Riak.update(@bucket_type, @bucket_name, user.user_id)
    end

    def get(user_id) do
        case Riak.find(@bucket_type,@bucket_name,user_id)  do
           nil  -> {:error, "user not found"}
            user -> user = user
                            |> M.value 
                            |> Ghuguti.to_model(User)
                    {:ok, user}
        end
    end

    def update(:basic_info, id, params) do
        user = Riak.find(@bucket_type, @bucket_name, id) 
                    |> M.value 
                    |> Ghuguti.to_model(User)

        Riak.delete(@bucket_type, @bucket_name, id)

        info  = Enum.reduce(params, user.basic_info,
                 fn {key, value}, acc -> Map.put(acc, key, value) end)
       Map.put(user, :basic_info, info)
       |> Ghuguti.to_crdt
       |>  Riak.update(@bucket_type, @bucket_name, user.user_id)
    end

    def update(:educational_details, id, params) do
        user = Riak.find(@bucket_type, @bucket_name, id) 
                    |> M.value 
                    |> Ghuguti.to_model(User)
        info  = Enum.reduce(params, user.educational_details,
                 fn {key, value}, acc -> Map.put(acc, key, value) end)
       Map.put(user, :educational_details, info)
       |> Ghuguti.to_crdt
       |>  Riak.update(@bucket_type, @bucket_name, user.user_id)
    end

    def search(query) do
      defaults = %{min_age: 0, max_age: 100, gender: "*"}
      params = Map.merge(defaults, query)
      riak_query = "basic_info_map.gender_register:#{params[:gender]} AND basic_info_map.age_counter:[#{params[:min_age]} TO #{params[:max_age]}]"
      IO.inspect riak_query
      results = Riak.Search.query("users",  riak_query)
      IO.inspect results
      results
    end
end
