
Select OC_CSITORD ,* From RSFACCAR..CO0001MOVC Where OC_CNUMORD='0000029826          '
go
Select AC_CFAXACR From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='E0114             '
go
Select C5_CTD+C5_CNUMDOC AS CADEBUS, C5_CRFTDOC + ' ' + C5_CRFNDOC AS DOCREF,* From RSFACCAR..AL0001MOVC as MOVC  WHERE MOVC.C5_CNUMORD = '0000029826          ' ORDER BY C5_CTD+C5_CNUMDOC
go
Select OC_CCODIGO,OC_CDESREF, OC_CUNIDAD, OC_NCANORD,        (OC_NCANORD)*OC_NPREUN2 As ORDEN_VALOR_VENTA,        (OC_NCANORD)*OC_NPREUNI As ORDEN_TOTAL,        Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGV/100) Else 0 End As ORDEN_IGV,       OC_NCANORD-OC_NCANSAL As ATEND,       (OC_NCANORD-OC_NCANSAL)*OC_NPREUN2 As ATEND_VALOR_VENTA,       (OC_NCANORD-OC_NCANSAL)*OC_NPREUNI As ATEND_TOTAL,       Case  When OC_NIGV>0 Then(OC_NCANORD-OC_NCANSAL)*OC_NPREUN2 * (OC_NIGV/100) Else 0 End As ATEND_IGV,       OC_NCANSAL,       (OC_NCANSAL)*OC_NPREUN2 As XATEND_VALOR_VENTA,       (OC_NCANSAL)*OC_NPREUNI As XATEND_TOTAL,       Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGV/100) Else 0 End As XATEND_IGV  From RSFACCAR..CO0001MOVD  Where OC_CNUMORD='0000029826'  AND OC_CCODPRO='E0114'  ORDER BY OC_CITEM
go
SELECT CP_CTIPDOC+CP_CNUMDOC AS CODEBUS,RTRIM(A.CP_CCODIGO) + ' ' + RTRIM(B.AC_CNOMBRE) AS PROVEE,A.CP_CIMAGEN,  CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NIMPOMN ELSE A.CP_NIMPOUS END IMPORTE, CASE A.CP_CCODMON WHEN 'MN' THEN A.CP_NSALDMN ELSE A.CP_NSALDUS END SALDO, CP_CTIPDOC,CP_CNUMDOC,CP_DFECDOC,CP_DFECVEN,CP_CCODMON,CP_CSUBDIA,CP_CCOMPRO,CP_CFECCOM  FROM RSCONCAR..CP0001CART AS A LEFT JOIN RSCONCAR..CP0001MAES AS B ON A.CP_CVANEXO=B.AC_CVANEXO AND A.CP_CCODIGO=B.AC_CCODIGO WHERE A.CP_CTDOCRE='OC'   AND A.CP_CNDOCRE='0000029826          ' ORDER BY PROVEE 
go
Select LQ_CNUMLIQ, LQ_CNUMORD, LQ_CCODPRO,LQ_CTIPLIQ,LQ_CTIPDOC + ' ' + LQ_CNUMDOC AS DOCUM, LQ_DFECDOC,       LQ_CTIPMON, CASE LQ_CTIPMON WHEN 'MN' THEN  LQ_NIMPMN ELSE LQ_NIMPUS END AS IMPORTE,LQ_CSUBDIA, LQ_CCOMPRO,AC_CNOMBRE   From RSFACCAR..AL0001IMPD  Left Join RSCONCAR..CP0001MAES On LQ_CCODPRO=AC_CCODIGO   Where LQ_CNUMORD='0000029826          ' Order By LQ_CNUMORD
go
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='63' And TG_CCLAVE='I'
go
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='03' And TG_CCLAVE='US'
go
Select SUM((OC_NCANORD)*OC_NPREUN2) As ORDEN_VALOR_VENTA,        
SUM((OC_NCANORD)*OC_NPREUNI) As ORDEN_TOTAL,       
SUM(Case  When OC_NIGV>0 Then (OC_NCANORD)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As ORDEN_IGV,       
SUM((OC_NCANORD-OC_NCANSAL)*OC_NPREUN2) As ATEND_VALOR_VENTA,       
SUM((OC_NCANORD-OC_NCANSAL)*OC_NPREUNI) As ATEND_TOTAL,       
SUM(Case  When OC_NIGV>0 Then (OC_NCANORD-OC_NCANSAL)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As ATEND_IGV,       
SUM((OC_NCANSAL)*OC_NPREUN2) As XATEND_VALOR_VENTA,       
SUM((OC_NCANSAL)*OC_NPREUNI) As XATEND_TOTAL,       
SUM(Case  When OC_NIGV>0 Then (OC_NCANSAL)*OC_NPREUN2 * (OC_NIGVPOR/100) Else 0 End) As XATEND_IGV  
From RSFACCAR..CO0001MOVD  
Where OC_CNUMORD='0000029826          '  
GROUP BY OC_CNUMORD
go
Select Sum(CP_NIMPOMN) As Fact_MN_Total,
Sum(CP_NIMPOUS) As Fact_US_Total,Sum (CP_NIGVMN) As Fact_MN_Igv, 
Sum(CP_NIGVUS) As Fact_US_Igv  
From RSCONCAR..CP0001CART  
Where CP_CTDOCRE='OC' AND CP_CNDOCRE='0000029826          '  
Group by CP_CTDOCRE,CP_CNDOCRE
go
Select CP_CTIPDOC, SUM(CP_NSALDMN) as SALD_MN,SUM(CP_NSALDUS) as SALD_US  From RSCONCAR..CP0001CART  Where CP_CTDOCRE='OC' AND CP_CNDOCRE='0000029826          '  Group by CP_CTIPDOC
go
