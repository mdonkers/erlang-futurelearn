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
-export([doubleAll/1, evens/1, product/1]).

doubleAll(List) ->
  map(fun (X) -> X * 2 end, List).

evens(List) ->
  filter(fun (X) -> X rem 2 == 0 end, List).

product(List) ->
  foldr(fun (Comb, Acc) -> Comb * Acc end, 1, List).
