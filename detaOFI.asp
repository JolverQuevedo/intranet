<%@ Language=VBScript%>
<% Response.Buffer = true%>
<%Session.LCID=2057%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<style>
	td{
		height: 40px;
	}
</style>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
 <!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/navegacion2.inc"-->
<!--#include file="COMUN/COMUNdetaofis.ASP"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->  
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow = 1
var url = '../detaOFI.asp?'
var alias = 'VIEW_OFIS'
var TBL = 'OFI'
var PK = 'ofi'
var DS = 'estilo'
var largo = 10  // es el largo del PK (se usa en el dataentry)
var largo2 = 50  // es el largo del descriptor

var oldrow = 1
var olddata = ''
var chk = ''
var ficha = 'fichaofi.asp?po='
mm = -1
// necesito la misma variable en jscript y vbscript para la navegacion
var pagesize = 20
</script>
<%Dim pageSize 
pageSize = 20

'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_OFIS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "OFI"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "detaOFI.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "OFI"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "ESTCLI"

' Captura la posici�n inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
OFI = Request.QueryString("OFI")
if OFI = "" or isnull(OFI)  or OFI = " " then
	OFI = ""
end if
pro = Request.QueryString("pro")
if pro = "" or isnull(pro)  or pro = " " then
	pro = ""
end if
EST = Request.QueryString("EST")
if EST = "" or isnull(EST)  or EST = " " then
	EST = ""
end if
'****************************************************
' si viene del buscador hay que ver si existe la PO
' sino, se manda mensaje y se pone en la primera PO
'****************************************************
cad = "select CODIGO from OFIS where CODIGO = '"&oFI&"' and cliente = '"&pos&"'"
rs.open cad, cnn
if rs.recordcount <=0 then ofi = ""
rs.close

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top "&pagesize&"  OFI, COTI, PROTO, VER, cart, ESTCLI,   " & _
        " CANT,  CODEST,tnt, FOT,  CON, CLI FROM VIEW_ofis AS T1" & _
		" WHERE T1.EDO = 'A'    		            " & _
        " and CLI   = '"&POS&"' and  "

IF   LEN(pro) > 0  THEN
    cad = cad + " proto >= '"&pro&"'	ORDER BY proto, ver, ofi" 
ELSEIF LEN(EST)> 0 THEN
    cad = cad + " estcli >= '"&EST&"'	ORDER BY estcli, ofi    " 
ELSE
    cad = cad + " ofi >= '"&ofi&"'	ORDER BY ofi     " 
END IF
  

	   '	response.Write(cad)
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
    mm = '<%=rs.recordcount%>'
    var funcionalidad = ''


</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="DETAcoti.asp">
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" width="100%"
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" valign="top">
    <%for I=0 to columnas-4 %>
	    <td align="center">
		    <font face="arial" color="IVORY" size="1">
		    <b><%=UCASE(RS.FIELDS(I).NAME)%></b>
		    </font>
	    </td>
    <%next%>
	<td><font face="arial" color="IVORY" size="1">
		    <b><%=RS.FIELDS(I).NAME%></b>
		    </font></td> 
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF %>
	<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top" ondblclick="EDITA('<%=cont%>')" align="center">
	    <%FOR i=0 TO columnas-4%>
		    <td class="texto td"><%=UCASE(TRIM(RS.FIELDS.ITEM(I))) %></td>
	    <%NEXT%>
	   <td class="img-zoom"><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("CODEST")%>&CLI=<%=POS%>" width="30" /></td> 
    </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:pointer;" onClick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras(alias, '<%=indice%>')" style="cursor:pointer" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede()" style="cursor:pointer" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="cursor:pointer" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=urlBase%>'+'?pos=')" style="cursor:pointer" /></td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la p�gina de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=urlBase%>','<%=ALIAS%>','<%=RS.Fields.Item(0).Name%>')" style="cursor:pointer;" /></td>
       
	    <td><img src="imagenes/PRINT.gif" alt="IMPRESION" onClick="imprime()" style="cursor:pointer;" /></td>
        <td><img id="Img4" alt="Imprime Ficha Corte" style="cursor:pointer; " onClick="CORTE()" src="imagenes/corte.jpg" /></td>
        <td><img id="Img1" alt="Consumo Tela" style="cursor:pointer; " onClick="TELAS()" src="imagenes/telas.jpg" /></td>
        <td><img id="Img2" alt="Consumo Avios" style="cursor:pointer; " onClick="AVIOS()" src="imagenes/avios.jpg" /></td>
        <td><img id="Img3" alt="Explosion" style="cursor:pointer; " onClick="tnt()" src="imagenes/tnt.png" /></td>
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=pk%></b></font></td>
		<td><input id="kod" name="kod" value=""/> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Estilo</b></font></td>
		<td><input id="est" name="est" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Proto</b></font></td>
		<td><input id="pro" name="pro" value=""/> </td>    
	  </tr>
	  
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%end if%>


<table border="0" align="center"  cellspacing="3">
    <tr>
        <td><img src="imagenes/NEW.gif"  alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:pointer;" /></td>
        <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:pointer;" /></td>		
    </tr>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<%rs.close%>

<script language="jscript" type="text/jscript">
if (marca == 0)
    dd('1');

function NUEVO() {
    window.open('fichaofi.asp?PO=AUTO&cli=' + '<%=pos%>' )
    return true;
}

function elimina(ff) 
{   var t = document.all.TABLA;
var pos = parseInt(oldrow, 10)

    POS = trim(t.rows(pos).cells(8).innerText);
  
    if (POS.length > 0) 
    {   alert("Esta PO ya est� asignada a una Ofi")
        return true;
    }
    else 
    {      /*
        document.all.body0.style.display = 'block'
        document.all.body0.height = "350"
        document.all.body0.width = "100%"
        */
        alert(trim(t.rows(pos).cells(0).innerText))
        dd = trim(t.rows(pos).cells(0).innerText);
        document.all.body0.src = "comun/deleofi.asp?ofi=" + dd + '&cli=' + '<%=trim(request.QueryString("pos"))%>';
        //document.all.body0.style.display = 'none'
    }
    return true;
}


function LLENA(ff)
{return true;
}

function CORTE() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    POS = ltrim(t.rows(pos).cells(0).innerText);
    window.open('reportes/prnfichaofi_CORTE.asp?ofi=' +POS + '&cli=' + '<%=pos%>')
}
function TELAS() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    POS = ltrim(t.rows(pos).cells(0).innerText);
    window.open('reportes/prnfichaofi_CORTE_tela.asp?ofi=' + POS + '&cli=' + '<%=pos%>')
}
function AVIOS() {
   
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    POS = ltrim(t.rows(pos).cells(0).innerText);
    window.open('reportes/prnfichaofi_avios.asp?ofi=' + POS + '&cli=' + '<%=pos%>')
}
function EDITA(ff)
{ var t = document.all.TABLA;
    var pos = parseInt(ff,10)
    POS = ltrim(t.rows(pos).cells(0).innerText);

    window.open('fichaofi.asp?ofi=' + POS + '&cli=' + '<%=pos%>')
    return true;
}

function tnt() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    POS = ltrim(t.rows(pos).cells(0).innerText);
    cad = 'explosiontelas.asp?ofi=' + POS
//alert(cad)
window.open(cad)
}
//pagina de inicio
pag = 'detaPOS.asp?cli=' + '<%=trim(request.QueryString("pos"))%>'
</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
