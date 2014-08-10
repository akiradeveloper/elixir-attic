defmodule MyMod do

  defmacro __using__(opts) do
    quote do
      import MyMod
      @tasks []
      @before_compile MyMod
    end
  end

  defmacro __before_compile__(env) do
  end

  def task(%{name: name, deps: list}) do # can't give list [] as the default value
    IO.puts(name)
    IO.puts(list)
  end

  def task(name, list \\ []) do
    task(%{name: name, deps: list})
  end

  defmacro tk(task, list \\ [], do: contents) do
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
  tk "tk1"  do
  end

  tk("tk2", ["tk1"]) do # tk
  end

  nm "nm1" do
    tk "tk3", ["tk1", "tk2"] do # nm1::tk3
    end
  end

  nm "nm2" do
    nm "nm3" do # nm_2::nm_3
      tk "tk4" do # nm2::nm3::tk4
      end
    end
  end
end
