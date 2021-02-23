#!/bin/sh
set -e

# Start nginx in the background
nginx

# A positive integer generally in the 2-4 x $(NUM_CORES) range.
WORKER_PROCESSES=${WORKERS:-2}

echo "Starting TCE Prediction Tool with" ${WORKER_PROCESSES} worker processes.
if [ "${WORKER_PROCESSES}" != "1" ]; then
  WORKER_FLAG="--workers ${WORKER_PROCESSES}"
fi

gunicorn --preload --bind 0.0.0.0:5010 --timeout 5000 --log-level info ${WORKER_FLAG} wsgi:app
