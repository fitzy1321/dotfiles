# git branch --merged >/tmp/merged-branches && \
#   vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches
git branch --merged | grep -v -e "\*" -e main -e master | xargs -n 1 git branch -d
