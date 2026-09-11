-module(day_06).
-export([main/0]).

main() ->
    Input = readlines("../input/day-06.txt"),
    {ok, Regex} = re:compile("^(toggle|turn on|turn off) (\\d+),(\\d+) through (\\d+),(\\d+)"),
    Grid = lists:foldl(fun(Line, G) -> do_range(G, parse_line(Line, Regex)) end,
                        #{{0,0} => off}, Input),
    Part1 = length(lists:filter(fun(X) -> X =:= on end, maps:values(Grid))),
    io:fwrite("Part 1: ~p~n", [Part1]).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    Lines = binary:split(Data, [~"\r\n", ~"\n"], [global, trim_all]),
    [binary_to_list(L) || L <- Lines].

parse_line(Line, Regex) ->
    case re:run(Line, Regex,
                [{capture, all_but_first, binary}]) of
        {match, [Action, X1, Y1, X2, Y2]} ->
            Coords = [binary_to_integer(N) || N <- [X1, Y1, X2, Y2]],
            {action_to_atom(Action), Coords}
    end.

action_to_atom(~"toggle")   -> toggle;
action_to_atom(~"turn on")  -> turn_on;
action_to_atom(~"turn off") -> turn_off.

do_range(Grid, {Action, [X1, Y1, X2, Y2]}) ->
    Coords = [{X, Y} || X <- lists:seq(X1, X2), Y <- lists:seq(Y1, Y2)],
    lists:foldl(fun({X, Y}, G) -> perform_action(G, Action, X, Y) end, Grid, Coords).

perform_action(Grid, Action, X, Y) ->
    CurrentState = maps:get({X, Y}, Grid, off),  %% default = off om nyckeln saknas
    NewState = case Action of
        toggle when CurrentState =:= on -> off;
        toggle -> on;
        turn_on -> on;
        turn_off -> off
    end,
    maps:put({X, Y}, NewState, Grid).
