-module(benchmark_handler).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Any, http}, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
    Worker = poolboy:checkout(pool1),
    Reply = gen_server:call(Worker, get),
    poolboy:checkin(pool1, Worker),
	{ok, Req2} = cowboy_http_req:reply(200, [], Reply, Req),
	{ok, Req2, State}.

terminate(_Req, _State) ->
	ok.
