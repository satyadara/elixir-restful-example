defmodule ZeldaTest do
  use ExUnit.Case
  doctest Zelda

  test "greets the world" do
    assert Zelda.hello() == :world
  end
end
