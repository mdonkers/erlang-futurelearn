%% Based on code from 
%%   Erlang Programming
%%   Francecso Cesarini and Simon Thompson
%%   O'Reilly, 2008
%%   http://oreilly.com/catalog/9780596518189/
%%   http://www.erlangprogramming.org/
%%   (c) Francesco Cesarini and Simon Thompson

-module(frequency).
-export([start/0,allocate/0,deallocate/1,stop/0,clear/0]).
-export([init/0]).

%% These are the start functions used to create and
%% initialize the server.

start() ->
    register(frequency,
	     spawn(frequency, init, [])).

init() ->
  Frequencies = {get_frequencies(), []},
  loop(Frequencies).

% Hard Coded
get_frequencies() -> [10,11,12,13,14,15].

%% The Main Loop

loop(Frequencies) ->
  receive
    {request, Pid, Tag, allocate} ->
      timer:sleep(5000),
      {NewFrequencies, Reply} = allocate(Frequencies, Pid),
      Pid ! {reply, Tag, Reply},
      loop(NewFrequencies);
    {request, Pid , Tag, {deallocate, Freq}} ->
      timer:sleep(5000),
      NewFrequencies = deallocate(Frequencies, Freq),
      Pid ! {reply, Tag, ok},
      loop(NewFrequencies);
    {request, Pid, Tag, clear} ->
      clear_mailbox(),
      Pid ! {reply, Tag, cleared},
      loop(Frequencies);
    {request, Pid, Tag, stop} ->
      Pid ! {reply, Tag, stopped}
  end.

%% Functional interface

allocate() -> 
    clear_mailbox(),
    Tag = make_ref(),
    frequency ! {request, self(), Tag, allocate},
    receive 
	    {reply, Tag, Reply} -> Reply
    after 1000 ->
            timeout
    end.

deallocate(Freq) -> 
    clear_mailbox(),
    Tag = make_ref(),
    frequency ! {request, self(), Tag, {deallocate, Freq}},
    receive 
	    {reply, Tag, Reply} -> Reply
    after 1000 ->
            timeout
    end.

stop() -> 
    Tag = make_ref(),
    frequency ! {request, self(), Tag, stop},
    receive 
	    {reply, Tag, Reply} -> Reply
    end.

clear() ->
    Tag = make_ref(),
    frequency ! {request, self(), Tag, clear},
    receive
              {reply, Tag, Reply} -> Reply
    end.


%% The Internal Help Functions used to allocate and
%% deallocate frequencies.

allocate({[], Allocated}, _Pid) ->
  {{[], Allocated}, {error, no_frequency}};
allocate({[Freq|Free], Allocated}, Pid) ->
  {{Free, [{Freq, Pid}|Allocated]}, {ok, Freq}}.

deallocate({Free, Allocated}, Freq) ->
  NewAllocated=lists:keydelete(Freq, 1, Allocated),
  {[Freq|Free],  NewAllocated}.

clear_mailbox() ->
  receive
    _Msg -> io:format("Removed one msg~n"), clear_mailbox()
  after 0 ->
    io:format("Finished clearing mailbox~n")
  end.

