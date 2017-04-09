-module(palin).
-export([server/0, palin/1,nopunct/1,palindrome/1]).

% palindrome problem
%
% palindrome("Madam I\'m Adam.") = true

server() ->
  receive
    stop ->
      io:format("Stopping Palindrome Server~n");
    {check, Text, Client} ->
      case palindrome(Text) of
        true ->
          Client ! {result, Text ++ " is a palindrome"};
        false ->
          Client ! {result, Text ++ " is not a palindrome"}
      end,
      server()
  end.


palindrome(Xs) ->
    palin(nocaps(nopunct(Xs))).

nopunct([]) ->
    [];
nopunct([X|Xs]) ->
    case lists:member(X,".,\ ;:\t\n\'\"") of
	true ->
	    nopunct(Xs);
	false ->
	    [ X | nopunct(Xs) ]
    end.

nocaps([]) ->
    [];
nocaps([X|Xs]) ->
    [ nocap(X) | nocaps(Xs) ].

nocap(X) ->
    case $A =< X andalso X =< $Z of
	true ->
	    X+32;
	false ->
	    X
    end.

% literal palindrome

palin(Xs) ->
    Xs == reverse(Xs).

reverse(Xs) ->
    shunt(Xs,[]).

shunt([],Ys) ->
    Ys;
shunt([X|Xs],Ys) ->
    shunt(Xs,[X|Ys]).

 
	


