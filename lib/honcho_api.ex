defmodule HonchoApi do
  use Application
  import Supervisor.Spec, warn: false

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = String.to_integer(Application.fetch_env!(:honcho_api, :port))

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: HonchoApi.Worker.start_link(arg1, arg2, arg3)
      # worker(HonchoApi.Worker, [arg1, arg2, arg3]),
      Plug.Adapters.Cowboy.child_spec(:http, HonchoApi.Router, [], [port: port]),
      supervisor(HonchoApi.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HonchoApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
