defmodule Paraaz.CategoryType.MessageReceived do
  @behaviour Paraaz.CategoryType

  def type do
    %Paraaz.CategoryType{value: "message_received"}
  end
end
