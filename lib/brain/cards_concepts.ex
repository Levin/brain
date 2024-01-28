defmodule Brain.CardsConcepts do

  import Ecto.Query, warn: false

  alias Brain.Concepts.CardConcept
  alias Brain.Repo

  def list_connections() do
    Repo.all(CardConcept)
  end

  def get_card_concept_by_flashcard!(id) do
    Repo.get_by(CardConcept, flashcard_id: id)
  end
  def get_card_concept_by_concept!(id) do
    Repo.get_by(CardConcept, concept_id: id)
  end
  def get_concept!(id) do
    Repo.get_by(CardConcept, id: id)
  end

  def link_flashcard_to_concept(attrs \\ %{}) do
    %CardConcept{}
    |> CardConcept.changeset(attrs)
    |> Repo.insert()
  end

  def remove_concept!(id) do
    from(cc in CardConcept, where: cc.id == ^id) 
    |> Repo.delete_all()
  end

  def detach_flashcard_from_concept!(flashcard_id, concept_id) do
    from(cc in CardConcept, where: cc.flashcard_id == ^flashcard_id, where: cc.concept_id == ^concept_id)
    |> Repo.delete_all()
  end
  
end
