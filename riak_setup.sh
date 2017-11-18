#!/usr/bin/env bash
bin=~/riak-2.2.3/bin
RIAK_HOST=http://localhost:8098

$bin/riak-admin bucket-type create users '{"props":{"datatype":"map"}}'
riak-admin bucket-type activate users

$bin/riak-admin bucket-type create notifications '{"props":{"datatype":"map"}}'
riak-admin bucket-type activate notifications

$bin/riak-admin bucket-type create sets '{"props":{"datatype":"set"}}'
riak-admin bucket-type activate sets

$bin/riak-admin bucket-type create bucketmap '{"props":{"datatype":"map"}}'
riak-admin bucket-type activate bucketmap

$bin/riak-admin bucket-type create counters '{"props":{"datatype":"counter"}}'
riak-admin bucket-type activate counters

$bin/riak-admin bucket-type create notification-users '{"props":{"datatype":"map"}}'
riak-admin bucket-type activate notification-users

$bin/riak-admin bucket-type status users
$bin/riak-admin bucket-type status notification-users
$bin/riak-admin bucket-type status notifications

curl -XPUT $RIAK_HOST/search/index/users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'
