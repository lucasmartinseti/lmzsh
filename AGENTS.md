# 🧠 AGENT.md — Guia de Desenvolvimento e Boas Práticas em Shell Script

## 📘 Objetivo

Este documento estabelece **padrões, convenções e boas práticas** para o desenvolvimento de projetos em **Shell Script**. Referências principais: [`kvz/bash3boilerplate`](https://github.com/kvz/bash3boilerplate), [`ralish/bash-script-template`](https://github.com/ralish/bash-script-template) e [`niieani/bash-oo-framework`](https://github.com/niieani/bash-oo-framework).  
O propósito é garantir **qualidade, consistência, escalabilidade e manutenibilidade** em todos os serviços, agentes ou ferramentas desenvolvidas.

---

## 🧱 Estrutura Recomendada do Projeto

Arquitetura completa (melhor prática de mercado para CLIs ou automações médias/grandes):
```
.
├── bin/              # entrypoints finos (invocam funções de src/)
├── src/              # lógica de negócio
│   ├── main.sh       # orquestração principal
│   ├── config.sh     # carregamento/validação de configs
│   ├── lib/          # helpers genéricos (log, parse, retry, fs)
│   └── modules/      # domínios específicos (opcional)
├── tests/
│   ├── unit/         # funções puras
│   └── integration/  # fluxos completos, mocks via PATH
├── docs/             # guias, ADRs curtos, exemplos de uso
├── examples/         # snippets de consumo da CLI/funções
├── scripts/          # utilitários de dev (lint, release)
├── tmp/              # artefatos temporários (gitignored)
├── .env.example      # variáveis esperadas
├── AGENT.md
└── README.md
```

Minimal (para scripts pequenos):
```
.
├── bin/
├── src/
├── tests/      # opcional mas recomendável
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
- Evite duplicação criando libs em `src/lib` e compartilhando via `source`.
- Limpe `tmp/` automaticamente no `trap`; nunca escreva em `/tmp` sem `mktemp`.
- Para downloads externos, valide integridade (checksum/sha) e pin de versão.

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
- Em integração, prefira ambientes efêmeros e verificação de efeitos observáveis (arquivos criados, stdout/stderr, códigos de saída).

---

## 🧩 Configuração

- Ordem de precedência: flags CLI > variáveis de ambiente > arquivo `.env` > defaults.
- Use defaults seguros: `${VAR:-valor}`; para atribuir default: `${VAR:=valor}`.
- Centralize carregamento em `src/config.sh` e documente variáveis suportadas.
- Valide configs na inicialização e falhe cedo com mensagem clara.
- Permita `--config <arquivo>` para overrides locais; mantenha `.env.example` atualizado.

---

## 🧠 Concorrência e Performance

- Para paralelizar: `xargs -P <n> cmd`, `parallel`, ou jobs em background + `wait`.
- Limite paralelismo por CPU (`nproc`) e I/O; evite *fork bombs*.
- Use `mktemp` para diretórios/arquivos e limpe no `trap`.
- Meça com `time`, `hyperfine` ou contadores simples para hotspots.
- Proteja seções críticas com lockfiles (`flock` ou `ln`), incluindo cleanup no `trap`.

---

## 🧩 Versionamento

- Scripts versionados via git com tags semânticas (`vMAJOR.MINOR.PATCH`).
- Embuta `APP_VERSION` e exponha `--version`.
- Gere changelog curto por release (`git log --oneline <tag>..HEAD`).
- Para CLIs publicadas, automatize release (tag + checksum + changelog) via `scripts/release.sh`.

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
| Release | `scripts/release.sh` (caseiro) | Tag, changelog, checksum |

---

## Rule: README Documentation Rule

Quando solicitado a criar documentação de projeto, o agente deve gerar um arquivo chamado `README.md` seguindo obrigatoriamente a estrutura abaixo.

### Rule: Estrutura Obrigatória do README

### Seção: Título do Projeto
- Deve conter o nome do projeto.
- Inclui um breve título ou subtítulo contendo um resumo de 1–2 frases.

### Seção: Descrição
- Explicação geral e objetiva sobre o projeto.
- Destaque das principais capacidades e funções.
- Informar compatibilidade com sistemas operacionais e ambientes, se aplicável.

### Seção: Funcionalidades
- Lista de funcionalidades apresentadas como itens com checkmarks.
- Indicação de diferentes modos de operação, quando existirem.

### Seção: Pré-requisitos
- Sistemas operacionais suportados.
- Dependências de linguagem, framework, SDK ou runtime.
- Permissões ou acessos necessários para operação.

### Seção: Instalação
- Passos de instalação descritos de forma sequencial.
- Instruções em blocos de código sempre que necessário.
- Inclui exemplo de configuração inicial.

### Seção: Uso
- Sintaxe básica do comando, script ou execução.
- Tabela de parâmetros contendo:
  - Nome  
  - Descrição  
  - Obrigatório ou opcional  
- Descrição dos modos de operação possíveis.
- Exemplos de uso mostrados em blocos de código.

### Seção: Exemplos de Uso
- Casos reais demonstrando entrada e saída.
- Exemplos com parâmetros adicionais, como logs, debug e configurações extras.

### Seção: Configuração
- Variáveis de ambiente utilizadas.
- Opções internas do script ou projeto.
- Exemplos de personalização, incluindo temas, cores ou modos.

### Seção: Testes
- Exemplos de testes manuais.
- Casos de validação como diretórios inexistentes ou problemas de permissão.
- Lista de casos de teste recomendados.

### Seção: Boas Práticas e Estilo
- Padrões de código adotados.
- Convenções de nomenclatura.
- Diretrizes de segurança relevantes.

### Seção: Contribuição
- Procedimento para contribuir com o projeto: fork, criação de branches, commits e Pull Requests.
- Orientações para reporte de bugs, incluindo informações recomendadas para envio.

### Seção: Autores
- Nome(s) e/ou organização responsável pelo projeto.

### Seção: Suporte
- Local para abertura de issues, fórum, canal oficial ou forma de contato.

## Rule: Saída
- O arquivo produzido deve ser estruturado em Markdown válido.
- Todos os títulos, subtítulos e conteúdo devem ser fielmente respeitados conforme definido acima.

---

## 🧭 Ferramentas de Apoio ao Desenvolvimento

## Instrução de Documentação com Basic-Memory

**basic-memory**: Quero que você atue como um gerador de documentação técnica para um desenvolvedor que irá entrar neste projeto. Utilize o conceito e as ferramentas do **basic-memory** para estruturar e contextualizar as informações essenciais do projeto, garantindo consistência, continuidade e fácil consulta. Sua tarefa é produzir uma documentação completa, organizada e objetiva, cobrindo os seguintes pontos:

### Contexto geral do projeto
- Origem, objetivo principal, problema que resolve e visão macro.

### Arquitetura e componentes principais
- Descrição da arquitetura atual, linguagens, frameworks, serviços utilizados, padrões aplicados, integrações externas e fluxos críticos.  
- Incluir diagramas textuais quando necessário.

### Ambiente de desenvolvimento
- Requisitos, ferramentas, versões, setup inicial, variáveis de ambiente, instruções de build e execução.

### Padrões e práticas internas
- Convenções de código  
- Estrutura de pastas  
- Guidelines de commits  
- Testes  
- CI/CD  
- Branch strategy  
- Políticas de revisão

### Basic Memory do Projeto
Criar uma seção chamada **“Basic Memory do Projeto”**, registrando os elementos fundamentais que ajudarão um novo desenvolvedor a contextualizar-se rapidamente, incluindo:
- Como o time trabalha  
- Informações essenciais para navegar no código  
- Principais decisões arquiteturais  
- Regras de negócio essenciais  
- Pontos de atenção históricos  
- Convenções que não estão documentadas em nenhum lugar  
- Esta seção deve ser escrita em formato de tópicos diretos e permanentes.

### Processos e fluxo de trabalho
- Como as demandas são criadas, priorizadas e entregues.  
- Incluir exemplos claros.

### Guia para primeiros passos do novo dev
- Ações recomendadas para a primeira semana.  
- O que ler, o que configurar, quem procurar e quais áreas do código explorar primeiro.

### Referências e links importantes
- Repositórios, documentos, diagramas, planilhas e outros recursos relevantes.

### Criação do projeto no basic-memory
- Se o projeto não existir, criar um projeto no **basic-memory** com o mesmo nome do projeto atual.  
- A pasta de memórias deve estar localizada na pasta home do usuario em:  
  `~/.basic-memory/storage/`

 ## Orientação de Uso do context7
 
 **context7** deve ser utilizado como fonte de documentação viva e atualizada, operando como memória técnica de suporte ao desenvolvimento. A ferramenta fornece contexto consolidado do repositório e deve ser usada para garantir alinhamento, evitar redundâncias e fortalecer a consistência arquitetural. Siga as diretrizes abaixo para utilizá-la de forma eficaz:
 
 ### Para que serve o context7
 - Manter e consultar **documentação atualizada em texto simples**, funcionando como referência contínua durante o desenvolvimento.
 - Identificar **padrões estabelecidos no repositório**, incluindo estilo de código, estrutura de pastas, convenções funcionais e práticas recorrentes.
 - Resgatar e confirmar **decisões arquiteturais**, histórico de escolhas e suas justificativas.
 - Lembrar **contratos, modelos, esquemas e APIs**, garantindo alinhamento com o que já foi definido.
 - Verificar **APIs e bibliotecas já existentes** no projeto antes de adicionar novas dependências, evitando duplicidade ou sobrecarga técnica.
 
 ### Como utilizar os modos do context7
 - **mode=code**  
   Use quando precisar acessar referências diretas como:  
   - exemplos concretos de uso de funções, classes ou módulos  
   - estruturas de API, schemas, interfaces, DTOs  
   - padrões de implementação e snippets relevantes  
   - contratos técnicos que precisam ser seguidos fielmente
 
 - **mode=info**  
   Use para:  
   - explicações conceituais  
   - guias de arquitetura  
   - fluxos de engenharia  
   - instruções gerais  
   - orientações de boas práticas
 
 ### Boas práticas de uso
 - Consulte o context7 **antes** de implementar algo potencialmente redundante.  
 - Prefira usar context7 como **fonte primária de entendimento**, evitando interpretação inconsistente do código.  
 - Quando uma decisão técnica nova for tomada, verifique se deve ser registrada no context7 para manter a documentação sincronizada.  
 - Utilize o context7 como apoio para onboarding de novos desenvolvedores, garantindo compreensão rápida das regras e padrões do projeto.
 
## Orientações de Uso do octocode

**octocode** é a ferramenta destinada à pesquisa e análise de repositórios públicos no GitHub, permitindo identificar padrões idiomáticos, referências sólidas e exemplos reais de código. Utilize-o para embasar decisões técnicas, validar abordagens e acelerar o desenvolvimento com base em boas práticas já consolidadas.

### Como iniciar pesquisas
- Sempre comece utilizando o parâmetro `match="path"` para localizar arquivos relevantes dentro dos repositórios.  
  Exemplos de uso:  
  - localizar implementações específicas  
  - encontrar estruturas de diretórios usuais  
  - pesquisar padrões de organização em projetos Go maduros

### Como ler arquivos
- Após identificar o arquivo desejado, utilize `githubGetFileContent` para obter o conteúdo completo.  
  Isso permite:  
  - estudar implementações reais  
  - analisar nuances de estilo  
  - entender padrões de composição, interfaces e modularização

### Para que utilizar o octocode
Use o octocode para:

- Buscar **boas práticas em Go**, incluindo:  
  - padrões idiomáticos  
  - tratamento de erros  
  - organização de pacotes  
  - práticas recomendadas de concorrência e goroutines  
  - uso adequado de interfaces e abstrações

- Encontrar **implementações reais de padrões de projeto**, tais como:  
  - Strategy  
  - Adapter  
  - Factory  
  - Observer  
  - Repository  
  - CQRS  

- Referenciar **exemplos concretos** de:  
  - APIs REST em Go  
  - aplicações distribuídas  
  - uso de frameworks e bibliotecas populares  
  - testes unitários e mocks  
  - pipelines de CI/CD para Go

### Boas práticas ao usar octocode
- Priorize repositórios bem avaliados, mantidos ativamente e com histórico consistente de contribuições.  
- Faça análise comparativa de múltiplos repositórios antes de adotar um padrão ou solução.  
- Use o octocode como ferramenta de consulta, não como gerador de decisões automáticas.  
- Reavalie periodicamente referências antigas para garantir que não estejam desatualizadas.  
- Antes de criar novas soluções, valide se já existem implementações consolidadas no ecossistema Go.

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
