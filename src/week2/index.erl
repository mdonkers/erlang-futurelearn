-module(index).
-export([get_file_contents/1,show_file_contents/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)


% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
  {ok,File} = file:open(Name,[read]),
  Rev = get_all_lines(File,[]),
  FilteredLines = remove_punct_caps(lists:reverse(Rev)),
  combine(lists:flatten(get_words(FilteredLines,1))).

combine(Words) ->
  Fun      = fun(Key) -> {Key,proplists:get_all_values(Key,Words)} end,
  lists:map(Fun,proplists:get_keys(Words)).


get_words([], _LineNr) ->
  [];
get_words([X|Xs],LineNr) ->
  [convert_words_from_line(filter_common(string:tokens(X, " ")), LineNr) | get_words(Xs, LineNr + 1)].

convert_words_from_line([], _LineNr) ->
  [];
convert_words_from_line([X|Xs], LineNr) ->
  [{X, LineNr}|convert_words_from_line(Xs, LineNr)].

filter_common([]) ->
  [];
filter_common([X|Xs]) ->
  case string:len(X) > 2 of
    true ->
      [X|filter_common(Xs)];
    false ->
      filter_common(Xs)
  end.

remove_punct_caps([]) ->
  [];
remove_punct_caps([X|Xs]) ->
  [nocaps(nopunct(X)) | remove_punct_caps(Xs)].

% Remove punctuation
nopunct([]) ->
    [];
nopunct([X|Xs]) ->
    case lists:member(X,".,;:-\t\n\'\"\\") of
	true ->
	    nopunct(Xs);
	false ->
	    [ X | nopunct(Xs) ]
    end.


% change all to smallcaps
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


% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File,Partial) ->
  case io:get_line(File,"") of
    eof -> file:close(File),
           Partial;
    Line -> {Strip,_} = lists:split(length(Line)-1,Line),
            get_all_lines(File,[Strip|Partial])
  end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
  io:format("~s~n",[L]),
  show_file_contents(Ls);
show_file_contents([]) ->
  ok.    


