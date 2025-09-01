#!/bin/bash
# Script para iniciar Zed com git pull e push automáticos para sincronizar as configurações

# Configuração
CONFIG_DIR="/Users/lucas/.config/lmzed"
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

# Git pull
echo -e "${YELLOW}📥 Fazendo git pull das configurações do Zed...${NC}"
cd "$CONFIG_DIR"
git pull origin main

# Retorna para o diretório original após o git pull
cd "$ORIGINAL_DIR"
echo ""

# Verifica se o Zed já está rodando
if ps aux | grep "/Applications/Zed.app/Contents/MacOS/zed" | grep -v "crash-handler" | grep -v grep > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Zed já está em execução. Abrindo nova janela...${NC}"
else
    echo -e "${BLUE}🚀 Iniciando Zed...${NC}"
fi

# Inicia o Zed com os parâmetros fornecidos (abrirá nova janela se já estiver rodando)
if [ -n "$ZED_PARAMS" ]; then
#    echo -e "${BLUE}📂 Abrindo Zed com parâmetros: $ZED_PARAMS${NC}"
    /Applications/Zed.app/Contents/MacOS/zed $ZED_PARAMS > /dev/null 2>&1 &
else
    /Applications/Zed.app/Contents/MacOS/zed > /dev/null 2>&1 &
fi

echo -e "${GREEN}✓ Zed iniciado!${NC}"
echo ""

# Aguarda um momento para o Zed inicializar completamente
sleep 2

# Monitora o processo em background
(
    # Monitora usando ps para capturar apenas o processo principal do Zed
    # Exclui o crash-handler e grep da busca
    while ps aux | grep "/Applications/Zed.app/Contents/MacOS/zed" | grep -v "crash-handler" | grep -v grep > /dev/null 2>&1; do
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
