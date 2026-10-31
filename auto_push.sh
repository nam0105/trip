#!/bin/bash
# /home/melangmini/workspace/04_family/trip/auto_push.sh

# 현재 스크립트가 위치한 디렉토리로 이동 (trip 폴더 기준)
cd "$(dirname "$0")"

# 1. 변경 사항 확인 및 커밋/푸시
if [ -n "$(git status --porcelain)" ]; then
    echo "--- [변경 사항 요약] ---"
    git diff --stat
    echo "------------------------"
    echo "커밋 및 푸시 진행 중..."

    changed_files=$(git diff --name-only | paste -sd "," -)
    commit_msg="Auto-update: $(date '+%Y-%m-%d %H:%M:%S')

Modified files: $changed_files"

    echo "git add"
    git add .
    echo "git commit"
    git commit -m "$commit_msg"
    echo "git push"
    git push -u origin main
    
    commit_hash=$(git rev-parse --short HEAD)
    echo "푸시 완료! (Commit: $commit_hash)"
else
    echo "변경 사항이 없습니다."
fi
