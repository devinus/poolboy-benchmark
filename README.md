A super flawed Poolboy benchmark using Cowboy and a simple worker, probably
benchmarking Cowboy harder than Poolboy.

The pool size is 500 workers with a max overflow of another 500.

    $ make get-deps
    $ make
    $ ./start.sh
    $ ab -k -n1000000 -c20 http://127.0.0.1:9001/
    $ ab -k -n1000000 -c50 http://127.0.0.1:9001/
    $ ab -k -n1000000 -c100 http://127.0.0.1:9001/
    $ ab -k -n1000000 -c200 http://127.0.0.1:9001/
    $ ab -k -n1000000 -c500 http://127.0.0.1:9001/
