defmodule Bhaduli.UserSupervisor do
    use Supervisor

    def start_link do
        Supervisor.start_link(__MODULE__,nil, name: :user_sup)
    end

    def start_user(name) do
        Supervisor.start_child(:user_sup, [name])
    end

    def init(_) do
        children = [worker(Bhaduli.User, [])]
        supervise(children, strategy: :simple_one_for_one)
    end
end