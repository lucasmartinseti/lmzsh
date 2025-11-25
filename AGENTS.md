# 🧠 AGENT.md — Guia de Desenvolvimento e Boas Práticas em Shell Script

## 📘 Objetivo

Este documento estabelece **padrões, convenções e boas práticas** para o desenvolvimento de projetos em **Shell Script**. Referências principais: [`kvz/bash3boilerplate`](https://github.com/kvz/bash3boilerplate), [`ralish/bash-script-template`](https://github.com/ralish/bash-script-template) e [`niieani/bash-oo-framework`](https://github.com/niieani/bash-oo-framework).  
O propósito é garantir **qualidade, consistência, escalabilidade e manutenibilidade** em todos os serviços, agentes ou ferramentas desenvolvidas.

---

## 🧱 Estrutura Recomendada do Projeto

```
.              
├── docs/
├── src/
├── tests/
├── AGENT.md
└── README.md
```

---

## ⚙️ Padrões de Projeto (Design Patterns em Shell Script)

| Categoria | Padrão | Uso Recomendado |
|------------|--------|----------------|
| **Criação** | Template/Boilerplate (`main.sh` + funções) | Base segura e reutilizável (set -Eeuo pipefail, traps, help/usage) |
| **Estrutural** | Adapter | Padronizar interface entre APIs/CLIs externas |
| **Estrutural** | Module/Import (`source`/`import`) | Carregar libs reutilizáveis sem duplicar código |
| **Comportamental** | Strategy | Troca dinâmica de implementações (ex: modo local vs cloud) |
| **Comportamental** | Retry/Backoff | Repetir comandos instáveis com limites |
| **Infraestrutura** | Singleton | Logger/config centralizado |
| **Infraestrutura** | Facade (CLI) | Comando único que orquestra subcomandos |
| **Concorrência** | Worker Pool | Execução paralela controlada (`xargs -P`, `parallel`, background + `wait`) |

> Sempre priorize **composição sobre herança** e **interfaces pequenas**.

---

## 🧰 Boas Práticas de Código

- Habilite modo seguro: `set -Eeuo pipefail` e `IFS=$'\n\t'`.
- Use `trap 'cleanup' EXIT` para liberar recursos (arquivos temporários, locks).
- Empacote como função + guarda de execução:
  ```bash
  my_main() { ... }
  if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then my_main "$@"; fi
  export -f my_main
  ```
- Prefira `local` em funções; use `UPPERCASE` para variáveis de ambiente e `__double_prefix` para globais internas.
- CLI: parseie com `getopts` ou helper próprio; ofereça `--help` consistente.
- Logging com níveis (info/warn/error) e cores opcionais; permita `LOG_LEVEL` e saída para stderr.
- Formatação: indentação 2 espaços, sem tabs; use `[[ ... ]]` e variáveis entre `{}`.
- Portabilidade: shebang `#!/usr/bin/env bash`, evite dependências externas se houver alternativa POSIX.
- Evite duplicação criando libs em `src/` e compartilhando via `source`.

---

## 🧪 Testes

- Frameworks: `bats-core` ou `shellspec` para testes de unidade; `shunit2` se precisar de POSIX estrito.
- Estrutura sugerida:
  ```
  tests/
    unit/
    integration/
  ```
- Exemplos:
  ```bash
  bats tests/unit
  shellspec
  ```
- Simule entradas com fixtures e mocks de comandos (`PATH` temporário com wrappers).

---

## 🧩 Configuração

- Ordem de precedência: flags CLI > variáveis de ambiente > arquivo `.env` > defaults.
- Use defaults seguros: `${VAR:-valor}`; para atribuir default: `${VAR:=valor}`.
- Centralize carregamento em `src/config.sh` e documente variáveis suportadas.
- Valide configs na inicialização e falhe cedo com mensagem clara.

---

## 🧠 Concorrência e Performance

- Para paralelizar: `xargs -P <n> cmd`, `parallel`, ou jobs em background + `wait`.
- Limite paralelismo por CPU (`nproc`) e I/O; evite *fork bombs*.
- Use `mktemp` para diretórios/arquivos e limpe no `trap`.
- Meça com `time`, `hyperfine` ou contadores simples para hotspots.

---

## 🧩 Versionamento

- Scripts versionados via git com tags semânticas (`vMAJOR.MINOR.PATCH`).
- Embuta `APP_VERSION` e exponha `--version`.
- Gere changelog curto por release (`git log --oneline <tag>..HEAD`).

---

### 🔹 Dependência

- Prefira ferramentas nativas; se precisar de externos, declare requisitos mínimos.
- Faça *pin* de versões em downloads (`curl -fsSL <url>@<sha>` ou checksum).
- Evite carregar libs globais sem necessidade; isole em `src/lib`.

---

## 📦 Ferramentas Recomendadas

| Categoria | Ferramenta | Função |
|------------|-------------|--------|
| Linter | `shellcheck` | Análise estática |
| Formatter | `shfmt` | Formatação consistente |
| Testes | `bats-core`, `shellspec` | Testes automatizados |
| Docs | `mdbook` ou `mkdocs` | Documentação |
| Config | `dotenv` pattern (`.env`) | Parametrização |
| Logs | Helpers próprios (`log_info`, `log_warn`) ou módulos do `bash-oo-framework` | Observabilidade |

---

## 🧑‍💻 Contribuição

1. Crie uma branch:
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```
2. Execute testes e linter:
   ```bash
   shellcheck src/*.sh
   shfmt -w src
   bats tests/unit
   ```
3. Envie o PR com:
   - Descrição do problema resolvido  
   - Prints (quando aplicável)  
   - Cobertura mínima de testes 80%+

---

## 🪙 Filosofia

- Portabilidade e simplicidade primeiro; evite dependências pesadas.
- Scripts devem falhar de forma visível e limpa; mensagens amigáveis.
- Estruture como se fosse uma lib: funções puras, efeitos colaterais controlados.
- Escreva para quem vai manter: logs claros, help atualizado, exemplos mínimos.
