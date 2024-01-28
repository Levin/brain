defmodule Brain.BrainScript do

  def user_prompt() do
    IO.puts("This is the user manual: ")
    IO.puts("'f add' <- lets you create a new flashcard")
    IO.puts("'f del' <- lets you delete an existing flashcard")
    IO.puts("'f' <- lists all existing s")
    
    choice = IO.gets("") |> cleanup(false)

    case choice do
      "f add" -> add_flashcard()
      "f del" -> delete_flashcard!()
      "f" -> list_flashcards()
    end

    quit? = IO.gets("If your done here, just hit 'q': ") |> cleanup(false)
    case quit? do
      "q" -> IO.puts("Good job today!")
      _ -> user_prompt()
    end
  end
 
  def add_flashcard() do
    front = IO.gets("what should the front of your flashcard look like?\n") |> cleanup(false)
    back = IO.gets("what should the back of your flashcard look like?\n") |> cleanup(false)

    Brain.Flashcards.create_flashcard(%{front: front, back: back})

    Brain.Flashcards.list_flashcards()
  end

  def list_flashcards() do
    flashcards = Brain.Flashcards.list_flashcards()

    for card <- flashcards do
      IO.puts("#{card.id}")
      IO.puts("#{card.front}")
      IO.puts("#{card.back}")
    end
  end

  def delete_flashcard!() do
    id = IO.gets("which flashcard should be deleted?\n") |> cleanup(true)
    Brain.Flashcards.remove_flashcard!(id)
  end

  defp cleanup(word, false) do
  
    word
    |> String.trim()
    |> String.split("\n")
    |> List.first()

  end

  defp cleanup(word, true) do
    word
    |> String.trim()
    |> String.split("\n")
    |> List.first()
    |> String.to_integer()
  end


end

Brain.BrainScript.user_prompt()
