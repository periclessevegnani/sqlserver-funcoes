-- A funcao abaixo calcula a distancia em KM a partir de 2 coordenadas geograficas, considerando a curvatura do planeta (sorry flat-earthers!)

CREATE FUNCTION dbo.FNDistanciaCoordenadasKm
(@Latitude1 NUMERIC(20,8), 
 @Longitude1 NUMERIC(20,8),
 @Latitude2 NUMERIC(20,8),
 @Longitude2 NUMERIC(20,8))
RETURNS NUMERIC(20,8)
WITH ENCRYPTION, SCHEMABINDING
AS  
BEGIN 
  DECLARE @Retorno NUMERIC(20,8)
  SELECT @Retorno = 0
  -- Variaveis
  IF (ABS(@Latitude1-@Latitude2) + ABS(@Longitude1-@Longitude2)) > 0.0001
  BEGIN
    DECLARE @RaioTerraKm NUMERIC(20,8)
    DECLARE @lat1Radians NUMERIC(20,8)
    DECLARE @long1Radians NUMERIC(20,8)
    DECLARE @lat2Radians NUMERIC(20,8)
    DECLARE @long2Radians NUMERIC(20,8)
    DECLARE @dLatRadians NUMERIC(20,8)
    DECLARE @dLonRadians NUMERIC(20,8)

    -- Raio da Terra no Equador
    SELECT @RaioTerraKm = 6367.45
    DECLARE @PI NUMERIC(20,8)
    SELECT @PI = PI()

    -- Converte para Radianos
    SELECT @lat1Radians = @Latitude1 * @PI / 180
    SELECT @long1Radians = @Longitude1 * @PI / 180
    SELECT @lat2Radians = @Latitude2 * @PI / 180
    SELECT @long2Radians = @Longitude2 * @PI / 180

    -- Formula de Haversine
    SELECT @Retorno = ACOS(SIN(@lat1Radians) * SIN(@lat2Radians) + COS(@lat1Radians) * COS(@lat2Radians) * COS(@long2Radians - @long1Radians))
    SELECT @Retorno = @Retorno * @RaioTerraKm
  END
  RETURN @Retorno
END
go

