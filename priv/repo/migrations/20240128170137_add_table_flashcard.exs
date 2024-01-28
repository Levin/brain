defmodule Brain.Repo.Migrations.AddTableFlashcard do
  use Ecto.Migration

  def change do

    create table("flashcard") do
      add :front, :text
      add :back, :text
      add :count, :integer

      timestamps()
    end

  end
end
