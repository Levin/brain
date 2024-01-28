defmodule Brain.Flashcards do

  import Ecto.Query, warn: false

  alias Brain.Repo
  alias Brain.Flashcards.Flashcard
  

  def list_flashcards() do
    Repo.all(Flashcard)
  end

  def get_flashcard!(id) do
    Repo.get_by(Flashcard, id: id)
  end

  def create_flashcard(attrs \\ %{}) do
    %Flashcard{}
    |> Flashcard.changeset(attrs)
    |> Repo.insert()
  end

  def remove_flashcard!(id) do
    from(f in Flashcard, where: f.id == ^id) 
    |> Repo.delete_all()
  end
  
end
