defmodule Mix.Tasks.HonchoApi.Server do
  require Logger

  use Mix.Task

  @shortdoc "Starts the cowboy server"

  @moduledoc """
  Does some really cool stuff
  """

  def run(args) do
    Logger.log :info, "HonchoApi starting on port #{Application.fetch_env!(:honcho_api, :port)}"
    Mix.Task.run "run", ["--no-halt"] ++ args
  end
end
