-- Garante que estamos no banco de dados correto
USE SafeRoadsDB; 

-- ######################################################
-- 1. COMANDOS UPDATE (MODIFICAÇÃO)
-- ######################################################

-- UPDATE 1: Altera o status do Caminhão 'XYZ5678' para 'Disponivel' (saiu da manutenção)
UPDATE TB_CAMINHAO_MANUTENCAO
SET Status_Operacional = 'Disponivel', Coordenada_GPS_Atual = '40.9000,-73.8000'
WHERE Placa = 'XYZ5678';

-- UPDATE 2: Altera o status da Ordem de Serviço 1001 para 'Concluida' (o serviço no Trecho 1 foi finalizado)
UPDATE TB_ORDEM_SERVICO
SET Status_Ordem = 'Concluida'
WHERE ID_Ordem = 1001;

-- UPDATE 3: Atribui o Caminhão 'ABC1234' para a Ordem de Serviço pendente 1003
UPDATE TB_ORDEM_SERVICO
SET Placa_Caminhao = 'ABC1234', Status_Ordem = 'Em Execucao', Prioridade = 'URGENTE'
WHERE ID_Ordem = 1003;


-- ######################################################
-- 2. COMANDOS DELETE (EXCLUSÃO)
-- ######################################################

-- DELETE 1: Remove o Alerta antigo 2002 (deve ser o Alerta 2002: Neve Intensa)
DELETE FROM TB_ALERTA
WHERE ID_Alerta = 2002;

-- DELETE 2: Remove a leitura de sensor mais antiga (ID_Leitura 1) para fins de limpeza
DELETE FROM TB_LEITURA_SENSOR
WHERE ID_Leitura = 1;

-- DELETE 3: Remove o caminhão 'GHI9012'. Como ele não estava envolvido em ordens pendentes, é seguro.
DELETE FROM TB_CAMINHAO_MANUTENCAO
WHERE Placa = 'GHI9012';