defmodule SamplePortNodeTest do
  use ExUnit.Case
  doctest SamplePortNode

  test "greets the world" do
    assert SamplePortNode.hello() == :world
  end
end
