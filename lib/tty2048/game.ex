defmodule Tty2048.Game do
  use GenServer

  alias Tty2048.Grid

  def start_link(size) do
    GenServer.start_link(__MODULE__, size, [name: :game])
  end

  def init(size) do
    {:ok, {Grid.make(size), 0}, 0}
  end

  def move(direction) do
    GenServer.cast(:game, {:move, direction})
  end

  def handle_cast({:move, direction}, {grid, _score}) do
    {:noreply, Grid.move({direction, grid}), 0}
  end

  def handle_info(:timeout, {grid, _score} = state) do
    Grid.format(grid)
    |> IO.write

    {:noreply, state}
  end
end
