defmodule Tak.EducationalDetails do
    use Ecto.Schema
    import Ecto.Changeset

  schema "educational_details" do
    field :graduation, :string
    field :intermediate, :string
    field :senior_secondary, :string
    belongs_to :user, Tak.User
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:graduation, :intermediate, :senior_secondary])
  end
end
