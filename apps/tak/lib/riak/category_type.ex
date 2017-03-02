defmodule Tak.CategoryType do
    defstruct [:value]

    #declare a type
    @type t :: %Tak.CategoryType{}
    #and then use it in the interface method
    @callback type :: Tak.CategoryType.t
end