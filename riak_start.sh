#!/usr/bin/env bash
echo "=========================================================================================="
#below changes are not need as erlang version comes packaged with riak
# echo "erlang version"
# . ~/kerl/18.3/activate
# erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
echo "=========================================================================================="
echo "starting riak"
~/riak-2.2.3/bin/riak start
~/riak-2.2.3/bin/riak ping

