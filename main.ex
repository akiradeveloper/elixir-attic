a = [1,2,3]
[x|y] = a
IO.puts "x:#{x}, y:#{inspect y}"
# [x|[y|[]]] = a # never match
[x|[y|rest]] = a
IO.puts "x:#{inspect x}, y:#{y}, rest:#{inspect rest}" 

defmodule Fib do
  def run(1) do
    1
  end
  def run(x) do
    x + run(x-1)
  end
end

require Integer
for n <- 1..10, Integer.odd?(n), Integer.even?(n), do: IO.puts Fib.run(n) # print nothing
