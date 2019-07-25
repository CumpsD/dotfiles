# Arch Linux Commands

## Fonts

### Check Xft support in URxvt

```bash
urxvt --help 2>&1 | grep options
```

### List all Fonts and Styles

```bash
fc-list : | sort
```

### List all Bold Fonts

```bash
fc-list :style=Bold | sort
```

### List all Monospace Fonts

```bash
fc-list -f "%{family} : %{file}\n" :spacing=100 | sort
```

### Find Xft Font Name

```bash
fc-scan -f "Xft Name: 'xft:%{fullname}:' | Style: '%{style}'\n" /usr/share/fonts/ 

fc-match "Lato:bold"
fc-match "Lato:bold:italic"
fc-match "Lato"
```

### Install Font Selection

```bash
pacman -S xorg-xfontsel gtk2fontsel
```

### URxvt example

```
URxvt.font: xft:FantasqueSansMono Nerd Font Mono:size=12
URxvt.font: xft:Lato:bold:italic:size=12
```
