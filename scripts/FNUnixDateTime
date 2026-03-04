-- A funcao abaixo retorna uma data valida e tem como parametro o valor do timestamp.

CREATE FUNCTION dbo.FNUnixDateTime
(@Segundos BIGINT)
RETURNS DATETIME
AS
BEGIN
  DECLARE @Retorno DATETIME
  DECLARE @Dias NUMERIC(20,2)
  DECLARE @Segundos2 BIGINT
  DECLARE @Segundos3 INT

  SELECT @Dias = 0
  SELECT @Segundos2 = 0
  SELECT @Segundos3 = 0

  IF @Segundos > 0
  BEGIN
    SELECT @Dias = FLOOR(@Segundos / 86400000)
    SELECT @Retorno = DATEADD(DAY, @Dias, '01-jan-1970')
    SELECT @Segundos2 = (@Dias * 86400000)
    SELECT @Segundos3 = FLOOR((@Segundos - @Segundos2) / 1000)
    IF @Segundos3 > 0
      SELECT @Retorno = DATEADD(SECOND, @Segundos3, @Retorno)
  END
  
  RETURN @Retorno
END
go
