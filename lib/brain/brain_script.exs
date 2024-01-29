defmodule Brain.BrainScript do

  def user_prompt() do
    IO.puts("\n\n\n\n")
    IO.puts("\tThis is the user manual: ")
    IO.puts("\t'f add' <- lets you create a new flashcard")
    IO.puts("\t'f del' <- lets you delete an existing flashcard")
    IO.puts("\t'f' <- lists all existing flashcards")
    IO.puts("\t'ask' <- prompts the user with flashcards")
    IO.puts("\t'ask 'concept/topic'' <- prompts the user with flashcards")
    IO.puts("\t'q'  <- exit from here")
    IO.puts("\n\n\n\n\n")
    
    choice =
      IO.gets("\t") 
      |> cleanup(false)

    case choice do
      "f add" -> 
        add_flashcard()
        user_prompt()
      "f del" ->
        delete_flashcard!()
        user_prompt()
      "f" -> 
        list_flashcards()
        user_prompt()
      "ask" ->
        ask_flashcards(String.split(choice, " "))
        user_prompt()
      "ask" <> _ -> 
        ask_flashcards(String.split(choice, " "))
        user_prompt()
      _ -> quit()
    end

  end

  def ask_flashcards([_, topic]) do
    Brain.CardsConcepts.get_flashcards_for_topic(topic)
    |> Enum.each(fn pair -> promt_flashcard(pair) end)
  end

  def ask_flashcards(_) do
    Brain.Flashcards.get_random_flashcard_collection()
    |> Enum.each(fn pair -> promt_flashcard(pair) end)
  end
 

  def add_flashcard() do
    IO.puts("\twhat should the front of your flashcard look like?\n")
    front = 
      IO.stream(:stdio, :line)
      |> Stream.take_while(&(&1 != ":done\n"))
      |> Enum.to_list()
      |> Enum.join(" ")

    IO.puts("\twhat should the back of your flashcard look like?\n")
    back = 
      IO.stream(:stdio, :line)
      |> Stream.take_while(&(&1 != ":done\n"))
      |> Enum.to_list()
      |> Enum.join(" ")

    Brain.Flashcards.create_flashcard(%{front: front, back: back})

    Brain.Flashcards.list_flashcards()
  end

  def list_flashcards() do
    Brain.Flashcards.list_flashcards()
    |> Enum.map(fn flashcard -> {flashcard.id, flashcard.front, flashcard.back} end)
    |> Enum.each(fn card -> promt_flashcard(card) end)
  end

  def delete_flashcard!() do
    id = IO.gets("\twhich flashcard should be deleted?\n") |> cleanup(true)
    Brain.Flashcards.remove_flashcard!(id)
  end

  def quit() do
    IO.puts("Well done today!!")
  end

  defp promt_flashcard({"", front, back}) do
    IO.puts("\t#{front}\n")

    continue? = IO.gets("\t")

    if(continue? == "\n") do
      IO.puts("\t#{back}\n")
    end

    # TODO: give rating
    #rating = 
    #  IO.gets("\t(h,m,e): \n")
    #  |> cleanup(false)
    # TODO: increase count
  end

  defp promt_flashcard({id, front, back}) when is_integer(id) do
    IO.puts("\tID: #{id}\n")
    IO.puts("\tFront: #{front}\n")

    continue? = IO.gets("\t")

    if(continue? == "\n") do
      IO.puts("\tBack: #{back}\n")
    end

    #rating = IO.gets("\t(h,m,e): \n")

    # TODO: increase count
    # TODO: give rating

  end
  defp promt_flashcard({topic, front, back}) when is_binary(topic) do
    IO.puts("\tTopic:\n #{topic}\n")
    IO.puts("\tFront #{front}\n")

    continue? = IO.gets("\t")

    if(continue? == "\n") do
      IO.puts("\tBack #{back}\n")
    end

    #rating = IO.gets("\t(h,m,e): \n")

    # TODO: increase count
    # TODO: give rating

  end

  defp cleanup(word, false) do
  
    word
    |> String.trim()
    |> String.replace("\n", "")

  end

  defp cleanup(word, true) do
    word
    |> String.trim()
    |> String.replace("\n", "")
    |> String.to_integer()
  end
end

Brain.BrainScript.user_prompt()
