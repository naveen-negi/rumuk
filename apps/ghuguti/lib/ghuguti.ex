defmodule Ghuguti do
alias Convertor.{ModelToCrdt, CrdtToModel}

def to_model(crdt, kind) do
    CrdtToModel.to_model(crdt, kind)
end

def to_crdt(model) do
    ModelToCrdt.to_crdt(model)
end
end
