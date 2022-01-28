defmodule DropletStore.Users do
  alias Ueberauth.Auth

  def email_from_auth(%Auth{info: %{email: email}}), do: email
end
