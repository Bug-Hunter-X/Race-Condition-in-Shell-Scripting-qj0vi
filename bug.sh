#!/bin/bash

# This script demonstrates a race condition in shell scripting.
# It uses two jobs running concurrently to update a shared counter file.

counter=0

job1() {
  for i in {1..100}; do
    value=$(cat counter.txt)
    (( value++ ))
    echo $value > counter.txt
  done
}

job2() {
  for i in {1..100}; do
    value=$(cat counter.txt)
    (( value++ ))
    echo $value > counter.txt
  done
}

# Start jobs concurrently
job1 &
job2 &

# Wait for both jobs to finish
wait

# Check counter value (it should be 200, but usually it's less due to race condition)
finalValue=$(cat counter.txt)
echo "Final counter value: $finalValue"