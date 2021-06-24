defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :start_date, non_null(:string)
    field :end_date, non_null(:string)
    field :exercises, list_of(:exercise)
  end

  input_object :create_training_input do
    field :user_id, non_null(:uuid4), description: "Users id"
    field :start_date, non_null(:string), description: "Start date of training"
    field :end_date, non_null(:string), description: "End date of training"
    field :exercises, non_null(:create_exercise_input), description: "Exercises list"
  end
end