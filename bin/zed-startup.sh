#!/bin/bash
# Script para iniciar Zed com git pull e push automáticos para sincronizar as configurações

# Configuração
CONFIG_DIR="/Users/lucas/.config/lmzed"
# Captura o diretório corrente onde o script foi executado
ORIGINAL_DIR="$(pwd)"

echo "Fazendo git pull das configurações do Zed..."
cd "$CONFIG_DIR"
git pull origin main

# Retorna para o diretório original após o git pull
cd "$ORIGINAL_DIR"
echo "Retornado para o diretório original: $(pwd)"

echo "Iniciando Zed em modo silencioso..."
# Inicia o Zed em background e captura o PID
nohup /Applications/Zed.app/Contents/MacOS/zed > /dev/null 2>&1 &
ZED_PID=$!

echo "Zed iniciado com PID: $ZED_PID"
echo "Terminal liberado. Zed está rodando em background."

# Monitora o processo em background
(
    while kill -0 $ZED_PID 2>/dev/null; do
        sleep 10
    done

    echo "Zed foi fechado, fazendo git push das configurações..."
    cd "$CONFIG_DIR"
    git add .
    if ! git diff --staged --quiet; then
        git commit -m "Auto-commit Zed config: $(date '+%Y-%m-%d %H:%M:%S')"
        git push origin main
        echo "Git push concluído!"
    else
        echo "Nenhuma alteração nas configurações para commitar."
    fi

    # Retorna para o diretório original após o git push
    cd "$ORIGINAL_DIR"
    echo "Retornado para o diretório original após git push: $(pwd)"
) &

echo "Script finalizado. Zed e monitoramento rodando em background."
