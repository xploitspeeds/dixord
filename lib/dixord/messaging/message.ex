defmodule Dixord.Messaging.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field(:content, :string)
    belongs_to(:user, Dixord.Accounts.User)
    belongs_to(:chat, Dixord.Messaging.Chat)

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
