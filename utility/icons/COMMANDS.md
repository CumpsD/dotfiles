```bash
rsvg-convert -a -w 500 -f svg icons/svgs/solid/moon.svg  -o icons/moon.svg
sed -e "s/0%,0%,0%/100%,100%,100%/" icons/moon.svg > icons/moon-white.svg
volnoti-show -s /home/cumpsd/dotfiles/utility/icons/moon-white.svg 60

rsvg-convert -d 201 -p 201 icons/moon-white.svg > moon.png
volnoti-show -s /home/cumpsd/dotfiles/utility/moon.png 60
```
