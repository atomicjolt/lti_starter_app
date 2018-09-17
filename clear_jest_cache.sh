#!/bin/bash

SUCCESS=true

cd ./client && for dir in apps/*
do
  cd "$dir"
  jest --version
  jest --clearCache
  cd ../..
done

$SUCCESS
