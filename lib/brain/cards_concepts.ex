defmodule Brain.CardsConcepts do

  import Ecto.Query, warn: false

  alias Brain.Flashcards.Flashcard
  alias Brain.Concepts.Concept
  alias Brain.Concepts.CardConcept
  alias Brain.Repo

  def list_connections() do
    Repo.all(CardConcept)
  end

  def get_flashcards_for_topic(concept) do
    query = from cc in CardConcept, 
      join: c in Concept,
      on: cc.concept_id == c.id,
      join: f in Flashcard,
      on: cc.flashcard_id == f.id,
      select: {c.title, f.front, f.back}

    Repo.all(query)
    |> Enum.reject(fn {topic, _, _} -> String.jaro_distance(topic, concept) < 0.8 end)


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
