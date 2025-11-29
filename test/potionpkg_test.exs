defmodule PotionpkgTest do
  use ExUnit.Case
  doctest Potionpkg

  test "greets the world" do
    assert Potionpkg.hello() == :world
  end
end
