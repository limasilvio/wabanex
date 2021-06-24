defmodule WabanexWeb.Resolvers.Training do
  Wabanex.Trainings.Create
  def create(%{input: params}, _context) do
    Create.call(params)
  end
end
