-module(supervisor).
-export([start/0,stop/0]).
-export([init/0]).

start() ->
  spawn(supervisor, init, []).

stop() ->
  stop.

init() ->
  stop.
