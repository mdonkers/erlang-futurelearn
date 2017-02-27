%%%-------------------------------------------------------------------
%%% @author Miel Donkers
%%% @copyright (C) 2017, codecentric
%%% @doc
%%%
%%% @end
%%% Created : 2017-02-24 22:35:28.902733
%%%-------------------------------------------------------------------
-module(second).

%% Application callbacks
-export([hypotenuse/2,maxThree/3,howManyEqual/3]).

hypotenuse(A,B) ->
  math:sqrt(first:square(A) + first:square(B)).

maxThree(A,B,C) ->
  max(A,max(B,C)).

howManyEqual(A,A,A) ->
  3;
howManyEqual(A,A,_) ->
  2;
howManyEqual(A,_,A) ->
  2;
howManyEqual(_,A,A) ->
  2;
howManyEqual(_,_,_) ->
  0.

