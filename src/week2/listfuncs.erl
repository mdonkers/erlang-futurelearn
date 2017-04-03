%%%-------------------------------------------------------------------
%%% @author Miel Donkers
%%% @copyright (C) 2017, codecentric
%%% @doc
%%%
%%% @end
%%% Created : 2017-03-05 10:11:43.464037
%%%-------------------------------------------------------------------
-module(listfuncs).

%% Application callbacks
-export([product/1,listmax/1,double/1,evens/1,nub/1]).

product(Xs) ->
  product(Xs, 1).

product([], S) ->
  S;
product([X|Xs], S) ->
  product(Xs, S*X).

listmax(Xs) ->
  listmax(Xs, 0).

listmax([], Max) ->
  Max;
listmax([X|Xs], Max) ->
  listmax(Xs, max(Max, X)).

double([]) ->
  [];
double([X|Xs]) ->
  [X*2|double(Xs)].

evens([]) ->
  [];
evens([X|Xs]) ->
  case X rem 2 of
    0 ->
      [X|evens(Xs)];
    _ ->
      evens(Xs)
  end.

nub(Xs) ->
  nub(Xs, []).

nub([], L) ->
  lists:reverse(L);
nub([X|Xs], L) ->
  case lists:member(X, L) of
    true ->
      nub(Xs, L);
    _ ->
      nub(Xs, [X|L])
  end.
