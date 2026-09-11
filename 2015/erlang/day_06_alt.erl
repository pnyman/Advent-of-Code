-module(foo).
-export([main/0]).

main() ->
    Input = readlines("../input/day-06.txt"),
    {ok, Regex} = re:compile("^(toggle|turn on|turn off) (\\d+),(\\d+) through (\\d+),(\\d+)"),
    Tab = ets:new(grid, [set]),
    lists:foreach(fun(Line) -> do_range(Tab, parse_line(Line, Regex)) end, Input),
    Part1 = ets:foldl(fun({_K, on}, Acc) -> Acc + 1; (_, Acc) -> Acc end, 0, Tab),
    ets:delete(Tab),
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

do_range(Tab, {Action, [X1, Y1, X2, Y2]}) ->
    [perform_action(Tab, Action, X, Y)
     || X <- lists:seq(X1, X2), Y <- lists:seq(Y1, Y2)],
    ok.

perform_action(Tab, Action, X, Y) ->
    CurrentState = case ets:lookup(Tab, {X, Y}) of
        [{_, S}] -> S;
        []       -> off
    end,
    NewState = case Action of
        toggle when CurrentState =:= on -> off;
        toggle -> on;
        turn_on -> on;
        turn_off -> off
    end,
    ets:insert(Tab, {{X, Y}, NewState}).
