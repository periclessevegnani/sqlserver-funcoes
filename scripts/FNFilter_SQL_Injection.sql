-- A funcao abaixo filtra palavras-chave que podem ser usadas para fazer SQL Injection.
-- Utilize essa funcao quando precisar validar um parametro VARCHAR de uma procedure/funcao, a fim de identificar possiveis tentativas.
-- Exemplo: IF (dbo.FNFilter_SQL_Injection(@Senha) = 0) ...

CREATE FUNCTION dbo.FNFilter_SQL_Injection
(@Texto VARCHAR(255))
RETURNS INT
AS
BEGIN
  DECLARE @Retorno INT
  SELECT @Retorno = 0
  
  IF (CHARINDEX('CREATE',@Texto) > 0) OR
     (CHARINDEX('DROP',@Texto) > 0) OR
     (CHARINDEX('EXEC',@Texto) > 0) OR
     (CHARINDEX('SELECT',@Texto) > 0) OR
     (CHARINDEX('INSERT',@Texto) > 0) OR
     (CHARINDEX('UPDATE',@Texto) > 0) OR
     (CHARINDEX('DELETE',@Texto) > 0) OR
     (CHARINDEX('FROM',@TEXTO) > 0)
  BEGIN
    SELECT @Retorno = 1
  END
  RETURN @Retorno
END
go

