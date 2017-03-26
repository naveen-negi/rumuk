defmodule Tak.User do
     use Ecto.Schema
     alias Tak.{BasicInfo, EducationalDetails}
    import Ecto.Changeset


    schema "users" do
        has_one :basic_info, BasicInfo
        has_one :educational_details, EducationalDetails
    end

    # def changeset(model,  details ) do
    #     model 
    #     |> cast(model, details)
    # end

    def changeset(model, params ) do
        model 
        |> cast(params, [])
        |> cast_assoc(:basic_info)
        |> cast_assoc(:educational_details)
        # |> put_assoc(:basic_info, params)
    end

end