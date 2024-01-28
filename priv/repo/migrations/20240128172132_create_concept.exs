defmodule Brain.Repo.Migrations.CreateConcept do
  use Ecto.Migration

  def change do
    create table(:concept) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end
  end
end
