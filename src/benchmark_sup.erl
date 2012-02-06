-module(benchmark_sup).

-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	{ok, Pools} = application:get_env(benchmark, pools),
	PoolSpecs = lists:map(fun({PoolName, PoolConfig}) ->
	    Args = [{name, {local, PoolName}},
	            {worker_module, benchmark_worker}]
	            ++ PoolConfig,
	    {PoolName, {poolboy, start_link, [Args]},
	                permanent, 5000, worker, [poolboy]}
	end, Pools),
	{ok, {{one_for_one, 10, 10}, PoolSpecs}}.
