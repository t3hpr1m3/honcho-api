defmodule HonchoApi.Route do
  defmacro __using__(_) do
    quote do
      use Plug.Router

      plug :match
      plug :dispatch
      plug Plug.Parsers,
        parsers: [:json],
        pass: ["application/json"],
        json_decoder: Poison

      def render(conn, template, data, status \\ 200) do
        body = view_module.render(template, data) |> Poison.encode!
        conn |> send_resp(status, body)
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
