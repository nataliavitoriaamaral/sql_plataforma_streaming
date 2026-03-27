# Modelagem de Banco de Dados Relacional - Plataforma de Streaming

## Sobre
Este projeto consiste na modelagem e implementação de um banco de dados relacional completo para uma plataforma de streaming de entretenimento (estilo Netflix/Amazon Prime). O objetivo foi estruturar a gestão centralizada de assinantes, controle de pagamentos e um catálogo complexo de mídias.

O modelo foi desenhado para suportar regras de negócio reais, garantindo a integridade dos dados e otimizando consultas estruturadas para futuras análises de comportamento do usuário e recomendações de conteúdo.

## Arquitetura
A modelagem contemplou a resolução de problemas complexos de arquitetura de dados, incluindo:
* **Gestão de Usuários e Assinaturas:** Relacionamento entre contas de usuários, planos de assinatura (com limites de telas e resolução) e histórico transacional de pagamentos.
* **Perfis e Entidades Fracas:** Estruturação de múltiplos perfis dependentes da conta principal, com controle de classificação indicativa.
* **Generalização e Especialização de Catálogo:** Criação de uma superclasse `Conteúdo` ramificada nas especializações `Filmes` e `Séries` (com hierarquia de Temporadas e Episódios).
* **Mapeamento de Acessibilidade:** Relacionamentos N:M (muitos-para-muitos) para gerenciar múltiplos idiomas e legendas por vídeo.
* **Rastreamento de Comportamento:** Tabelas estruturadas para armazenar o "Histórico de Visualização" (tempo de parada), listas de preferências ("Minha Lista") e sistema de avaliação com notas e comentários.
* **Indexação para Buscas:** Modelagem de categorias, palavras-chave, artistas e diretores para otimização de mecanismos de busca internos.

## Tecnologias e Ferramentas
* **Linguagem:** SQL
* **Conceitos Aplicados:** Modelagem de Entidade-Relacionamento, Normalização de Dados, Generalização/Especialização, Joins e Criação de Esquemas.

## Estrutura de Arquivos
* script_criacao.sql: Script completo com as instruções DDL (criação de tabelas, chaves primárias e estrangeiras) e DML (inserção de dados e consultas).
* diagrama_ER.png: Representação visual do modelo de banco de dados.
* documentacao_consultas.pdf: Relatório detalhado com a descrição do problema e as *queries* desenvolvidas.

---
## Equipe de Desenvolvimento
Este projeto foi desenvolvido colaborativamente como parte da disciplina de Banco de Dados da UNIFESP.
* **Natália Amaral**
* **Breno C. Nakamura** 
