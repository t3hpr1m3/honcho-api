defmodule HonchoApi.Factory do
  use ExMachina.Ecto, repo: HonchoApi.Repo

  def client_factory do
    %HonchoApi.Client{
      name: "CustomerX",
      address1: "123 My Street",
      address2: "Box 321",
      city: "My Town",
      state: "TN",
      zip: "12345"
    }
  end
end
