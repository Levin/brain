defmodule Brain.Concepts.Concept do
  alias Brain.Flashcards.Flashcard
  use Ecto.Schema
  import Ecto.Changeset

  schema "concept" do
    field :title, :string

    timestamps(type: :utc_datetime)

    many_to_many :flashcard, Flashcard, join_through: "card_concept" # I'm new!
  end

  @doc false
  def changeset(concept, attrs) do
    concept
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
