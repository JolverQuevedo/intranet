USE MODELADOR
GO
--DROP TABLE [CLAVEPE]
GO
CREATE TABLE [dbo].[CLAVEPE](
	[NUMORD]	char(10) NOT NULL ,
	[ALM]		CHAR(4)  NOT NULL DEFAULT '0001',
	[PE]		CHAR(11) NOT NULL DEFAULT '',
	[ITEM]		CHAR(4)  NOT NULL DEFAULT '0000',
	[QTY]		NUMERIC (18,3)	NOT NULL DEFAULT 0,
	[CLAVE]		CHAR(30) NOT NULL,
	[USUARIO]	CHAR(10),
	[FECHA]		[SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO]	CHAR(1) DEFAULT 'A',
	 CONSTRAINT [PK_SOBREPE] PRIMARY KEY CLUSTERED 
(	[NUMORD]	ASC,
	[ALM]	ASC,
	[PE]	ASC,
	[ITEM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
/*
--select * from clavepe WHERE MENU = '13'
insert into submenu select '13','11', '10 Deta Costo OC', 'detacto.ASP', NULL, 'A'
updaTE submenu set  DESCRIPCION = ' ' + DESCRIPCION WHERE MENU = 13 AND SUBMENU < 11

select * FROM submenu where menu = 13
-- SELECT * FROM [USR-OPC]
INSERT INTO [USR-OPC] SELECT 'SISTEMAS', 13,11,1
INSERT INTO [USR-OPC] SELECT 'MHINOJO', 13,11,1

*/