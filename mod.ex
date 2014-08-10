defmodule MyMod do
  defmacro __using__(opts) do
    quote do
      import MyMod
    end
  end

  def task(%{name: name, deps: list}) do # can't give list [] as the default value
    IO.puts(name)
    IO.puts(list)
  end

  def task(name, list \\ []) do
    task(%{name: name, deps: list})
  end

  defmacro taskmac(task, list \\ [], do: contents) do
  end

  defmacro nm(name, do: contents) do
  end

  def run do
    task("task1") 
  end
end

MyMod.run

defmodule MyTasks do
  use MyMod

  IO.puts("compile") # run at compilation
  MyMod.task("task_fun"); # same

  # Having imported MyMod we can access
  # taskmac without module specifier.
  # We don't need () here
  taskmac "task1"  do
  end

  MyMod.taskmac("task2", ["task1"]) do
  end

  nm "nm_1" do
    taskmac "task3", ["task1", "task2"] do
    end
  end
end
