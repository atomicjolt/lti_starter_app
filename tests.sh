#!/bin/bash

SUCCESS=true

cd ./client
for dir in apps/*
do
  pushd "$dir"
  yarn test || SUCCESS=false
  popd
done

cd ./common
echo "common"
yarn test --passWithNoTests || SUCCESS=false

$SUCCESS
