-module(freq_supervisor).
-export([start/0,stop/0]).
-export([init/0]).

start() ->
  register(freq_supervisor, spawn(freq_supervisor, init, [])).

stop() ->
  freq_supervisor ! stop.

init() ->
  process_flag(trap_exit, true),
  FrequencyPid = startFrequencyServer(),
  loop(FrequencyPid).

startFrequencyServer() ->
  FrequencyPid = spawn_link(frequency, init, []),
  register(frequency, FrequencyPid),
  FrequencyPid.

loop(FrequencyPid) ->
  receive
    stop ->
      io:format("Supervisor stopped");
    {'EXIT', FrequencyPid, _Reason} ->
      NewPid = startFrequencyServer(),
      loop(NewPid)
  end.
