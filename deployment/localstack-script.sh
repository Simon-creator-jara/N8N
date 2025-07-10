#!/bin/bash
AWS_REGION=us-east-1
AWS_DATABASE_SECRET=local-rds-secret
AWS_REDIS_SECRET=local-redis-secret
AWS_S3_BUCKET=local-s3-bucket

awslocal secretsmanager create-secret --name $AWS_REDIS_SECRET \
    --region $AWS_REGION \
    --secret-string "{\"password\":\"password\"}"

awslocal secretsmanager create-secret --name $AWS_DATABASE_SECRET \
    --region $AWS_REGION \
    --secret-string "{\"password\":\"postgres-pass\",\"dbname\":\"postgres-db\",\"engine\":\"postgres\",\"port\":5432,\"dbInstanceIdentifier\":\"llm-postgres\",\"host\":\"db\",\"username\":\"postgres-user\"}"

awslocal s3api create-bucket --bucket $AWS_S3_BUCKET --region $AWS_REGION
