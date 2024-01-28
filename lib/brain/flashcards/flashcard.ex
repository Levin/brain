defmodule Brain.Flashcards.Flashcard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flashcard" do
    field :front, :string
    field :back, :string
    field :count, :integer, default: 0


    timestamps()

  end
  

  def changeset(flashcard, attrs \\ %{}) do
    flashcard
    |> cast(attrs, [:front, :back, :count])
    |> validate_required([:front, :back])

    
  end

end
