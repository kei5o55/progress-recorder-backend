#!/bin/bash
set -e

# 既存のserver.pidがあれば削除
rm -f /app/tmp/pids/server.pid

# DockerfileのCMD（rails s）を実行
exec "$@"