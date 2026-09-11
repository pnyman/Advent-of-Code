-module(day_02).
-export([main/0]).

main() ->
    Input = readlines("../input/day-02.txt"),
    {TotalArea, TotalRibbon} =
        lists:foldl(
            fun(Line, {AreaAcc, RibbonAcc}) ->
                Dimensions = parse_dimensions(Line),
                {AreaAcc + calculate_area(Dimensions),
                 RibbonAcc + calculate_ribbon(Dimensions)}
            end,
            {0, 0},
            Input
        ),
    io:fwrite("Area: ~p, Ribbon: ~p~n", [TotalArea, TotalRibbon]).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [~"\r\n", ~"\n"], [global, trim_all]).

parse_dimensions(Line) ->
    [binary_to_integer(X) || X <- binary:split(Line, ~"x", [global])].

calculate_area([L, W, H]) ->
    Sides = [L * W, W * H, H * L],
    2 * lists:sum(Sides) + lists:min(Sides).

calculate_ribbon(Dimensions) ->
    M = lists:sum(Dimensions) - lists:min(Dimensions),
    2 * M + lists:foldl(fun(X, Prod) -> X * Prod end, 1, Dimensions).
