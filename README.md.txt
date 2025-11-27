# 🛣️ Sistema de Gestão de Risco Rodoviário: SafeRoadsDB

## 🎯 Visão Geral do Projeto

Este repositório contém os scripts de implementação e manipulação de dados (DDL e DML) para o projeto "SafeRoads", um sistema de banco de dados modelado para gerenciar e monitorar trechos rodoviários críticos, emitir alertas de condições climáticas adversas (como gelo iminente) e coordenar o envio de caminhões de manutenção (sal/areia).

O sistema visa otimizar a segurança rodoviária e a resposta a emergências em condições de inverno, integrando dados de sensores e ordens de serviço.

## 🛠️ Tecnologias Utilizadas

* **Banco de Dados:** MySQL
* **Ferramenta:** MySQL Workbench

---

## 📁 Estrutura do Repositório

O repositório está organizado nos quatro scripts necessários para a Experiência Prática IV, seguindo a ordem lógica de execução:

| Arquivo | Conteúdo | Tipo de Linguagem |
| :--- | :--- | :--- |
| **`create_tables.sql`** | Criação do `SCHEMA SafeRoadsDB` e todas as tabelas (DDL) com suas respectivas chaves primárias e estrangeiras. | DDL |
| **`insert_data.sql`** | Inserção de dados de teste coerentes com o minimundo para todas as tabelas criadas. | DML |
| **`queries.sql`** | Consultas avançadas (`SELECT`, `JOIN`, `WHERE`, `GROUP BY`) que demonstram o uso de informações do sistema (Ex: Trechos com alertas ativos, temperaturas críticas). | DML |
| **`update_delete.sql`** | Comandos de modificação (`UPDATE`) e exclusão (`DELETE`) de dados para simular a mudança de status do sistema. | DML |

---

## ⚙️ Guia de Execução

Para replicar o ambiente do projeto no MySQL Workbench, siga a ordem de execução dos scripts abaixo. **Cada script deve ser executado separadamente.**

### Pré-requisito

1.  Tenha o MySQL Server e o MySQL Workbench instalados e configurados.
2.  Crie uma nova aba de consulta para cada script.

### Ordem de Execução

1.  **Criação da Estrutura:**
    * Execute o script **`create_tables.sql`**. (Isso criará o banco de dados `SafeRoadsDB` e todas as tabelas.)

2.  **População de Dados:**
    * Execute o script **`insert_data.sql`**. (Isso adicionará os dados de teste essenciais.)

3.  **Consultas de Negócio:**
    * Execute o script **`queries.sql`**. (Visualize os resultados das consultas que simulam relatórios de sistema.)

4.  **Manipulação Final:**
    * Execute o script **`update_delete.sql`**. (Isso demonstrará a capacidade de atualizar status e limpar dados antigos.)

---

## 🧱 Modelo Lógico (Entidades)

O banco de dados foi modelado para gerenciar as seguintes entidades principais:

* **TB_TRECHO:** Trechos de rodovia sendo monitorados.
* **TB_SENSOR:** Dispositivos instalados nos trechos para coleta de dados.
* **TB_LEITURA_SENSOR:** Registros temporais de temperatura e umidade.
* **TB_CAMINHAO_MANUTENCAO:** Frota de veículos para aplicação de sal/areia.
* **TB_ORDEM_SERVICO:** Tarefas atribuídas aos caminhões para manutenção de trechos.
* **TB_ALERTA:** Avisos disparados devido a condições críticas detectadas pelos sensores.