a = [1,2,3] # list
[x|y] = a
IO.puts "x:#{x}, y:#{inspect y}" # use inspect to print complex structures
# [x|[y|[]]] = a # never match
[x|[y|rest]] = a # pattern match on list
IO.puts "x:#{inspect x}, y:#{y}, rest:#{inspect rest}" 

defmodule Fib do
  def run(1) do
    1
  end
  # Attributes are usually used as tag.
  # We can use attributes even as constant.
  # We can define our own new attributes such as mydesc.
  # Some reserved attributes (@doc, @moduledoc) are interpreted as compiler in defined ways.
  @mydesc "run fibonacci"
  def run(x \\ 100) do # default argument // 
    x + run(x-1)
  end
end

IO.puts "run(4): #{Fib.run(4)}"
IO.puts "run(): #{Fib.run()}"

# If you need some "macros" in the module in compilation time
# require the module. odd?/1 and even?/1 are macros here.
require Integer

# importing a module automatically requires it.
import Integer, [only: :functions] 

IO.puts "is_atom?: #{is_atom(String)}"
IO.puts "to_string: #{Kernel.to_string(String)}"

# comprehension (generator and guard)
for n <- 1..10, Integer.odd?(n), Integer.even?(n), do: IO.puts Fib.run(n) # print nothing

# With into: option we can type the return value as specified.
# <<xxx::n>> is used here to specify the size of each chunk (Maybe..)
IO.puts inspect for n <- 1..10, do: <<Fib.run(n)::size(8)>>, into: ""

l = [1, "a", 'a'] # list can holds differenct types
kl = [a: 1, b: 2] # keyword list
m = %{"a" => 1, :a => 2} # map
m2 = %{ m | "a" => 3 }
km = %{a: 1, b: 2} # when all the keys are atoms (keyword map?)
km2 = %{ km | a: 3 }

# if-else (or unless-else) is an expression
x = unless false do 1 else 2 end
IO.puts(x)

# if is a macro passing 2 arguments
y = if(true, [do: :this, else: :that])
IO.puts(y)

# Arithmetics
IO.puts(100/7) # (/) :: float -> float
IO.puts(div(100,7)) # div :: int -> int
IO.puts(rem(100,7)) # rem :: int -> int


f = fn x -> x * 2 end
IO.puts(f.(2)) # Anonymous function needs dot before argments

# Can't define function outside module
# def g(x) do
#   x * 2
# end

h = &(&1 * 2) # Another form of anonymous function
IO.puts(h.(2))

IO.puts(inspect self()) # My pid
IO.puts(__MODULE__) #

IO.puts inspect :lists.flatten [1,[2],3] # modules are atoms
IO.puts inspect List.flatten [1,[2],3]
IO.puts inspect Elixir.List.flatten [1,[2],3]
IO.puts inspect :Elixir.List.flatten [1,[2],3]
IO.puts Kernel.to_string(List)

defmodule Person do
  defstruct name: ""
end

IO.puts Kernel.to_string Person
# %Person{} # [BUG] Why can I access Person struct?

# Sigil (An inscribed or painted symbol considered to have magical power)
# sigil_r "foo", 'i' # no function clause matching in Kernel.sigil_r/2
sigil_r <<"foo">>, 'i'
