defmodule Brain.Flashcards do

  import Ecto.Query, warn: false

  alias Brain.Repo
  alias Brain.Flashcards.Flashcard
  

  def list_flashcards() do
    Repo.all(Flashcard)
  end

  def get_random_flashcard_collection() do
    # TODO: these numbers have to be more elastic
    #       maybe fetch all and then get amount x in some other way
    offset = 0 #:rand.uniform(10)
    limit = :rand.uniform(15)

    query = from f in Flashcard, 
      limit: ^limit,
      offset: ^offset,
      select: {"", f.front, f.back}

    Repo.all(query)
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
