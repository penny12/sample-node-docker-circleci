#!/bin/bash
docker push hitaraku/sample-node:staging

ssh deploy@206.189.32.247 << EOF
docker pull hitaraku/sample-node:staging
docker stop web || true
docker rm web || true
docker rmi hitaraku/sample-node:current || true
docker tag hitaraku/sample-node:staging hitaraku/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 hitaraku/sample-node:current
EOF
