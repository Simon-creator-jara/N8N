# !/bin/bash
echo "Starting n8n worker..."
docker build -f ./deployment/Dockerfile.local -t my-n8n-worker-image .
PORT=5679
for i in $(seq 1 5); do
  docker run -d --name "n8n-worker-"$i \
    --network n8n-local \
    --restart always \
    --env-file ./.env \
    -p $PORT:5678 my-n8n-worker-image
  PORT=$((PORT + 1))
done