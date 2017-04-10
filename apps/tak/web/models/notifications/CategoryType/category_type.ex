defmodule Tak.Notifications.CategoryType do
    defstruct [:value]

    #declare a type
    @type t :: %Tak.Notifications.CategoryType{}
    #and then use it in the interface method
    @callback type :: Tak.CategoryType.t
end