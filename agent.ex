# Agent Sample
{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn m -> Map.put(m, :hello, :world) end)
IO.puts(Agent.get(pid, fn m -> Map.get(m, :noooo) end)) # Got nothing
IO.puts(Agent.get(pid, fn m -> Map.get(m, :hello) end)) # Got world
IO.puts(Agent.get(pid, fn m -> Map.get(m, :hello) end)) # Got world
Agent.stop(pid)
IO.puts(Agent.get(pid, fn m -> Map.get(m, :hello) end)) # Agent not found -> Error
