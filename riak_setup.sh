#!/usr/bin/env bash
bin=~/riak-2.2.3/bin
RIAK_HOST=http://localhost:8098

curl -XPUT $RIAK_HOST/search/index/users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'

curl -XPUT $RIAK_HOST/search/index/test-users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'

curl -XPUT $RIAK_HOST/search/index/bhaduli-users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'

$bin/riak-admin bucket-type create users '{"props":{"datatype":"map"}}'
$bin/riak-admin bucket-type activate users

$bin/riak-admin bucket-type create notifications '{"props":{"datatype":"map"}}'
$bin/riak-admin bucket-type activate notifications

$bin/riak-admin bucket-type create sets '{"props":{"datatype":"set"}}'
$bin/riak-admin bucket-type activate sets

$bin/riak-admin bucket-type create bucketmap '{"props":{"datatype":"map"}}'
riak-admin bucket-type activate bucketmap

$bin/riak-admin bucket-type create counters '{"props":{"datatype":"counter"}}'
$bin/riak-admin bucket-type activate counters

$bin/riak-admin bucket-type create notification-users '{"props":{"datatype":"map"}}'
$bin/riak-admin bucket-type activate notification-users

#test buckets
$bin/riak-admin bucket-type create test-notification-users '{"props":{"datatype":"map"}}'

$bin/riak-admin bucket-type activate test-notification-users

$bin/riak-admin bucket-type create test-users '{"props":{"datatype":"map"}}'
$bin/riak-admin bucket-type update test-users '{"props":{"search_index":"test-users"}}'
$bin/riak-admin bucket-type activate test-users

$bin/riak-admin bucket-type create bhaduli-users '{"props":{"datatype":"map"}}'
$bin/riak-admin bucket-type update bhaduli-users '{"props":{"search_index":"bhaduli-users"}}'
$bin/riak-admin bucket-type activate bhaduli-users

$bin/riak-admin bucket-type create test-notifications '{"props":{"datatype":"map"}}'
$bin/riak-admin bucket-type activate test-notifications

$bin/riak-admin bucket-type status users
$bin/riak-admin bucket-type status notification-users
$bin/riak-admin bucket-type status notifications

curl -XPUT $RIAK_HOST/search/index/users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'

curl -XPUT $RIAK_HOST/search/index/test-users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'

curl -XPUT $RIAK_HOST/search/index/bhaduli-users \
     -H 'Content-Type: application/json' \
     -d '{"schema":"_yz_default"}'
