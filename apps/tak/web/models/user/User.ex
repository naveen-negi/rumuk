defmodule Tak.User do
     alias Tak.{BasicInfo, EducationalDetails}
    defstruct  id: nil, basic_info: %Tak.BasicInfo{}, educational_details: %Tak.EducationalDetails{}
    
    
    def new(id) do
        %Tak.User{id: id}
    end

    def update(user, %Tak.BasicInfo{} = data)  do
        %Tak.User{user | basic_info: data}
    end

    def update(user, %Tak.EducationalDetails{} = data)  do
        %Tak.User{user | educational_details: data}
    end
end