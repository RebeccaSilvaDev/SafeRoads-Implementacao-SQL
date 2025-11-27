-- Garante que estamos no banco de dados correto
USE SafeRoadsDB; 

-- ######################################################
-- 1. INSERT na TB_TRECHO (Tabela Base)
-- ######################################################

INSERT INTO TB_TRECHO (ID_Trecho, Nome_Estrada, KM_Inicial, KM_Final, Latitude, Longitude, Risco_Historico)
VALUES 
    (1, 'Rodovia das Colinas', 10.50, 20.00, 40.7128, 74.0060, 'Alto'),      -- Trecho Crítico
    (2, 'Via do Lago Congelado', 55.00, 60.50, 41.0000, 73.5000, 'Medio'),     -- Trecho de Risco Moderado
    (3, 'Estrada das Flores', 5.00, 10.00, 39.5000, 75.2000, 'Baixo');       -- Trecho de Baixo Risco

-- ######################################################
-- 2. INSERT na TB_CAMINHAO_MANUTENCAO (Tabela Base)
-- ######################################################

INSERT INTO TB_CAMINHAO_MANUTENCAO (Placa, Capacidade_Sal, Status_Operacional, Coordenada_GPS_Atual)
VALUES 
    ('ABC1234', 1500.50, 'Disponivel', '40.7150,-74.0080'), -- Caminhão 1: Pronto para serviço
    ('XYZ5678', 800.00, 'Em Manutencao', NULL),             -- Caminhão 2: Parado
    ('GHI9012', 2000.00, 'Em Servico', '40.8000,-73.9000');  -- Caminhão 3: Já em campo

-- ######################################################
-- 3. INSERT na TB_SENSOR (Tabela Filha - Requer ID_Trecho)
-- ######################################################

INSERT INTO TB_SENSOR (ID_Sensor, Localizacao_Exata, Tipo_Leitura, ID_Trecho)
VALUES 
    (101, 'Ponte do KM 15', 'Temperatura Pista', 1), -- Associado ao Trecho 1 (Crítico)
    (102, 'Viaduto Leste', 'Umidade Ar', 2),         -- Associado ao Trecho 2
    (103, 'Base da Montanha', 'Temperatura Pista', 3);-- Associado ao Trecho 3

-- ######################################################
-- 4. INSERT na TB_LEITURA_SENSOR (Tabela Filha - Requer ID_Sensor)
-- ######################################################

INSERT INTO TB_LEITURA_SENSOR (ID_Leitura, Data_Hora_Leitura, Valor_Temperatura, Valor_Umidade, ID_Sensor)
VALUES 
    -- Leituras Críticas (Sensor 101, Trecho 1)
    (1, '2025-11-27 05:00:00', -2.50, 95.00, 101), 
    (2, '2025-11-27 05:15:00', -4.10, 88.00, 101),

    -- Leituras Normais (Sensor 102, Trecho 2)
    (3, '2025-11-27 05:00:00', 5.80, 70.00, 102),
    (4, '2025-11-27 05:30:00', 6.20, 68.00, 102),
    
    -- Leitura no Trecho 3
    (5, '2025-11-27 05:30:00', 1.50, 75.00, 103);

-- ######################################################
-- 5. INSERT na TB_ORDEM_SERVICO (Tabela Filha - Requer ID_Trecho e Placa)
-- ######################################################

INSERT INTO TB_ORDEM_SERVICO (ID_Ordem, Data_Emissao, Prioridade, Status_Ordem, ID_Trecho, Placa_Caminhao)
VALUES 
    -- Ordem 1: Urgente para Trecho 1, atribuída ao Caminhão ABC1234
    (1001, '2025-11-27 05:05:00', 'URGENTE', 'Em Execucao', 1, 'ABC1234'), 

    -- Ordem 2: Antiga para Trecho 2, já concluída, executada pelo Caminhão XYZ5678 (agora em manutenção)
    (1002, '2025-11-26 10:00:00', 'NORMAL', 'Concluida', 2, 'XYZ5678'),

    -- Ordem 3: Pendente para Trecho 3, sem caminhão atribuído
    (1003, '2025-11-27 06:00:00', 'NORMAL', 'Pendente', 3, NULL);


-- ######################################################
-- 6. INSERT na TB_ALERTA (Tabela Filha - Requer ID_Trecho)
-- ######################################################

INSERT INTO TB_ALERTA (ID_Alerta, Tipo_Alerta, Data_Hora_Disparo, Mensagem, ID_Trecho)
VALUES 
    -- Alerta 1: Disparado devido à Leitura Crítica no Trecho 1
    (2001, 'Gelo Iminente', '2025-11-27 05:01:00', 'Temperatura da pista abaixo de zero. Reduza a velocidade.', 1), 
    
    -- Alerta 2: Neve intensa no Trecho 1
    (2002, 'Neve Intensa', '2025-11-27 04:30:00', 'Visibilidade baixa. Trecho 1 fechado temporariamente.', 1),
    
    -- Alerta 3: Chuva forte no Trecho 2
    (2003, 'Chuva Forte', '2025-11-27 07:00:00', 'Pista escorregadia no km 58.', 2);