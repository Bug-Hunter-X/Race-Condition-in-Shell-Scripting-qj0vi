#!/bin/bash

# This script demonstrates a solution to the race condition using a lock file.

counter=0
lockfile="counter.lock"

job1() {
  for i in {1..100}; do
    # Acquire lock
    flock -x "$lockfile"
    value=$(cat counter.txt)
    (( value++ ))
    echo $value > counter.txt
    # Release lock
    flock -u "$lockfile"
  done
}

job2() {
  for i in {1..100}; do
    # Acquire lock
    flock -x "$lockfile"
    value=$(cat counter.txt)
    (( value++ ))
    echo $value > counter.txt
    # Release lock
    flock -u "$lockfile"
  done
}

# Create counter file
echo 0 > counter.txt

# Start jobs concurrently
job1 &
job2 &

# Wait for both jobs to finish
wait

# Check counter value (should be 200)
finalValue=$(cat counter.txt)
echo "Final counter value: $finalValue"