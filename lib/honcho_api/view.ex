defmodule HonchoApi.View do
  defmacro __using__(_) do
    quote do
      def render("error", %{changeset: changeset}) do
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {k, v}, acc ->
            String.replace(acc, "%{#{k}}", to_string(v))
          end)
        end)
        %{errors: errors}
      end
    end
  end
end
