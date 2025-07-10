#! /usr/bin/env bash
echo "Cleaning local environment..."
sudo rm -rf redis_data postgres_data localstack_data n8n_data

docker-compose -f deployment/compose.yaml --project-directory . down --volumes --remove-orphans