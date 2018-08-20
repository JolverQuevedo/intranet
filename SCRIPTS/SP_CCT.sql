set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


-- =============================================
-- Author:		MABEL MOLINA
-- Create date: 6-4-2011
-- Description:	CAMPOS DE LA FICHA DE CONTROL DE
--				CALIDAD DE TELAS
-- =============================================
ALTER PROCEDURE [dbo].[SP_FICHACALIDADTELAS]
	-- Add the parameters for the stored procedure here
	@CCT CHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
IF @CCT = ''  OR @CCT IS NULL  or @CCT = '.'
	SELECT 	'AUTO' AS CCT,  '' AS RTEL,   '' AS RDES, '' AS PAR,  '' AS RUC,    '' AS PROV,
			'' AS TEL,  '' AS DES,    '' AS OC,	  '' AS CLI,  '' AS DESCLI, '' AS OFI,
			'' AS COL,  '' AS DESCOL, '' AS TIP,  0 AS KGS,   '' AS RLL,	GETDATE() AS FEC,
			0  AS RLL2, 0  AS AUD,	  0  AS ELL1, 0  AS EAL1, 0  AS REV,	0  AS VLA,
			0  AS VAA,  0  AS LFA,    0  AS LRA,  0  AS VLD,  0  AS VAD,	0  AS LFD,
			0  AS LRD,  0  AS VLL,	  0  AS VAL,  0  AS LFL,  0  AS LRL,	0  AS AA,
			0  AS AT,	0  AS AO,     0  AS AV,   '' AS TON,  '' AS DEG,    '' AS TAC,
			'' AS REP,  0  AS DDL,	  '' AS DMIN, '' AS DMAX, '' AS MAC,    '' AS CAL,
			'' AS CON,  '' AS COM  

ELSE
    -- Insert statements for procedure here
	SELECT	CCTELA.CCT,					CCTELA.TELA AS TEL,				TELAS.DESCRIPCION AS DES, 
			CCTELA.PARTIDA AS PAR,		CCTELA.CLIENTE AS CLI,			CLIENTE.NOMBRE AS DESCLI, 
			CCTELA.COLOR AS COL,		COLORES.DESCRIPCION AS DESCOL,	CCTELA.FECINI AS FEC, 
			CCTELA.PEDIDO AS OFI,       CCTELA.PESOTOTAL AS KGS,		CCTELA.TOTALROLLOS AS RLL, 
			CCTELA.PROVEEDOR AS RUC,	VP.PROVEEDOR AS PROV,           CCTELA.PORCENTAJE AS AUD, 
			CCTELA.OC,					CCTELA.TIPOCCT AS TIP,			CCTELA.VAPLARA AS VLA, 
			CCTELA.VAPANCA AS VAA,      CCTELA.VAPLARD AS VLD,			CCTELA.VAPANCD AS VAD, 
			CCTELA.LAVFALA AS LFA,		CCTELA.LAVFALD AS LFD,			CCTELA.LAVREVA AS LRA, 
            CCTELA.LAVREVD AS LRD,		CCTELA.VAPLARL AS VLL,			CCTELA.VAPANCL AS VAL, 
			CCTELA.LAVFALL AS LFL,		CCTELA.LAVREVL AS LRL,          CCTELA.TONO AS TON, 
			CCTELA.MATCHING AS MAC,		CCTELA.DEGRADE AS DEG,			CCTELA.TACTO AS TAC, 
			CCTELA.REPROCESO AS REP,    CCTELA.CALIDAD AS CAL,			CCTELA.CONDICION AS CON, 
			CCTELA.ANCHOOBTENIDO AS AO, CCTELA.ANCHOVAP AS AV,			CCTELA.DENMIN AS DMIN, 
            CCTELA.DENMAX AS DMAX,		TELAS.PESOACA AS DDL,			TELAS.ENCABI1 AS EAL1, 
			TELAS.ENCLAR1 AS ELL1,		TELAS.REVIRADO AS REV,			TELAS.ANCHTUB AS AT, 
			TELAS.ANCHABI AS AA,        VP.CODTEL AS RTEL,				VP.DESTEL AS RDES, 
			CCTELA.RLLINS AS RLL2,		RAYADOS.COMBIN as com
	FROM			CCTELA  
		INNER JOIN	TELAS ON CCTELA.TELA = TELAS.TELA 
		INNER JOIN	CLIENTE ON CCTELA.CLIENTE = CLIENTE.CODIGO 
		INNER JOIN	COLORES ON CCTELA.COLOR = COLORES.CODIGO 
		INNER JOIN	RAYADOS ON CCTELA.COLOR+CCTELA.COMBI = RAYADOS.COLOR+RAYADOS.COMBIN
		INNER JOIN	VIEW_PARTIDAS AS VP ON CCTELA.PARTIDA COLLATE Modern_Spanish_CI_AS = VP.PARTIDA
		WHERE CCT = @CCT
END


