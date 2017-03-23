defmodule Bhaduli.User.BasicInfo do
    defstruct name: nil, age: nil, gender: nil
    def new(basic_info) do
        %Bhaduli.User.BasicInfo{name: basic_info.name, age: basic_info.age, gender: basic_info.gender}
    end
end