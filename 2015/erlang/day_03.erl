-module(day_03).
-export([main/0]).

main() ->
    {ok, Binary} = file:read_file("../input/day-03.txt"),
    Chars = string:trim(binary_to_list(Binary)),

    Start = {0, {0, 0}, {0, 0}, {0, 0}, [{0, 0}], [{0, 0}]},
    {_Turn, _Single, _Santa, _Robo, Part1Houses, Part2Houses} =
        lists:foldl(fun step/2, Start, Chars),

    io:fwrite("Part 1: ~p~n", [length(lists:uniq(Part1Houses))]),
    io:fwrite("Part 2: ~p~n", [length(lists:uniq(Part2Houses))]).

step(Ch, {Turn, Single, Santa, Robo, P1Houses, P2Houses}) ->
    NewSingle = move(Single, Ch),
    case Turn rem 2 =:= 0 of
        true ->
            NewSanta = move(Santa, Ch),
            {Turn + 1, NewSingle, NewSanta, Robo,
             [NewSingle | P1Houses], [NewSanta | P2Houses]};
        false ->
            NewRobo = move(Robo, Ch),
            {Turn + 1, NewSingle, Santa, NewRobo,
             [NewSingle | P1Houses], [NewRobo | P2Houses]}
    end.

move({X, Y}, $>) -> {X + 1, Y};
move({X, Y}, $<) -> {X - 1, Y};
move({X, Y}, $^) -> {X, Y + 1};
move({X, Y}, $v) -> {X, Y - 1}.
