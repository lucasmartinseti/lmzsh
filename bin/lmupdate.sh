# autoload

# colorscheme
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

ENDCOLOR="\033[0m"
HEADER="$GREEN Checking for updates in lmstack...$ENDCOLOR"
ENDMASAGE="$GREEN Done!$ENDCOLOR"
MASSASE_TMUX="$BLUE  💻  Update lmtmux  💻  $ENDCOLOR"
MESSAGE_HOMYTMUX="$BLUE  🇫🇷  💻  Update oh-my-tmux  💻 🇫🇷 $ENDCOLOR"
MESSAGE_LMZSH="$BLUE  💲  Update lmzsh  💲  $ENDCOLOR"
MESSAGE_NVIM="$BLUE  📂  Update AstroNvim Config 📂  $ENDCOLOR"

# update_lmtmux
update_lmtmux() {
    if [ -d ~/.config/lmtmux/ ]; then
        echo -e "$HEADER"
        echo -e ""
        echo -e "$MASSASE_TMUX"
        echo -e ""
        cd ~/.config/lmtmux/
        lmtmux_branch=$(git branch --show-current)
        echo -e "$GREEN  $(git pull)$ENDCOLOR"
        echo -e "$GREEN  $lmtmux_branch$ENDCOLOR"
        lmtmux=1
        else
            echo -e ""
            echo -e "$RED lmtmux is not installed $ENDCOLOR"
            echo -e ""
            lmtmux=0
    fi
    clear
    return "$lmtmux"
}
# update_oh-my-tmux
update_ohmytmux() {
    if [ -d ~/.tmux/ ]; then
        echo -e "$HEADER"
        echo -e ""
        echo -e "$MESSAGE_HOMYTMUX"
        echo -e ""
        cd ~/.tmux/
        ohmytmux_branch=$(git branch --show-current)
        echo -e "$GREEN  $(git pull)$ENDCOLOR"
        echo -e "$GREEN  $(git branch --show-current)$ENDCOLOR"
        echo -e ""
        ohmytmux=1
        else
            echo -e ""
            echo -e "$RED oh-my-tmux is not installed $ENDCOLOR"
            echo -e ""
            ohmytmux=0
    fi
    clear
    return "$ohmytmux"
}
# update_lmzsh
update_lmzsh() {
    if [ -d ~/.config/lmzsh/ ]; then
        echo -e "$HEADER"
        echo -e ""
        echo -e "$MESSAGE_LMZSH"
        echo -e ""
        cd ~/.config/lmzsh/
        lmzsh_branch=$(git branch --show-current)
        echo -e "$GREEN  $(git pull)$ENDCOLOR"
        echo -e "$GREEN  $(git branch --show-current)$ENDCOLOR"
        echo -e ""
        lmzsh=1
        else
            echo -e ""
            echo -e "$RED lmzsh is not installed $ENDCOLOR"
            echo -e ""
            lmzsh=0
    fi
    clear
    return "$lmzsh"

}
# update nvim
update_nvim() {
    if [ -d ~/.config/nvim ]; then
        echo -e "$HEADER"
        echo -e ""
        echo -e "$MESSAGE_NVIM"
        echo -e ""
        cd ~/.config/nvim/
        nvim_branch=$(git branch --show-current)
        echo -e "$GREEN  $(git pull)$ENDCOLOR"
        echo -e "$GREEN  $(git branch --show-current)$ENDCOLOR"
        nvim --headless '+Lazy! update' +qa
        nvim --headless '+Lazy! clean' +qa
        echo -e ""
        nvim=1
        else
            echo -e ""
            echo -e "$RED nvim is not installed $ENDCOLOR"
            echo -e ""
            nvim=0
    fi
    clear
    return "$nvim"
}
# check_upadate
check_upadate(){
    PWD_DIR=$(pwd)
    update_lmtmux
    lmtmux=$?
    lmtmux_branch=$(git branch --show-current)
    update_ohmytmux
    ohmytmux=$?
    ohmytmux_bramch=$(git branch --show-current)
    update_lmzsh
    lmzsh=$?
    lmzsh_branch=$(git branch --show-current)
    update_nvim
    nvim=$?
    nvim_branch=$(git branch --show-current)
    cd $PWD_DIR
    echo -e "  $ENDMASAGE"
    echo -e ""
    if [ "$lmtmux" != 1 ]; then
        echo -e "$MASSASE_TMUX ❌"
        echo -e ""
        else
            echo -e "$MASSASE_TMUX ✅ $lmtmux_branch $ENDCOLOR"
            echo -e ""
    fi
    if [ "$ohmytmux" != 1 ]; then
        echo -e "$MESSAGE_HOMYTMUX ❌"
        echo -e ""
        else
            echo -e "$MESSAGE_HOMYTMUX ✅ $ohmytmux_branch $ENDCOLOR"
            echo -e ""
    fi
    if [ "$lmzsh" != 1 ]; then
        echo -e "$MESSAGE_LMZSH ❌$ENDCOLOR"
        echo -e ""
        else
            echo -e "$MESSAGE_LMZSH ✅ $lmzsh_branch $ENDCOLOR"
            echo -e ""
    fi
    if [ "$nvim" != 1 ]; then
        echo -e "$MESSAGE_NVIM ❌$ENDCOLOR"
        echo -e ""
        else
            echo -e "$MESSAGE_NVIM ✅ $nvim_branch $ENDCOLOR"
            echo -e ""
    fi
    return "$?"
}
if check_upadate ; then
    echo -e "$GREEN  Update lmstack OK ✅$ENDCOLOR"
    echo -e ""
    else
        echo -e "RED  Update lmstack FAILED ❌$ENDCOLOR"
        echo -e ""
fi
