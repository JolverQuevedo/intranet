﻿<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">


</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
PROCESANDO...
<script type="text/jscript" language="jscript">
var aData = new Array()
var aVal = new Array()
xx=0
//alert(top.window.thisForm.DESCOL.options.length)
// se crea una variable llamada SELECT que captura el elemento del form que queremos llenar....
var select = top.window.thisForm.DESCOL
// borra los elementos PRE - existentes
select.options.length = 0;
// ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
select.options[0] = new Option('','');
// POR EL ARTIFICIO ANTERIOR SE TIENE QUE RETROCEDER EL INDICE DE LOS ARRAYS CON LA DATA 
// Y QUEDA              P E R F E C T O O O O O O O ! ! ! ! 
</script>
<%	DATO	= Request.QueryString("pos")
    sele	= Request.QueryString("sele")
    tela    = Request.QueryString("TELA")
CAD =   " select * from (SELECT  C1.COLOR+'-'+ C1.COMBIN as colo, DESCRI = case when C1.COMBIN = '00'           " & _
        " then C2.DESCRIPCION   else  C2.DESCRIPCION +' - ' + C1.DESCRIPCION end                                " & _
        " FROM RAYADOS AS C1 INNER JOIN COLORES AS C2 ON  C1.COLOR = C2.COdigo                                  " & _
        " WHERE C2.CLIENTE = '"&DATO&"' and c2.estado='a'  and C1.estado = 'A'  AND ('"&TELA&"'+C1.COLOR+C1.COMBIN                " & _
        " NOT IN (select ar_ccodigo COLLATE Modern_Spanish_CI_AS from RSFACCAR..AL0001ARTI)))   dd              " & _
        " where (left(colo,4)='9999' and right(colo,2)>'00') or (left(colo,4)<'9999' and right(colo,2)='00')    " & _
        " ORDER BY 2                                                                                            " 
        
		RS.OPEN CAD, CNN
		'RESPONSE.Write(cad)
		'RESPONSE.Write("<br>")
		'RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
			<%rs.movefirst%>
            <%do while not rs.eof%>
                <script type="text/jscript" language="jscript">
					aData[xx]     = '<%=trim(rs("COLO"))%>';
					aVal[xx++] = '<%=trim(rs("COLO"))%> - <%=trim(rs("descri"))%>';
                </script>
				<%=RS("coLO")%>
            	<%RS.MOVENEXT%>
            <%loop%>
            <script type="text/jscript" language="jscript">
				 for(i=1; i <= xx; i++) 
				  	select.options[i] = new Option( aVal[i-1], aData[i-1]); 				  
             </script>	
		<%end if%>


	FIN
</body>
</html>