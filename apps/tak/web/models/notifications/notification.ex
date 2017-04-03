defmodule Tak.Notifications.Notification do
    defstruct id: nil, category_type: nil, category_fields: nil

    def new(id, category_type, category_fields) do
        %Tak.Notifications.Notification{id: id, category_type: category_type, category_fields: category_fields}
    end
end