defmodule Paraaz.CategoryType.UserActivated do
  @behaviour Paraaz.CategoryType

  def type do
    %Paraaz.CategoryType{value: "user_activated"}
  end
end
