defmodule Brain.Concepts do
  
  import Ecto.Query, warn: false

  alias Brain.Concepts.Concept
  alias Brain.Repo

  def list_concepts() do
    Repo.all(Concept)
  end

  def get_concept!(id) do
    Repo.get_by(Concept, id: id)
  end

  def create_concept(attrs \\ %{}) do
    %Concept{}
    |> Concept.changeset(attrs)
    |> Repo.insert()
  end
  
  

  def remove_concept!(id) do
    from(c in Concept, where: c.id == ^id) 
    |> Repo.delete_all()
  end
end
