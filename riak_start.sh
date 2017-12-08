#!/usr/bin/env bash
echo "=========================================================================================="
echo "setting up erlang version to:"
. ~/kerl/18.3/activate
erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
echo "=========================================================================================="
echo "starting riak"
~/riak-2.2.3/bin/riak start
