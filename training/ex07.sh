#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: One arguments" >&2
  exit 1
fi

arg="$1"
case "$arg" in
  start)
  echo "Starting service..."
  ;;
  stop)
  echo "Stopping service..."
  ;;
  status)
  echo "Service is running"
  ;;
  restart)
  echo "Restarting service..."
  ;;
  *)
  echo "Unknown command: $arg" >&2
  exit 1
  ;;
esac
