defmodule Mod do
  # byte = 0..255
  @spec myfunc(byte) :: byte
  def myfunc(x) do
    x * 2
  end
end

IO.puts Mod.myfunc(2)
IO.puts Mod.myfunc(1024) # OK. not warned by compiler. only helps tools like Dialyzer
