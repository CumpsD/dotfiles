# Git Commands

## List files by size

```bash
git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| awk '/^blob/ {print substr($0,6)}' \
| sort --numeric-sort --key=2 \
| cut --complement --characters=13-40 \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
```

## Delete big files

```bash
java -jar ~/.dotfiles/git/bfg-1.13.0.jar --delete-files "TeamCity-2017.*.tar.gz" tc
tc/
git reflog expire --expire=now --all; git gc --prune=now --aggressive
git push
```
