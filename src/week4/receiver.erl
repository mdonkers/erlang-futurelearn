-module(receiver).
-export([receiver/0,order/0]).

receiver() ->
  timer:sleep(10000),
  receive
    stop ->
      io:format("Stopping Receiver Server~n");
    Msg ->
      io:format("message:~w~n",[{ok,Msg}]),
      receiver()
  end.

order() ->
  receive
    stop ->
      io:format("Stopping Order Server~n");
    {first, Msg} ->
      io:format("First message: ~w~n", [Msg]),
      order2()
  after 10000 ->
    io:format("Anyhow cycle to order2~n"),
    order2()
  end.

order2() ->
  receive
    stop ->
      io:format("Stopping Order Server~n");
    {second, Msg} ->
      io:format("Second message: ~w~n", [Msg]),
      order()
  end.

