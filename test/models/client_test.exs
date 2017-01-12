defmodule HonchoApi.Models.ClientTest do
  use ExUnit.Case
  import HonchoApi.Factory

  for field <- ~w(name address1 city state zip) do
    test "requires " <> field do
      changeset = %HonchoApi.Client{} |> HonchoApi.Client.changeset()
      refute changeset.valid?
      assert Dict.has_key?(changeset.errors, String.to_atom(unquote(field)))
    end
  end

  test "requires a proper zip code" do
    changeset = %HonchoApi.Client{} |> HonchoApi.Client.changeset(params_for(:client, zip: "abc"))
    refute changeset.valid?
    assert Dict.has_key?(changeset.errors, :zip)
  end
end
