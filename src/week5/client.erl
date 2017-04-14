-module(client).
-export([start/1,stop/1]).
-export([init/1]).

start(Delay) ->
  spawn(client, init, [Delay]).

stop(Pid) ->
  Pid ! stop.

init(Delay) ->
  loop(Delay).

loop(Delay) ->
  receive
    stop -> io:format("Stopping client with Pid ~w~n", [self()])
  after Delay ->
          {ok, Frequency} = frequency:allocate(),
          io:format("Allocated for Pid ~w: ~w~n", [self(), Frequency]),
          timer:sleep(Delay),
          frequency:deallocate(Frequency),
          io:format("Deallocated for Pid ~w: ~w~n", [self(), Frequency]),
          loop(Delay)
  end.
