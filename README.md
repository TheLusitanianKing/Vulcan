:england: [English version/Versão inglesa](README-en.md)
***

# Vulcan ![Unit tests](https://github.com/TheLusitanianKing/Vulcan/workflows/Haskell%20CI/badge.svg)
Ferramenta de ajuda para validar MR.

<img src="https://static.wikia.nocookie.net/metalgear/images/2/22/Vulcan_Raven.jpg/revision/latest?cb=20060802225437" alt="vulcan-raven" width="150"/>

## Contexto
Equipas a trabalhar com submodules Git precisam atualizá-los. Na maioria dos casos, queremos que o projeto principal esteja sincronizado com as nossas mudanças nos submodules. Portanto, precisamos verificar manualmente se o commit alvo da MR é o commit certo.

## Funcionalidades
A partir da URL de uma merge request, vai:
- Recuperar o ramo alvo da MR e listar os últimos X commits de todos os submodules com o mesmo ramo (se existir um ramo com o mesmo nome no submodule).

Ou, diretamente a partir de um nome de ramo, vai:
- Listar os últimos X commits de todos os submodules com o mesmo ramo (se existir um ramo com o mesmo nome no submodule).

## Configurações
Tem dois ficheiros de configuração, um para as configurações gerais da app e outro para listar os submodules.

### Configuração geral
Este ficheiro de configuração é principalmente para saber como aceder o vosso *sistema de controlo de versões* (URL, token e outras configurações do género).

```bash
cp conf/vulcan.conf.default conf/vulcan.conf
vim conf/vulcan.conf # modificam este ficheiro com a vossa configuração
```

### Listar os submodules
Este ficheiro é simplesmente para listar todos os submodules usados e os seus IDs (podem encontrar esses IDs na página principal dos submodules em princípio).

Como não tem forma simples de recuperar esta lista por enquanto, e como Vulcan precisa disso, tendes que os listar todos.

```bash
cp conf/submodules.conf.default conf/submodules.conf
vim conf/submodules.conf # modificam este ficheiro com os vossos submodules
```

## Uso
É só dar-lhe uma URL de MR:

```bash
cabal run :vulcan https://git.something.com/namespace/project/merge_requests/199
```

OU diretamente um nome de ramo:

```bash
cabal run :vulcan us_283532_statistics
```

## Lista de possíveis melhorias
Ver [aqui todos com a etiqueta "enhancement"](https://github.com/TheLusitanianKing/Vulcan/labels/enhancement).

## Suporte
- :white_check_mark: GitLab
- :x: GitHub
- :x: BitBucket
- ...

## Licença
ver [LICENSE](LICENSE).
