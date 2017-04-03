%%%-------------------------------------------------------------------
%%% @author Miel Donkers
%%% @copyright (C) 2017, codecentric
%%% @doc
%%%
%%% @end
%%% Created : 2017-03-03 15:15:33.671554
%%%-------------------------------------------------------------------
-module(assignment).

-export([perimiter/1,enclose/1,bits/1]).


perimiter({square, B, H}) ->
  (2 * B) + (2 * H);
perimiter({circle, R}) ->
  math:pi() * 2 * R;
perimiter({triangle, B, H}) ->
  B + H + math:sqrt(math:pow(B,2) + math:pow(H,2)).

enclose({square, B, H}) ->
  {B, H};
enclose({circle, R}) ->
  {R * 2, R * 2};
enclose({triangle, B, H}) ->
  {B, H}.

bits(X) ->
  SEED = find_highest_bit(X, 1),
  io:fwrite("Found seed: ~w~n", [SEED]),
  count_bits(X, SEED, 0).

find_highest_bit(X, SEED) when (X - SEED) =< 0 ->
  SEED;
find_highest_bit(X, SEED) ->
  find_highest_bit(X, SEED * 2).

count_bits(0, _SEED, C) ->
  C;
count_bits(X, SEED, C) when (X - SEED) >= 0 ->
  count_bits(X - SEED, SEED div 2, C + 1);
count_bits(X, SEED, C) ->
  count_bits(X, SEED div 2, C).

