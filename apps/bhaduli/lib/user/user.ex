defmodule Bhaduli.User do
    use GenServer
    alias Bhaduli.User.{BasicInfo, EducationalDetails}
    @registry :user_process_registry

    defstruct [user_id: nil, basic_info: %Bhaduli.User.BasicInfo{}, educational_details: %Bhaduli.User.EducationalDetails{}]

    def start_link(name) do
     GenServer.start_link(__MODULE__,name, name: via_tuple(name))
    end

    def init(name) do
        {:ok, %Bhaduli.User{user_id: name}}
    end

    def update(id, %BasicInfo{} = basic_info) do
        [{pid, _}] = Registry.lookup(@registry, id)
        GenServer.cast(pid, {:update_basic_info, basic_info})
    end

    def update(id, %EducationalDetails{} = educational_details) do
        [{pid, _}] = Registry.lookup(@registry, id)
        GenServer.cast(pid, {:update_educational_details, educational_details})
    end

    def get_basic_info(id) do
        [{pid, _}] = Registry.lookup(@registry, id)
        GenServer.call(pid, {:basic_info})
    end

    def get_educational_details(id) do
         [{pid, _}] = Registry.lookup(@registry, id)
        GenServer.call(pid, {:educational_details})
    end

    def get(id) do
        [{pid, _}] = Registry.lookup(@registry, id)
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