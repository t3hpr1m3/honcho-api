defmodule HonchoApi.Route do
  defmacro __using__(_) do
    quote do
      use Plug.Router

      plug :match
      plug :dispatch

      def render(conn, template, data) do
        body = view_module.render(template, data) |> Poison.encode!
        conn |> send_resp(200, body)
      end

      def view_module() do
        mod = __MODULE__
          |> to_string
          |> String.split(".")
          |> List.last
          |> Kernel.<>("View")
        Module.concat(HonchoApi.Views, mod)
      end
    end
  end
end
