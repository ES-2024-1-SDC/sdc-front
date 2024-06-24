# SDC-front

Bem-vindo ao repositório do front-end do Sistema de Caronas. Este documento descreve o fluxo de trabalho de branches e o processo de contribuição para garantir um desenvolvimento organizado e eficiente.

## Estrutura de Branches

### Branch Principal

- `main`: Esta é a branch de produção. O código aqui é considerado estável e pronto para ser implantado.

### Branch de Desenvolvimento

- `develop`: Esta é a branch onde ocorre o desenvolvimento ativo. Todas as novas funcionalidades e correções são integradas aqui antes de serem promovidas para a branch `main`.

## Fluxo de Trabalho

1. **Criação de uma Nova Branch de Feature ou Correção**
   - Para cada nova alteração, crie uma nova branch a partir da branch `develop`.
   - O nome da nova branch deve seguir o padrão: `feature/nome-da-feature` ou `fix/nome-da-correção`.
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/nome-da-feature

