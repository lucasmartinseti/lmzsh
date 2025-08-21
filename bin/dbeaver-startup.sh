#!/bin/bash
# Script para iniciar DBeaver com git pull e push automáticos para sincronizar o workspace

# Configuração
WORKSPACE_DIR="/Users/lucas/Library/DBeaverData/workspace6"
# Captura o diretório corrente onde o script foi executado
ORIGINAL_DIR="$(pwd)"

echo "Fazendo git pull..."
cd "$WORKSPACE_DIR"
git pull origin main

# Retorna para o diretório original após o git pull
cd "$ORIGINAL_DIR"
echo "Retornado para o diretório original: $(pwd)"

echo "Iniciando DBeaver em modo silencioso..."
# Inicia o DBeaver em background e captura o PID
nohup /Applications/DBeaver.app/Contents/MacOS/dbeaver > /dev/null 2>&1 &
DBEAVER_PID=$!

echo "DBeaver iniciado com PID: $DBEAVER_PID"
echo "Terminal liberado. DBeaver está rodando em background."

# Monitora o processo em background
(
    while kill -0 $DBEAVER_PID 2>/dev/null; do
        sleep 10
    done
    
    echo "DBeaver foi fechado, fazendo git push..."
    cd "$WORKSPACE_DIR"
    git add .
    if ! git diff --staged --quiet; then
        git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
        git push origin main
        echo "Git push concluído!"
    fi
    
    # Retorna para o diretório original após o git push
    cd "$ORIGINAL_DIR"
    echo "Retornado para o diretório original após git push: $(pwd)"
) &

echo "Script finalizado. DBeaver e monitoramento rodando em background."
