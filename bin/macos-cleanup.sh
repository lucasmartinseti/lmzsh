#!/bin/bash
# ==========================================================
# 🧹 macOS Cleanup Tool - Seguro e Interativo (macOS 14+)
# Autor: ChatGPT (GPT-5)
# Compatível com macOS Ventura, Sonoma e Sequoia (Darwin 23–26)
# ==========================================================

clear
echo "==========================================================="
echo "        🧹 FERRAMENTA DE LIMPEZA SEGURA DO MACOS"
echo "==========================================================="
echo ""

# --- Função auxiliar genérica ---
limpar_pasta() {
  local path="$1"
  if [ -d "$path" ]; then
    echo "🧾 Limpando: $path"
    sudo rm -rf "${path:?}/"* 2>/dev/null
  else
    echo "⚠️  Pasta não encontrada: $path"
  fi
}

# --- Funções de limpeza específicas ---

limpar_caches() {
  echo ""
  echo "🧹 Limpando caches do usuário e do sistema..."
  limpar_pasta ~/Library/Caches
  limpar_pasta /Library/Caches
  echo "✅ Caches limpos!"
}

limpar_logs() {
  echo ""
  echo "🧾 Limpando logs..."
  limpar_pasta ~/Library/Logs
  limpar_pasta /Library/Logs
  echo "✅ Logs limpos!"
}

limpar_temporarios() {
  echo ""
  echo "🗑️  Limpando arquivos temporários..."
  sudo find /private/var/folders -type f -name "*.tmp" -delete 2>/dev/null
  echo "✅ Temporários limpos!"
}

reindexar_sistema() {
  echo ""
  echo "🔍 Reindexando Spotlight e apagando logs do sistema..."
  sudo mdutil -E /
  sudo log erase --all
  echo "✅ Reindexação e limpeza concluídas!"
}

informar_manutencao() {
  echo ""
  echo "ℹ️  O macOS moderno não possui mais o serviço 'periodic-maintenance'."
  echo "    As rotinas de limpeza e otimização agora são executadas"
  echo "    automaticamente pelo sistema via launchd e processos internos."
  echo "    Você pode usar as opções 1–4 para realizar limpezas manuais seguras."
}

limpar_brave_cache() {
  echo ""
  echo "🦁 Limpando cache do Brave Browser..."
  rm -rf ~/Library/Caches/BraveSoftware/Brave-Browser 2>/dev/null
  rm -rf ~/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/Cache 2>/dev/null
  rm -rf ~/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/Code\ Cache 2>/dev/null
  rm -rf ~/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/GPUCache 2>/dev/null
  echo "✅ Cache do Brave limpo com sucesso!"
}

# --- Menu principal ---
while true; do
  echo ""
  echo "Escolha uma opção:"
  echo "  1) Limpar caches"
  echo "  2) Limpar logs"
  echo "  3) Limpar temporários"
  echo "  4) Reindexar Spotlight e logs do sistema"
  echo "  5) Informações sobre manutenção interna"
  echo "  6) Limpar cache do Brave Browser"
  echo "  7) Limpeza completa (tudo)"
  echo "  0) Sair"
  echo ""
  read -p "👉 Opção: " opcao

  case $opcao in
    1)
      limpar_caches
      ;;
    2)
      limpar_logs
      ;;
    3)
      limpar_temporarios
      ;;
    4)
      reindexar_sistema
      ;;
    5)
      informar_manutencao
      ;;
    6)
      limpar_brave_cache
      ;;
    7)
      limpar_caches
      limpar_logs
      limpar_temporarios
      limpar_brave_cache
      reindexar_sistema
      echo ""
      echo "✅ LIMPEZA COMPLETA CONCLUÍDA!"
      ;;
    0)
      echo ""
      echo "🚪 Saindo... Nenhuma alteração pendente."
      break
      ;;
    *)
      echo "❌ Opção inválida. Tente novamente."
      ;;
  esac
done

echo ""
echo "==========================================================="
echo "🧼 LIMPEZA FINALIZADA — Reinicie o sistema se desejar."
echo "==========================================================="
