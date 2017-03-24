defmodule Bhaduli.User do
    
    defstruct [user_id: nil, basic_info: %Bhaduli.User.BasicInfo{}, educational_details: %Bhaduli.User.EducationalDetails{}]

    def new(id) do
        %Bhaduli.User{user_id: id}
    end

    def update(user, %Bhaduli.User.EducationalDetails{graduation: _, senior_secondary: _, intermediate: _} = educational_details) do
        %{user | educational_details: educational_details}
    end

    def update(user, %Bhaduli.User.BasicInfo{name: _, age: _, gender: _} = basic_info) do
        %{user | basic_info: basic_info}
    end
end