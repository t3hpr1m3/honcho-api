defmodule HonchoApi.Models.ClientTest do
  use ExUnit.Case

  for field <- ~w(name address1 city state zip) do
    test "requires " <> field do
      changeset = %HonchoApi.Client{} |> HonchoApi.Client.changeset()
      refute changeset.valid?
      assert Dict.has_key?(changeset.errors, String.to_atom(unquote(field)))
    end
  end
end
