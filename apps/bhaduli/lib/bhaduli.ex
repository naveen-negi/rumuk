defmodule Bhaduli do
    use Application

    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
            supervisor(Registry, [:unique, :user_process_registry])
        ]

         opts = [strategy: :one_for_one, name: Bhaduli.Supervisor]
         Supervisor.start_link(children, opts)
    end
end