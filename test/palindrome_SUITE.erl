%%%-------------------------------------------------------------------
%%% @author Miel Donkers
%%% @copyright (C) 2017, codecentric
%%% @doc
%%%
%%% @end
%%% Created : 2017-03-10 07:54:38.141035
%%%-------------------------------------------------------------------
-module(palindrome_SUITE).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

-define(PROPTEST(M,F), true = proper:quickcheck(M:F())).

%% API
-export([all/0]).

%% test cases
-export([
         %% test case names go here
         palindrome_test/1
        ]).


all() ->
    [
     %% Group names here e.g. {group, crud}
     palindrome_test
    ].

%%%===================================================================
%%% Individual Test Cases (from groups() definition)
%%%===================================================================

palindrome_test(_Config) ->
  ?assertEqual(where3:palindrome("Madam I\'m Adam."),true).

