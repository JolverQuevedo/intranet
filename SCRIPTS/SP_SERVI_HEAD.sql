USE [MODELADOR];
GO

/****** Object:  StoredProcedure [dbo].[FICHAOC_HEAD]    Script Date: 04/09/2018 10:10:54 a.m. ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

-- ===============================================================================
-- Author:		MABEL MOLINA
-- Create date: 4-SET-2018
-- Description:	Devuelve los campos de cabecera de la Ficha de SERVICIO TALLERES
-- ALTER Date:	
-- ===============================================================================

ALTER PROCEDURE dbo.SP_SERVI_HEAD @OS CHAR(13)
AS
IF @OS = 'AUTO'
	SELECT CONVERT(CHAR(4), YEAR(GETDATE()))+'-AUTO' AS NUMORD, 
	GETDATE() AS FECDOC, '' AS RUC, '' AS PROVEEDOR, '' AS ATT, '' AS CODMON, 0 AS IMPORTE, '' AS CLIENTE, 
	'' AS NOMBRE, '' AS CLASE, 0 AS PREUNI, 
	(SELECT TOP 1 XMEIMP2 FROM RSCONCAR..CTCAMB WHERE XCODMON = 'US' ORDER BY XFECCAM DESC) AS TIPCAM, 
	'' AS EDO, '' AS TIPSER, '' AS DESTIP, '' AS DIREC, '' AS AC_CTELEF1, 0 AS impMN, 0 AS impUS, 
	'' AS USUARIO, GETDATE() AS FECENT, 'CALLE CAPITAN SALVADOR CARMONA 280 - ATE' AS ENTREGA, '' AS GLOSA, 0 as cant, '' as fpag
ELSE
	SELECT NUMORD,FECDOC, RUC, ac_cnombre AS PROVEEDOR, ATT, CODMON, 
	IMPORTE = CASE WHEN codmon = 'MN'THEN impMN ELSE impus END, 
	CLIENTE, NOMBRE, CLASE, SS.PREUNI, TIPCAM, AC_CDIRECC, 
	(SELECT TG_CDESCRI FROM RSFACCAR..AL0001TABL WHERE TG_CCOD = '31' AND 
	SITORD COLLATE Modern_Spanish_CI_AS = TG_CCLAVE COLLATE Modern_Spanish_CI_AS) AS EDO, 
	TIPSER, DESCRIPCION AS DESTIP,  AC_CDIRECC AS DIREC,  AC_CTELEF1,  impMN, impUS, SS.USUARIO, FECENT, ENTREGA, GLOSA,
	(select sum(cant) from servidet where numord = @os) as cant, tippag as fpag
	FROM MODELADOR..SERVICAB AS SS
	INNER JOIN RSCONCAR..CP0001MAES ON AC_CCODIGO COLLATE Modern_Spanish_CI_AS = RUC COLLATE Modern_Spanish_CI_AS
	INNER JOIN TIPSERV TS ON TIPSER = TS.CODIGO
	INNER JOIN MODELADOR..CLIENTE CC ON CLIENTE = CC.CODIGO
	WHERE AC_CVANEXO = 'P'
	AND NUMORD = @OS
	ORDER BY 1 DESC;