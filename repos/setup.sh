#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

symlink() {
    OVERWRITTEN=""
    if [ -e "$2" ] || [ -h "$2" ]; then
        OVERWRITTEN="(Overwritten)"
        if ! rm -r "$2"; then
            substep_error "Failed to remove existing file(s) at $2."
        fi
    fi
    if ln -s "$1" "$2"; then
        substep_success "Symlinked $2 to $1. $OVERWRITTEN"
    else
        substep_error "Symlinking $2 to $1 failed."
    fi
}

# Took these printing functions from https://github.com/Sajjadhosn/dotfiles
coloredEcho() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    echo "$arrow $exp";
    tput sgr0;
}

info() {
    coloredEcho "$1" blue "========>"
}

success() {
    coloredEcho "$1" green "========>"
}

error() {
    coloredEcho "$1" red "========>"
}

substep_info() {
    coloredEcho "$1" magenta "===="
}

substep_success() {
    coloredEcho "$1" cyan "===="
}

substep_error() {
    coloredEcho "$1" red "===="
}

COMMENT=\#*
REPO_PATH=$(realpath ~/repos)

find * -maxdepth 1 -name "*.list" | while read fn; do
    folder="${fn%.*}"

    info "Cloning $folder repositories..."

    substep_info "Creating $folder folder..."
    mkdir -p "$REPO_PATH/$folder"
    while read repo; do
        if [[ $repo == $COMMENT ]]; then
          continue;
        elif [[ $repo == "" ]];  then
          continue;
        else
            pushd "$REPO_PATH/$folder" &> /dev/null
            git clone "$repo" &> /dev/null
            git_result=$?
            #echo $git_result
            if [[ $git_result -eq 128 ]]; then
                substep_success "$repo already exists."
            elif [[ $git_result -eq 0 ]]; then
                substep_success "Cloned $repo."
            else
                substep_error "Failed to clone $repo."
            fi
            popd &> /dev/null
        fi
    done < "$fn"
    success "Finished cloning $folder repositories."
done
