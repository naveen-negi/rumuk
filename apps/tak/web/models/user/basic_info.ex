defmodule Tak.BasicInfo do
use Ecto.Schema
import Ecto.Changeset

  schema "basic_info" do
    field :name, :string
    field :age, :integer
    field :contact_number, :integer
    field :dob, :integer
    field :city, :string
    field :hometown, :string
    belongs_to :user, Tak.User
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:name, :age, :contact_number, :dob, :city, :hometown, :user_id])
    |> validate_required([:name, :age])
  end

end
