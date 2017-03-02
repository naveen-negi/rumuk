defmodule Paraaz.CategoryType do
    defstruct [:value]

    #declare a type
    @type t :: %Paraaz.CategoryType{}
    #and then use it in the interface method
    @callback type :: Paraaz.CategoryType.t
end