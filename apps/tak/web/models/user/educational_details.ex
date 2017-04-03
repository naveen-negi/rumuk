defmodule Tak.User.EducationalDetails do
    use Ecto.Schema
    import Ecto.Changeset
@derive {Poison.Encoder, only: [:graduation, :intermediate, :senior_secondary]}
  schema "educational_details" do
    field :graduation, :string
    field :intermediate, :string
    field :senior_secondary, :string
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:graduation, :intermediate, :senior_secondary])
    |> validate_required([:graduation, :intermediate, :senior_secondary])
  end
end
