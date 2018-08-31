#!/usr/bin/env bash
echo "=========================================================================================="
# . ~/kerl/18.3/activate
echo "=========================================================================================="
echo "installing riak"
cd ~
curl -O http://s3.amazonaws.com/downloads.basho.com/riak/2.2/2.2.3/osx/10.8/riak-2.2.3-OSX-x86_64.tar.gz
tar xzvf riak-2.2.3-osx-x86_64.tar.gz
