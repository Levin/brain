defmodule Brain.Flashcards do

  import Ecto.Query, warn: false

  alias Brain.Flashcards
  alias Brain.Concepts.CardConcept
  alias Brain.Repo
  alias Brain.Flashcards.Flashcard
  

  def list_flashcards() do
    Repo.all(Flashcard)
  end


  def recall_todays_flashcards() do
    today = 
      Date.utc_today()
      |> Date.to_string()

    boundary_bottom = today <> " 00:00:00"
    boundary_top = today <> " 23:59:59"

    query = from f in Flashcard,
      where: f.inserted_at <= ^boundary_top and f.inserted_at >= ^boundary_bottom,
      select: {"", f.front, f.back}

      Repo.all(query)
  end

  def get_flashcard_by_front(front) do
    Repo.all(Flashcard)
    |> Enum.reject(fn card -> String.jaro_distance(card.front, front) <= 0.85  end)
    |> Enum.map(fn card -> {"", card.front, card.back} end)
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

  def update_flashcard!(id) do
    Flashcard
    |> where(id: ^id)
    |> Repo.update_all(inc: [count: 1])
  end

  def update_flashcard(front) do
    Flashcard
    |> where(front: ^front)
    |> Repo.update_all(inc: [count: 1])
  end

  def remove_flashcard!(id) do

    query = 
      from cc in CardConcept, 
      where: cc.flashcard_id == ^id

    Repo.delete_all(query)

    from(f in Flashcard, where: f.id == ^id) 
    |> Repo.delete_all()

  end
  
end
