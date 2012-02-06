-module(benchmark).

-behaviour(application).
-export([start/0, start/2, stop/1]).

start() ->
    application:start(benchmark).

start(_Type, _Args) ->
    application:start(cowboy),
    Dispatch = [
		{'_', [
			{'_', benchmark_handler, []}
		]}
	],
	cowboy:start_listener(benchmark, 1000,
		cowboy_tcp_transport, [{port, 9001}],
		cowboy_http_protocol, [{dispatch, Dispatch}]
	),
    benchmark_sup:start_link().

stop(_State) ->
    ok.
