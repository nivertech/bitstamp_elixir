defmodule BitstampTest do
  use ExUnit.Case

  setup_all do
    {:ok, pid: 
      Bitstamp.start_link(self(), struct(Bitstamp.Credentials, Application.get_env(:bitstamp, :credentials)))
    }
  end

  test "orderbook", state do
    {:ok, pid} = state[:pid]
    {:ok, result} = GenServer.call(pid, {:order_book}, 10000)
  end

  test "account balance", state do
    {:ok, pid} = state[:pid]
    {:ok, result} = GenServer.call(pid, {:balance}, 10000)
  end

  test "buy limit order", state do
    {:ok, pid} = state[:pid] 
    {:ok, result} = GenServer.call(pid, {:buy_limit_order, [[amount: "0.1", price: "100.0", limit_price: "105.34"]]}, 10000)
    IO.inspect result
  end

  test "sell limit order", state do
    {:ok, pid} = state[:pid] 
    {:ok, result} = GenServer.call(pid, {:sell_limit_order, [[amount: "0.1", price: "123456.7", limit_price: "123456.0"]]}, 10000)
  end
end
