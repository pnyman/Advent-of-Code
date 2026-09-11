-module(day_01).
-export([main/0]).

main() ->
    {ok, Binary} = file:read_file("../input/day-01.txt"),
    Chars = binary_to_list(Binary),
    Trimmed = string:trim(Chars),
    Floor = lists:foldl(fun count_char/2, 0, Trimmed),
    io:format("Part 1:  ~p~n", [Floor]),
    Pos = find_basement_position(Trimmed),
    io:format("Part 2: ~p~n", [Pos]).

count_char($(, Acc) -> Acc + 1;
count_char($), Acc) -> Acc - 1;
count_char(_, Acc) -> Acc.

find_basement_position(Chars) ->
    find_basement_position(Chars, 0, 0).
find_basement_position([], _, _) ->
    -1; % hittade aldrig källaren
find_basement_position([Char | Rest], Floor, Pos) ->
    NewFloor = count_char(Char, Floor),
    NewPos = Pos + 1,
    case NewFloor of
        -1 -> NewPos;
        _ -> find_basement_position(Rest, NewFloor, NewPos)
    end.
