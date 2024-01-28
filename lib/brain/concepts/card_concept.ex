defmodule Brain.Concepts.CardConcept do
  alias Brain.Concepts.Concept
  alias Brain.Flashcards.Flashcard
  use Ecto.Schema
  import Ecto.Changeset

  schema "card_concept" do
    field :flashcard_id, :integer
    field :concept_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card_concept, attrs) do
    card_concept
    |> cast(attrs, [:flashcard_id, :concept_id])
    |> validate_required([:flashcard_id, :concept_id])
  end
end
