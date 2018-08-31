defmodule Bhaduli.User.EducationalDetails do
  defstruct graduation: nil, senior_secondary: nil, intermediate: nil

  def new(educational_details) do
    struct(Bhaduli.User.EducationalDetails, educational_details)
  end
end
