#!/bin/bash
docker push hitaraku/sample-node

ssh deploy@159.65.10.100 << EOF
docker pull hitaraku/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi hitaraku/sample-node:current || true
docker tag hitaraku/sample-node:latest hitaraku/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 hitaraku/sample-node:current
EOF
