#!/bin/sh
APP=benchmark
cd `dirname $0`
exec erl -smp auto +K true +A 16 -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -s $APP $@
