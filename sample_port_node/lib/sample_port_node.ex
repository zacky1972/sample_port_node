defmodule SamplePortNode do
  @moduledoc """
  Documentation for `SamplePortNode`.
  """

  use GenServer
  require Logger

  @node :sample_port_node_host

  def start_link(cookie) do
    GenServer.start_link(__MODULE__, cookie)
  end

  defp set_cookie(cookie) when is_atom(cookie), do: cookie

  defp set_cookie([]) do
    :rand.uniform()
    |> Float.to_string()
    |> then(&:crypto.hash(:sha256, &1))
    |> Base.encode16(case: :lower)
    |> String.to_atom()
  end

  @impl true
  def init(cookie) do
    cookie = set_cookie(cookie)

    case Node.alive?() do
      false -> init_node(cookie)
      true -> :ok
    end
    |> case do
      :ok -> init_port(cookie)
      _ -> {:error, cookie}
    end
  end

  defp init_node(cookie) do
    case Node.start(@node, :shortnames) do
      {:ok, _pid} ->
        :ok

      _ ->
        System.cmd("epmd", ["-daemon"])
        Logger.notice("epmd -daemon")

        case Node.start(@node, :shortnames) do
          {:ok, _pid} -> :ok
          _ -> :error
        end
    end
    |> case do
      :ok ->
        Logger.notice("successfully Node.start")
        Node.set_cookie(cookie)
        :ok

      :error ->
        :error
    end
  end

  def init_port(cookie) do
    {:ok, cookie}
  end
end
