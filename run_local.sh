#! /usr/bin/env bash
mkdir -p deployment/n8n_data/custom/node_modules
rm -rf deployment/n8n_data/custom/node_modules/n8n_nodes_Lib
cp -R /Users/simonjaramillovelez/NU1009002_N8N_MR/n8n_nodes_Lib/. deployment/n8n_data/custom/node_modules/
docker compose -f deployment/compose.yaml --project-directory . up --build