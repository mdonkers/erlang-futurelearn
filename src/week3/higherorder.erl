%%%-------------------------------------------------------------------
%%% @author Miel Donkers
%%% @copyright (C) 2017, codecentric
%%% @doc
%%%
%%% @end
%%% Created : 2017-04-04 08:24:26.264894
%%%-------------------------------------------------------------------
-module(higherorder).

-import(lists, [map/2, filter/2, foldr/3]).

%% Application callbacks
-export([doubleAll/1, evens/1, product/1, zip/2, zip_with/3]).

doubleAll(List) ->
  map(fun (X) -> X * 2 end, List).

evens(List) ->
  filter(fun (X) -> X rem 2 == 0 end, List).

product(List) ->
  foldr(fun (Comb, Acc) -> Comb * Acc end, 1, List).

zip([], _) ->
  [];
zip(_, []) ->
  [];
zip([X1|Xs1], [X2|Xs2]) ->
  [ {X1, X2} | zip(Xs1, Xs2) ].

%zip_with1(_Fun, [], _List2) ->
%  [];
%zip_with1(_Fun, _List1, []) ->
%  [];
%zip_with1(Fun, [X|Xs], [Y|Ys]) ->
%  [Fun(X, Y) | zip_with1(Fun, Xs, Ys)].

zip_with(Fun, Xs, Ys) ->
  map(fun ({X,Y}) -> Fun(X,Y) end, zip(Xs, Ys)).

