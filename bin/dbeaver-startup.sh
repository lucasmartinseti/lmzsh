#!/bin/bash
# Script para iniciar DBeaver com git pull e push automáticos para sincronizar o workspace

# Captura o diretório corrente onde o script foi executado
ORIGINAL_DIR="$(pwd)"

# Captura o diretório home
HOME_DIR="$HOME"

# Captura todos os parâmetros passados para o script
DBEAVER_PARAMS="$@"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""

# Verifica o sistema operacional
OS="$(uname)"

if [ "$OS" = "Linux" ]; then
    # Configuração para Linux
    WORKSPACE_DIR="$HOME_DIR/.local/share/DBeaverData/workspace6"
    DBEAVER_EXECUTABLE="dbeaver" # Assumindo que 'dbeaver' está no PATH

    echo -e "${BLUE} $OS"
    echo

    # Git pull
    echo -e "${YELLOW}📥 Fazendo git pull do workspace do DBeaver...${NC}"
    cd "$WORKSPACE_DIR"
    git pull origin main

    # Retorna para o diretório original após o git pull
    cd "$ORIGINAL_DIR"
    echo ""

    # Verifica se o DBeaver já está rodando
    if pgrep -x "dbeaver" > /dev/null; then
        echo -e "${YELLOW}⚠️  DBeaver já está em execução. Abrindo nova instância...${NC}"
    else
        echo -e "${BLUE}🚀 Iniciando DBeaver...${NC}"
    fi

    # Inicia o DBeaver com os parâmetros fornecidos
    if [ -n "$DBEAVER_PARAMS" ]; then
        $DBEAVER_EXECUTABLE $DBEAVER_PARAMS > /dev/null 2>&1 &
    else
        $DBEAVER_EXECUTABLE > /dev/null 2>&1 &
    fi

    echo -e "${GREEN}✓ DBeaver iniciado!${NC}"
    echo ""

    # Aguarda um momento para o DBeaver inicializar completamente
    sleep 2

    # Monitora o processo em background
    (
        while pgrep -x "dbeaver" > /dev/null; do
            sleep 10
        done

        echo ""
        echo -e "${YELLOW}🔄 DBeaver foi fechado, sincronizando workspace...${NC}"
        cd "$WORKSPACE_DIR"

        # Verifica se há mudanças
        if [[ -n $(git status -s) ]]; then
            git add .
            git commit -m "Auto-commit DBeaver workspace: $(date '+%Y-%m-%d %H:%M:%S')"
            git push origin main
            echo -e "${GREEN}✓ Workspace sincronizado com sucesso!${NC}"
        else
            echo -e "${BLUE}ℹ️  Nenhuma alteração no workspace para sincronizar.${NC}"
        fi

        # Retorna para o diretório original após o git push
        cd "$ORIGINAL_DIR"
    ) &

    # Captura o PID do processo de monitoramento
    MONITOR_PID=$!
    echo -e "${BLUE}ℹ️  Processo de monitoramento PID: $MONITOR_PID${NC}"

elif [ "$OS" = "Darwin" ]; then
    # Configuração para macOS
    WORKSPACE_DIR="$HOME_DIR/Library/DBeaverData/workspace6"
    DBEAVER_EXECUTABLE="/Applications/DBeaver.app/Contents/MacOS/dbeaver"

    echo -e "${BLUE} $OS"
    echo
    # Git pull
    echo -e "${YELLOW}📥 Fazendo git pull do workspace do DBeaver...${NC}"
    cd "$WORKSPACE_DIR"
    git pull origin main

    # Retorna para o diretório original após o git pull
    cd "$ORIGINAL_DIR"
    echo ""

    # Verifica se o DBeaver já está rodando
    if ps aux | grep "$DBEAVER_EXECUTABLE" | grep -v grep > /dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  DBeaver já está em execução. Abrindo nova instância...${NC}"
    else
        echo -e "${BLUE}🚀 Iniciando DBeaver...${NC}"
    fi

    # Inicia o DBeaver com os parâmetros fornecidos
    if [ -n "$DBEAVER_PARAMS" ]; then
        $DBEAVER_EXECUTABLE $DBEAVER_PARAMS > /dev/null 2>&1 &
    else
        $DBEAVER_EXECUTABLE > /dev/null 2>&1 &
    fi

    # Captura o PID do DBeaver
    DBEAVER_PID=$!

    echo -e "${GREEN}✓ DBeaver iniciado!${NC}"
    echo ""

    # Aguarda um momento para o DBeaver inicializar completamente
    sleep 2

    # Monitora o processo em background
    (
        while kill -0 $DBEAVER_PID 2>/dev/null || ps aux | grep "$DBEAVER_EXECUTABLE" | grep -v grep > /dev/null 2>&1; do
            sleep 10
        done

        echo ""
        echo -e "${YELLOW}🔄 DBeaver foi fechado, sincronizando workspace...${NC}"
        cd "$WORKSPACE_DIR"

        # Verifica se há mudanças
        if [[ -n $(git status -s) ]]; then
            git add .
            git commit -m "Auto-commit DBeaver workspace: $(date '+%Y-%m-%d %H:%M:%S')"
            git push origin main
            echo -e "${GREEN}✓ Workspace sincronizado com sucesso!${NC}"
        else
            echo -e "${BLUE}ℹ️  Nenhuma alteração no workspace para sincronizar.${NC}"
        fi

        # Retorna para o diretório original após o git push
        cd "$ORIGINAL_DIR"
    ) &

    # Captura o PID do processo de monitoramento
    MONITOR_PID=$!
    echo -e "${BLUE}ℹ️  Processo de monitoramento PID: $MONITOR_PID${NC}"
else
    echo "Sistema operacional não suportado: $OS"
    exit 1
fi
