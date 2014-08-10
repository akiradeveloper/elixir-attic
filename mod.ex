defmodule MyMod do
  def task(%{name: name, deps: list}) do # can't give list [] as the default value
    IO.puts(name)
    IO.puts(list)
  end

  def myfun(a, b) do
    IO.puts "a:#{a}, b:#{b}"
  end

  def task(name, list \\ []) do
    task(%{name: name, deps: list})
  end

  def run do
    task("task1") 
  end

  defmacro __using__(opts) do
    quote do
      import MyMod
      @tasks []
      @before_compile MyMod
    end
  end

  defmacro create_nm(nss, contents) do
    quote do
    end
  end

  defmacro tk(task, list \\ [], do: contents) do
    quote do
      1
    end
  end

  defmacro nm(name, do: block) do
    contents = []
    create_nm([name], contents)
  end

  defmacro __before_compile__(env) do
    contents = []
    create_nm([], contents)
  end

  defmacro f(do: block) do
    __ENV__ |> inspect |> IO.puts
    quote do
      # var!(hoge) = 123
      # Macro.escape(IO.puts "hoge:#{hoge}")
      unquote(block)
    end
  end

  defmacro g1(hoge, do: block) do
    quote do
      IO.puts "g call hoge:#{unquote(hoge)}"
      unquote(block)
    end
  end

  defmacro g2(do: block) do
    quote do
      IO.puts "g call hoge:#{hoge}"
      unquote(block)
    end
  end
end

# MyMod.myfun([1,2])
MyMod.run

m = defmodule MyTasks do
  use MyMod

  # var!(hoge) = 321
  var!(hoge) = 321
  hige = 10000
  f do
    # g1 hoge do
    # end
  end

  # g2 do
  # end

  IO.puts("compile") # run at compilation
  MyMod.task("task_fun"); # same

  task_t = { :task, name: "tk1", deps: ["tk2", "tk3"], namespace: [], contents: fn () -> end }
  desc_t = { :desc, contents: "Elixir is fun(ctional programming language)" }

  # Having imported MyMod we can access
  # taskmac without module specifier.
  # We don't need () here
  tk "tk1"  do
  end

  tk "tk2", ["tk1"] do # tk
  end

  e = nm "nm1" do
    tk "tk3", ["tk1", "tk2"] do # nm1::tk3
    end
  end
  IO.puts inspect e

  nm "nm2" do
    nm "nm3" do # nm_2::nm_3
      tk "tk4" do # nm2::nm3::tk4
      end
    end
  end

  IO.puts inspect __ENV__.functions
  IO.puts inspect __ENV__.macros
  IO.puts inspect __ENV__.line
end

IO.puts inspect m
IO.puts inspect Macro.prewalk(m, [], &{&1, [&1|&2]}) #|> elem(1) 
