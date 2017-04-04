defmodule Bhaduli.User do
    use GenServer
    alias Bhaduli.User.{BasicInfo, EducationalDetails}

    defstruct [user_id: nil, basic_info: %Bhaduli.User.BasicInfo{}, educational_details: %Bhaduli.User.EducationalDetails{}]

    def start_link(name) do
        IO.puts "inside user start link"
     GenServer.start_link(__MODULE__,name, name: via_tuple(String.to_atom(name)))
    end

    def init(name) do
        {:ok, %Bhaduli.User{user_id: name}}
    end

    def update(pid, %BasicInfo{} = basic_info) do
        
        GenServer.cast(pid, {:update_basic_info, basic_info})
    end

    def update(pid, %EducationalDetails{} = educational_details) do
        GenServer.cast(pid, {:update_educational_details, educational_details})
    end

    def get_basic_info(pid) do
        GenServer.call(pid, {:basic_info})
    end

    def get_educational_details(pid) do
        GenServer.call(pid, {:educational_details})
    end

    def get(pid) do
        GenServer.call(pid, {})
    end

    def handle_cast({:update_basic_info, basic_info}, user) do
        user = %Bhaduli.User{user | basic_info: basic_info}
        {:noreply, user}
    end

    def handle_cast({:update_educational_details, educational_details}, user) do
        user = %Bhaduli.User{user | educational_details: educational_details}
        {:noreply, user}
    end

    def handle_call({:basic_info}, pid, state) do
          {:reply, state.basic_info, state}
    end

    def handle_call({:educational_details}, pid, state) do
          {:reply, state.educational_details, state}
    end

    def handle_call({}, pid, state) do
          {:reply, state, state}
    end

    def via_tuple(user_id) do
         {:via, Registry, {:user_process_registry, user_id}}
    end
end