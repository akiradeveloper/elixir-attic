# { tuple | atom, list, list | atom }
# tuple = another tuple in the same representation
sum_expr = {:sum, [], [1,2,3]}
IO.puts inspect sum_expr
IO.puts Macro.to_string sum_expr # sum(1,2,3)

num = 13
IO.puts inspect num
IO.puts Macro.to_string num

# quote is used to embed the right-hand variable
# to expression to be quoted
add_expr_1 = quote do: 11 + num
IO.puts inspect add_expr_1
IO.puts Macro.to_string add_expr_1 # 11 + num

add_expr_2 = quote do: 11 + unquote num
IO.puts inspect add_expr_2
IO.puts Macro.to_string add_expr_2 # 11 + 13

# unquote 1 # error: unquote outside quote
# unquote (quote do: 1) # error: unquote outside quote
# unquote (quote do: 11 + 13) # same
defmodule Dumb do # try to encapsulate in explicit macro
  defmacro mac(e) do
    quote do
      unquote e
    end
  end

  defmacro mac2 do
    IO.puts "aaaaaaaaaaaa" # (1)
    y = 777
    quote do: var!(x) = unquote y
  end

  def run do
    IO.puts mac mac 1 # (2)
    mac2
    IO.puts x # (3)
  end
end
Dumb.run

l = [3,4]

# Amazing! A == B but C != B
IO.puts Macro.to_string(quote do: [1,2,unquote(l),5]) # A
IO.puts Macro.to_string(quote do: [1,2,(unquote l),5]) # B
IO.puts Macro.to_string(quote do: [1,2,unquote_splicing(l),5]) # C
IO.puts Macro.to_string(quote do: [1,2,(unquote_splicing l),5]) # D

m = [a: 1]
Macro.escape(num)
IO.puts inspect Macro.escape(m)
IO.puts Macro.to_string quote do: [1,2,unquote Macro.escape(m)]

defmodule Unless do
  defmacro mac(clause, e) do
    x = 1 # not used but can be built
    quote do
      if(!unquote(clause), do: unquote(e))
    end
  end
  def run do
    IO.puts inspect quote do: (mac false, do: IO.puts(1))
  end
end
Unless.run

defmodule Sample do
  defmacro mac(xs) do
    Enum.map xs, fn (name) -> # Q. Enum.map create quoted expression?
      var = Macro.var(name, nil)
      length = Atom.to_string(name) |> String.length
      quote do
        unquote(var) = unquote(length)
      end
    end
  end
  def run do
    mac [:red, :green, :yellow]
    IO.puts inspect [red, green, yellow]
  end
end
Sample.run

expr = quote do: (Enum.map [1,2,3], fn (x) -> x end)
IO.puts inspect expr
IO.puts inspect Macro.expand_once expr, __ENV__
