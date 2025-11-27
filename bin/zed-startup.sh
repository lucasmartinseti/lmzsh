#!/bin/bash
# Script para iniciar Zed com git pull e push automáticos para sincronizar as configurações

# Captura o diretório corrente onde o script foi executado
ORIGINAL_DIR="$(pwd)"

# Captura o diretório home
HOME_DIR="$HOME"

# Diretório do basic-memory
BASIC_MEMORY_DIR="$HOME_DIR/.basic-memory"

# Captura todos os parâmetros passados para o script
ZED_PARAMS="$@"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

git_pull_repo() {
    local dir="$1"
    local label="$2"

    if [ -d "$dir/.git" ]; then
        echo -e "${YELLOW}📥 Fazendo git pull de ${label}...${NC}"
        (cd "$dir" && git pull origin main)
    else
        echo -e "${YELLOW}ℹ️  Repositório ${label} não encontrado em ${dir}, pulando pull.${NC}"
    fi
}

git_sync_repo() {
    local dir="$1"
    local label="$2"
    local commit_prefix="$3"

    if [ ! -d "$dir/.git" ]; then
        echo -e "${BLUE}ℹ️  Repositório ${label} não encontrado em ${dir}, pulando push.${NC}"
        return
    fi

    cd "$dir"

    if [[ -n $(git status -s) ]]; then
        git add .
        git commit -m "${commit_prefix}: $(date '+%Y-%m-%d %H:%M:%S')"
        git push origin main
        echo -e "${GREEN}✓ ${label} sincronizado com sucesso!${NC}"
    else
        echo -e "${BLUE}ℹ️  Nenhuma alteração em ${label} para sincronizar.${NC}"
    fi

    cd "$ORIGINAL_DIR"
}

echo ""

# Verifica o sistema operacional
OS="$(uname)"

if [ "$OS" = "Linux" ]; then
    # Configuração para Linux
    CONFIG_DIR="$HOME_DIR/.config/lmzed"
    ZED_EXECUTABLE="zed" # Assumindo que 'zed' está no PATH

    echo -e "${BLUE} $OS"
    echo

    git_pull_repo "$CONFIG_DIR" "config do Zed"
    git_pull_repo "$BASIC_MEMORY_DIR" "basic-memory"

    # Retorna para o diretório original após o git pull
    echo ""

    # Verifica se o Zed já está rodando
    if pgrep -x "zed" > /dev/null; then
        echo -e "${YELLOW}⚠️  Zed já está em execução. Abrindo nova janela...${NC}"
    else
        echo -e "${BLUE}🚀 Iniciando Zed...${NC}"
    fi

    # Inicia o Zed com os parâmetros fornecidos
    if [ -n "$ZED_PARAMS" ]; then
        $ZED_EXECUTABLE $ZED_PARAMS > /dev/null 2>&1 &
    else
        $ZED_EXECUTABLE > /dev/null 2>&1 &
    fi

    ZED_PID=$!
    echo -e "${BLUE}ℹ️  PID do Zed: $ZED_PID${NC}"
    echo -e "${GREEN}✓ Zed iniciado!${NC}"
    echo ""

    # Aguarda um momento para o Zed inicializar completamente
    sleep 2

    # Monitora o processo em background
    (
        while kill -0 "$ZED_PID" 2>/dev/null || pgrep -f "dev\\.zed\\.Zed|[ /](zed|zed-editor)( |$)" > /dev/null 2>&1; do
            sleep 10
        done

        echo ""
        echo -e "${YELLOW}🔄 Zed foi fechado, sincronizando configurações...${NC}"
        git_sync_repo "$CONFIG_DIR" "config do Zed" "Auto-commit Zed config"
        git_sync_repo "$BASIC_MEMORY_DIR" "basic-memory" "Auto-commit Basic Memory"
    ) &

    # Captura o PID do processo de monitoramento
    MONITOR_PID=$!
    echo -e "${BLUE}ℹ️  Processo de monitoramento PID: $MONITOR_PID${NC}"

elif [ "$OS" = "Darwin" ]; then
    # Configuração para macOS
    CONFIG_DIR="$HOME_DIR/.config/lmzed"
    ZED_EXECUTABLE="/Applications/Zed.app/Contents/MacOS/zed"

    echo -e "${BLUE} $OS"
    echo

    git_pull_repo "$CONFIG_DIR" "config do Zed"
    git_pull_repo "$BASIC_MEMORY_DIR" "basic-memory"
    echo ""

    # Verifica se o Zed já está rodando
    if ps aux | grep "$ZED_EXECUTABLE" | grep -v "crash-handler" | grep -v grep > /dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  Zed já está em execução. Abrindo nova janela...${NC}"
    else
        echo -e "${BLUE}🚀 Iniciando Zed...${NC}"
    fi

    # Inicia o Zed com os parâmetros fornecidos
    if [ -n "$ZED_PARAMS" ]; then
        $ZED_EXECUTABLE $ZED_PARAMS > /dev/null 2>&1 &
    else
        $ZED_EXECUTABLE > /dev/null 2>&1 &
    fi

    ZED_PID=$!
    echo -e "${BLUE}ℹ️  PID do Zed: $ZED_PID${NC}"
    echo -e "${GREEN}✓ Zed iniciado!${NC}"
    echo ""

    # Aguarda um momento para o Zed inicializar completamente
    sleep 2

    # Monitora o processo em background
    (
        while kill -0 "$ZED_PID" 2>/dev/null || pgrep -f "$ZED_EXECUTABLE" | grep -v "crash-handler" > /dev/null 2>&1; do
            sleep 10
        done

        echo ""
        echo -e "${YELLOW}🔄 Zed foi fechado, sincronizando configurações...${NC}"
        git_sync_repo "$CONFIG_DIR" "config do Zed" "Auto-commit Zed config"
        git_sync_repo "$BASIC_MEMORY_DIR" "basic-memory" "Auto-commit Basic Memory"
    ) &

    # Captura o PID do processo de monitoramento
    MONITOR_PID=$!
    echo -e "${BLUE}ℹ️  Processo de monitoramento PID: $MONITOR_PID${NC}"
else
    echo "Sistema operacional não suportado: $OS"
    exit 1
fi
