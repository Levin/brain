defmodule Brain.Repo.Migrations.CreateCardConcept do
  use Ecto.Migration

  def change do
    create table(:card_concept) do

      add :flashcard_id, references(:flashcard)
      add :concept_id, references(:concept)

      timestamps(type: :utc_datetime)
    end
  end
end
