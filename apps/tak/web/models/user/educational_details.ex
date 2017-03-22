defmodule Tak.EducationalDetails do
    defstruct graduation: nil, senior_secondary: nil, intermediate: nil

    def new(educational_details) do
        struct(Tak.EducationalDetails, educational_details)
    end
end