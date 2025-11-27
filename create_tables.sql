-- ######################################################
-- 1. DEFINIÇÃO DO BANCO DE DADOS (SCHEMA)
-- ######################################################

-- Cria o SCHEMA (banco de dados) se ele ainda não existir
CREATE SCHEMA IF NOT EXISTS SafeRoadsDB;

-- Define que todos os comandos a seguir serão executados neste SCHEMA
USE SafeRoadsDB;

-- ######################################################
-- 2. CRIAÇÃO DAS TABELAS (DDL)
-- ######################################################

-- TABELA 1: TB_TRECHO (Tabela base, não depende de outra)
CREATE TABLE TB_TRECHO (
    ID_Trecho INT PRIMARY KEY,
    Nome_Estrada VARCHAR(100) NOT NULL,
    KM_Inicial DECIMAL(5, 2) NOT NULL,
    KM_Final DECIMAL(5, 2),
    Latitude DECIMAL(9, 6) NOT NULL,
    Longitude DECIMAL(9, 6) NOT NULL,
    Risco_Historico VARCHAR(50) -- Ex: Alto, Médio, Baixo
);

-- TABELA 2: TB_CAMINHAO_MANUTENCAO (Tabela base, não depende de outra)
CREATE TABLE TB_CAMINHAO_MANUTENCAO (
    Placa VARCHAR(7) PRIMARY KEY, -- Usamos a Placa como PK
    Capacidade_Sal DECIMAL(10, 2), -- em kg
    Status_Operacional VARCHAR(50), -- Ex: 'Disponível', 'Em Serviço'
    Coordenada_GPS_Atual VARCHAR(50)
);

-- TABELA 3: TB_SENSOR (Depende de TB_TRECHO)
CREATE TABLE TB_SENSOR (
    ID_Sensor INT PRIMARY KEY,
    Localizacao_Exata VARCHAR(255),
    Tipo_Leitura VARCHAR(50), -- Ex: 'Temperatura Pista', 'Umidade'
    
    -- Chave Estrangeira (FK)
    ID_Trecho INT NOT NULL,
    FOREIGN KEY (ID_Trecho) REFERENCES TB_TRECHO(ID_Trecho)
);

-- TABELA 4: TB_LEITURA_SENSOR (Depende de TB_SENSOR)
CREATE TABLE TB_LEITURA_SENSOR (
    ID_Leitura INT PRIMARY KEY,
    Data_Hora_Leitura DATETIME NOT NULL,
    Valor_Temperatura DECIMAL(4, 2) NOT NULL, -- Ex: -3.50
    Valor_Umidade DECIMAL(5, 2), 

    -- Chave Estrangeira (FK)
    ID_Sensor INT NOT NULL,
    FOREIGN KEY (ID_Sensor) REFERENCES TB_SENSOR(ID_Sensor)
);

-- TABELA 5: TB_ORDEM_SERVICO (Depende de TB_TRECHO e TB_CAMINHAO_MANUTENCAO)
CREATE TABLE TB_ORDEM_SERVICO (
    ID_Ordem INT PRIMARY KEY,
    Data_Emissao DATETIME NOT NULL,
    Prioridade VARCHAR(20),
    Status_Ordem VARCHAR(50), 
    
    -- Chaves Estrangeiras (FKs)
    ID_Trecho INT NOT NULL,
    Placa_Caminhao VARCHAR(7), -- Pode ser NULL se a ordem ainda não foi atribuída
    
    FOREIGN KEY (ID_Trecho) REFERENCES TB_TRECHO(ID_Trecho),
    FOREIGN KEY (Placa_Caminhao) REFERENCES TB_CAMINHAO_MANUTENCAO(Placa)
);

-- TABELA 6: TB_ALERTA (Depende de TB_TRECHO)
CREATE TABLE TB_ALERTA (
    ID_Alerta INT PRIMARY KEY,
    Tipo_Alerta VARCHAR(50), -- Ex: 'Gelo iminente', 'Neve Intensa'
    Data_Hora_Disparo DATETIME NOT NULL,
    Mensagem VARCHAR(255),
    
    -- Chave Estrangeira (FK)
    ID_Trecho INT NOT NULL,
    FOREIGN KEY (ID_Trecho) REFERENCES TB_TRECHO(ID_Trecho)
);