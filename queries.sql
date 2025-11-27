-- Define o banco de dados
USE SafeRoadsDB; 

-- ######################################################
-- CONSULTA 1: Ordens de Serviço Ativas e Recursos Atribuídos
-- Objetivo: Identifica as ordens de serviço (ativas/pendentes) e qual caminhão está responsável por qual trecho.
-- Uso: JOIN, WHERE, ORDER BY
-- ######################################################
SELECT 
    OS.ID_Ordem,
    OS.Prioridade,
    OS.Status_Ordem,
    T.Nome_Estrada,
    C.Placa AS Caminhao_Atribuido,
    C.Status_Operacional AS Status_Caminhao
FROM 
    TB_ORDEM_SERVICO OS
JOIN 
    TB_TRECHO T ON OS.ID_Trecho = T.ID_Trecho
LEFT JOIN -- LEFT JOIN para incluir ordens que ainda não têm caminhão atribuído (Placa_Caminhao = NULL)
    TB_CAMINHAO_MANUTENCAO C ON OS.Placa_Caminhao = C.Placa
WHERE 
    OS.Status_Ordem IN ('Em Execucao', 'Pendente') -- Filtra apenas as ordens que precisam de atenção
ORDER BY 
    FIELD(OS.Prioridade, 'URGENTE', 'NORMAL'), -- Ordena por Prioridade (URGENTE primeiro)
    OS.Data_Emissao ASC;

-- ######################################################
-- CONSULTA 2: As Temperaturas Mais Baixas no Trecho Crítico (Trecho 1)
-- Objetivo: Identificar as 3 leituras de temperatura mais perigosas (abaixo de zero) no trecho de Alto Risco.
-- Uso: JOIN, WHERE, ORDER BY, LIMIT
-- ######################################################
SELECT 
    LS.Data_Hora_Leitura,
    LS.Valor_Temperatura,
    S.Localizacao_Exata,
    T.Nome_Estrada
FROM 
    TB_LEITURA_SENSOR LS
JOIN 
    TB_SENSOR S ON LS.ID_Sensor = S.ID_Sensor
JOIN 
    TB_TRECHO T ON S.ID_Trecho = T.ID_Trecho
WHERE 
    T.ID_Trecho = 1 
    AND LS.Valor_Temperatura < 0 -- Filtra apenas temperaturas abaixo de zero
ORDER BY 
    LS.Valor_Temperatura ASC -- 'ASC' para listar as mais frias (mais negativas) primeiro
LIMIT 3;

-- ######################################################
-- CONSULTA 3: Média de Umidade por Trecho (Agregação)
-- Objetivo: Calcular a média de umidade de todos os sensores por trecho para identificar áreas com alta concentração de vapor (risco de neblina/gelo).
-- Uso: JOIN, AVG, GROUP BY
-- ######################################################
SELECT 
    T.Nome_Estrada,
    T.Risco_Historico,
    AVG(LS.Valor_Umidade) AS Media_Umidade
FROM 
    TB_LEITURA_SENSOR LS
JOIN 
    TB_SENSOR S ON LS.ID_Sensor = S.ID_Sensor
JOIN
    TB_TRECHO T ON S.ID_Trecho = T.ID_Trecho
WHERE
    LS.Valor_Umidade IS NOT NULL -- Exclui leituras sem valor de umidade
GROUP BY 
    T.ID_Trecho, T.Nome_Estrada, T.Risco_Historico
HAVING
    AVG(LS.Valor_Umidade) > 80 -- Filtra apenas trechos com média de umidade acima de 80% (alto risco)
ORDER BY
    Media_Umidade DESC;