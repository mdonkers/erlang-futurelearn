%%%-------------------------------------------------------------------
%%% @author Miel Donkers
%%% @copyright (C) 2017, codecentric
%%% @doc
%%%
%%% @end
%%% Created : 2017-03-10 07:54:38.141035
%%%-------------------------------------------------------------------
-module(higherorder_SUITE).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

-define(PROPTEST(M,F), true = proper:quickcheck(M:F())).

%% API
-export([all/0]).

%% test cases
-export([
         %% test case names go here
         doubleAll_test/1,
         evens_test/1,
         product_test/1
        ]).


all() ->
    [
     %% Group names here e.g. {group, crud}
     doubleAll_test,
     evens_test,
     product_test
    ].

%%%===================================================================
%%% Individual Test Cases (from groups() definition)
%%%===================================================================

doubleAll_test(_Config) ->
  ?assertEqual(higherorder:doubleAll([1,2,3,4]), [2,4,6,8]).

evens_test(_Config) ->
  ?assertEqual(higherorder:evens([1,2,3,4,5]), [2,4]).

product_test(_Config) ->
  ?assertEqual(higherorder:product([1,2,3,4]), 24).
