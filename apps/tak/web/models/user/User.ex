defmodule Tak.User do
     alias Tak.User.{BasicInfo, EducationalDetails}
    defstruct  id: nil, basic_info: %Tak.User.BasicInfo{}, educational_details: %Tak.User.EducationalDetails{}
    
    
    def new(id) do
        %Tak.User{id: id}
    end

    def update(user, %BasicInfo{} = data)  do
        # IO.puts "=====================basic info data =============="
        # IO.inspect data
        %Tak.User{user | basic_info: data}
    end

    def update(user, %EducationalDetails{} = data)  do
        %Tak.User{user | educational_details: data}
    end
end