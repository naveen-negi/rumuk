defmodule Tak.User do
    
    defstruct [user_id: nil, notifications: nil, basic_info: %Tak.BasicInfo{}, educational_details: %Tak.EducationalDetails{}]

    def new(id) do
        %Tak.User{user_id: id}
    end

    def update(user, %Tak.EducationalDetails{graduation: _, senior_secondary: _, intermediate: _} = educational_details) do
        %{user | educational_details: educational_details}
    end

    def update(user, %Tak.BasicInfo{name: _, age: _, gender: _} = basic_info) do
        %{user | basic_info: basic_info}
    end
end