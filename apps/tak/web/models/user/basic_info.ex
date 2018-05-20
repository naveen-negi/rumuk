defmodule Tak.User.BasicInfo do

defstruct name: nil, age: nil, gender: nil

def new(params) do
  Map.merge(new(), params)
end

def new do
  %Tak.User.BasicInfo{}
end


end
