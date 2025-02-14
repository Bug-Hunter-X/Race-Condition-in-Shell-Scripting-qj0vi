# Race Condition in Shell Scripting

This repository demonstrates a race condition that can occur in shell scripts when multiple processes access and modify a shared resource concurrently.

The `bug.sh` script shows a simple example of two jobs incrementing a counter file simultaneously.  Due to the race condition, the final counter value is often less than the expected 200.

The `bugSolution.sh` script provides a solution using a lock mechanism to prevent the race condition, ensuring the counter is incremented correctly.