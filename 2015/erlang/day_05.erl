-module(day_05).
-export([main/0, is_nice/1, has_vowels/1, has_forbidden/1, has_repeated/1, has_intermixed/1, has_non_overlapping/1]).

%% main() ->
%%     Input = readlines("../input/day-05.txt"),
%%     Nice = lists:filter(fun is_nice/1, Input),
%%     length(Nice).

main() ->
    Input = readlines("../input/day-05.txt"),
    Part1 = length([S || S <- Input, is_nice(S)]),
    Part2 = length([S || S <- Input, is_nice_2(S)]),
    io:fwrite("Part 1: ~p~n", [Part1]),
    io:fwrite("Part 2:  ~p~n", [Part2]).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    Lines = binary:split(Data, [~"\r\n", ~"\n"], [global, trim_all]),
    [binary_to_list(L) || L <- Lines].

is_nice(S) ->
    has_vowels(S) andalso has_repeated(S) andalso not has_forbidden(S).

has_vowels(S) ->
    Vowels = [C || C <- S, lists:member(C, [$a, $e, $i, $o, $u])],
    length(Vowels) >= 3.

has_repeated([A, A | _]) -> true;
has_repeated([_ | Rest]) -> has_repeated(Rest);
has_repeated([]) -> false.

has_forbidden(S) ->
    Forbidden = ["ab", "cd", "pq", "xy"],
    lists:any(fun(Sub) -> string:find(S, Sub) =/= nomatch end, Forbidden).

is_nice_2(S) ->
    has_intermixed(S) andalso has_non_overlapping(S).

has_intermixed([A, _, A | _]) -> true;
has_intermixed([_ | Rest]) -> has_intermixed(Rest);
has_intermixed([]) -> false.

has_non_overlapping(S) ->
    re:run(S, "(..).*\\1") =/= nomatch.
