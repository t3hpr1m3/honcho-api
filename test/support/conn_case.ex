defmodule HonchoApi.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use HonchoApi.ConnTest
      import HonchoApi.ConnCaseHelper
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(HonchoApi.Repo)
  end
end
