#!/usr/bin/env bash
rm mix.lock
mix deps.get
mix deps.compile
