defmodule Brain.Flashcards.Flashcard do
  alias Brain.Concepts.Concept
  use Ecto.Schema
  import Ecto.Changeset

  schema "flashcard" do
    field :front, :string
    field :back, :string
    field :count, :integer, default: 0


    timestamps()

    many_to_many :concept, Concept, join_through: "card_concept"
  end
  

  def changeset(flashcard, attrs \\ %{}) do
    flashcard
    |> cast(attrs, [:front, :back, :count])
    |> validate_required([:front, :back])

    
  end

end
