#!/bin/bash
# Script para iniciar Zed com git pull e push automáticos para sincronizar as configurações

# Captura o diretório corrente onde o script foi executado
ORIGINAL_DIR="$(pwd)"

# Captura todos os parâmetros passados para o script
ZED_PARAMS="$@"

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
    CONFIG_DIR="~/.config/zed"
    ZED_EXECUTABLE="zed" # Assumindo que 'zed' está no PATH

    # Git pull
    echo -e "${YELLOW}📥 Fazendo git pull das configurações do Zed...${NC}"
    cd "$CONFIG_DIR"
    git pull origin main

    # Retorna para o diretório original após o git pull
    cd "$ORIGINAL_DIR"
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

    echo -e "${GREEN}✓ Zed iniciado!${NC}"
    echo ""

    # Aguarda um momento para o Zed inicializar completamente
    sleep 2

    # Monitora o processo em background
    (
        while pgrep -x "zed" > /dev/null; do
            sleep 10
        done

        echo ""
        echo -e "${YELLOW}🔄 Zed foi fechado, sincronizando configurações...${NC}"
        cd "$CONFIG_DIR"

        # Verifica se há mudanças
        if [[ -n $(git status -s) ]]; then
            git add .
            git commit -m "Auto-commit Zed config: $(date '+%Y-%m-%d %H:%M:%S')"
            git push origin main
            echo -e "${GREEN}✓ Configurações sincronizadas com sucesso!${NC}"
        else
            echo -e "${BLUE}ℹ️  Nenhuma alteração nas configurações para sincronizar.${NC}"
        fi

        # Retorna para o diretório original após o git push
        cd "$ORIGINAL_DIR"
    ) &

    # Captura o PID do processo de monitoramento
    MONITOR_PID=$!
    echo -e "${BLUE}ℹ️  Processo de monitoramento PID: $MONITOR_PID${NC}"

elif [ "$OS" = "Darwin" ]; then
    # Configuração para macOS
    CONFIG_DIR="~/.config/lmzed"
    ZED_EXECUTABLE="/Applications/Zed.app/Contents/MacOS/zed"

    # Git pull
    echo -e "${YELLOW}📥 Fazendo git pull das configurações do Zed...${NC}"
    cd "$CONFIG_DIR"
    git pull origin main

    # Retorna para o diretório original após o git pull
    cd "$ORIGINAL_DIR"
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

    echo -e "${GREEN}✓ Zed iniciado!${NC}"
    echo ""

    # Aguarda um momento para o Zed inicializar completamente
    sleep 2

    # Monitora o processo em background
    (
        while ps aux | grep "$ZED_EXECUTABLE" | grep -v "crash-handler" | grep -v grep > /dev/null 2>&1; do
            sleep 10
        done

        echo ""
        echo -e "${YELLOW}🔄 Zed foi fechado, sincronizando configurações...${NC}"
        cd "$CONFIG_DIR"

        # Verifica se há mudanças
        if [[ -n $(git status -s) ]]; then
            git add .
            git commit -m "Auto-commit Zed config: $(date '+%Y-%m-%d %H:%M:%S')"
            git push origin main
            echo -e "${GREEN}✓ Configurações sincronizadas com sucesso!${NC}"
        else
            echo -e "${BLUE}ℹ️  Nenhuma alteração nas configurações para sincronizar.${NC}"
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
