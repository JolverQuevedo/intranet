﻿<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">


<title>Untitled Document</title>
</head>

<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }
</script>
<%
'response.write(request.queryString())
'response.write("<br>")
'response.end
'response.write(request.querystring())

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	

Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.CursorLocation   = 3
	RS3.CursorType       = 3    
	RS3.LockType         = 1 	

ofi = request.QUERYSTRING("ofi")
' revisa si tiene explosion para crear o para mostrary lo redirecciona
cod = request.QueryString("COD")
tip = request.QueryString("tip")
MOV = request.QueryString("MOV")
SER = request.QueryString("SER")
ORI = request.QueryString("ORI")
DES = request.QueryString("DES")
OLD = request.QueryString("OLD")
ENT = request.QueryString("ENT")
REC = request.QueryString("REC")
LT1 = request.QueryString("LT1")
LT2 = request.QueryString("LT2")
cnt = request.QueryString("cnt")

cC2 = request.Cookies("aC2")
cQ2 = request.Cookies("aQ2")
cK2 = request.Cookies("aK2")
cD2 = request.Cookies("aD2")
cC1 = request.Cookies("aC1")
cQ1 = request.Cookies("aQ1")
cK1 = request.Cookies("aK1")
cD1 = request.Cookies("aD1")

 


ac2 = split(cC2,",")
aQ2 = split(cQ2,",")
aK2 = split(cK2,",")
aD2 = split(cD2,",")
ac1 = split(cC1,",")
aQ1 = split(cQ1,",")
aK1 = split(cK1,",")
aD1 = split(cD1,",")



cSql = request.cookies("cSql")

cSql = right(cSql, len(csql)-10)
dato = ""
grupo = ""
if lcase(lt2) = "c" then ' compra de tela cruda 
    dato = "crudo " 
    grupo =  "sum(kgsteje) as KGS_crudo , case when left(crudo,1) ='9' then sum(qty) else 0 end as qty"
elseif lcase(lt2) = "t" then
    dato = "tela " 
    grupo = "sum(kgs) as kgs_tela, case when left(tela,1) ='9' then sum(qty) else 0 end as qty"
else
    dato = "h1, h2, h3, h4, h5, h6 "
    grupo = "sum(k1) as k1, sum(k2) as k2, sum(k3) as k3, sum(k4) as k4, sum(k5) as k5, sum(k6) as k6, 0 as qty "
end if

kad = "select ofi, po, " + dato+ ", " + grupo + " " + cSql + " group by  ofi, po," + dato + " ORDER BY " + dato + ",ofi"
'response.write(kad)
RS.OPEN (KAD),CNN
IF RS.RECORDCOUNT> 0 THEN RS.MOVEFIRST
COLUMNAS = RS.FIELDS.COUNT-1
ofis = "('"
mani= 0
%>
<body style="margin-top:0; >

<form id="thisForm" method="post" name="thisForm" action="">
<iframe id="head" name="head" src=""  width="100%" scrolling="no" frameborder="1" height="100" style="display:none"></iframe>

<!--*****************************************************************************-->
<!------------- D E T A L L E      A     N I V E L      D E       O F I ----------->
<!--*****************************************************************************-->
<!--------------------------------------------------------------------------------->
<!-------------------- CUANDO ES COMPRA DE PRODUCTO FINAL ------------------------->
<!--------------------------------------------------------------------------------->
<%if ucase(trim(TIP)) = "C" then%>
<table align="center" cellspacing="0" border="1" cellpadding="0" id="detaC" name="detaC" style="display:block">
        <tr><td align="center" colspan="<%=columnas+1 %>"  width="90%" class="tituloGRANDEorange" 
        style="padding-left:10px;padding-right:10px;padding-top:10px;padding-bottom:10px;">
        Detalle para OC PRODUCTO FINAL</td>
        </tr>
        <tr>
            <%FOR I=0 TO COLUMNAS%>
            <td class="tituloGRANDEgris" style="text-align:center"><%=trim(ucase(rs.fields(i).name))%></td>
            <%NEXT%>
        </tr>
        <%ATOT = Array(null,null, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
         %>
        <%DO WHILE NOT RS.EOF%>  
            <tr style="padding-right:10px; padding-left:10px;" >
            <%FOR d=0 TO COLUMNAS%>
                <%  texto = ucase(RS.FIELDS.ITEM(d))%>
                <% if d = 0 then 
                    if inStr(ofis,texto) = 0 then ofis = ofis + trim(texto) + "','" 
                end if %>
                <td <%if d>2 then%> style="text-align:right; padding-right:10px;"<%end if%> class="textogris4" >

                <%IF ISNUMERIC(TEXTO) = true and d> 2 THEN 
                    if  cdbl(texto) > 0 then RESPONSE.WRITE formatnumber(RS.FIELDS.ITEM(d),3,,,true) else response.write("&nbsp;")
                        aTot(d) = aTot(d) + cdbl(RS.FIELDS.ITEM(d))
                    ELSE 
                    RESPONSE.WRITE("&nbsp;"+TEXTO)
                        end if%></td>
            <%NEXT %>
            </tr>
            <%RS.movenext%>
        <%loop%>
        <tr style="padding-right:10px; padding-left:10px;background-color:gainsboro; display:NONE" >
            <%FOR e=0 TO COLUMNAS%>
                
                <td <%if e>2 then%> style="text-align:right; padding-right:10px;"<%end if%> class="textogris4" >
                <%if aTot(e)<> 0 then response.Write(formatnumber(atot(e),3,,,true))else response.write("&nbsp;")%>
                </td>
            <%NEXT %>
        </tr>
</table>
      
    <%else%>
    <!--------------------------------------------------------------------->
    <!------------- CUANDO ES UN SERVICIO DE TRANSFORMACION --------------->
    <!--------------------------------------------------------------------->      
    <table align="center" cellspacing="2" border="0" cellpadding="2" id="detaS" name="detaS" style="display:block">
       <%ln=0%>  
       <tr id="itm" ><td align="center" colspan="<%=columnas+8%>"  class="tituloGRANDEROJO" 
        style="padding-left:10px;padding-right:10px;padding-top:10px;padding-bottom:10px;"><%=col1%> Detalle para OC SERVICIO DE TRANSFORMACION 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ser%> - <%=mov%></td>
        </tr>               
        <tr id="itm0">
            <td class="tituloGRANDEgris" style="text-align:center">Item</td>
            <td class="tituloGRANDEgris" style="text-align:center">OFI</td>
            <td class="tituloGRANDEgris" style="text-align:center">PO</td>
            <%if lt1 = "h" and LT2= "h"  then
               col1 = rs.fields.count-1
               
               for t=2 to col1-7 ' porque la ultima columna es qty y laS 6 ANTEPENULTIMAS SON LOS KILOS POR CADA HILO
                  if len(trim(rs.fields.item(t))) > 0 then mani = mani +1 
               next%>
               <%'=mani%>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI1">ORI1</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS1">KG1</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI2">ORI2</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS2">KG2</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI3">ORI3</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS3">KG3</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI4">ORI4</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS4">KG4</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI5">ORI5</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS5">KG5</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI6">ORI6</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS6">KG6</td>

                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="DES1">DES1</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KIL1">KGS1</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="DES2">DES2</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KIL2">KGS2</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="DES3">DES3</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KIL3">KGS3</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="DES4">DES4</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KIL4">KGS4</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="DES5">DES5</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KIL5">KGS5</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="DES6">DES6</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KIL6">KGS6</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="RS0">RSV</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="OCC0">OC</td>
            <%elseif lt1 = "h" then%>           
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI1">ORI1</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS1">KG1</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI2">ORI2</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS2">KG2</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI3">ORI3</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS3">KG3</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI4">ORI4</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS4">KG4</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI5">ORI5</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS5">KG5</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="ORI6">ORI6</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="KGS6">KG6</td>
                 <td class="tituloGRANDEgris" style="text-align:center">DESTINO</td>
                <td class="tituloGRANDEgris" style="text-align:center">KG_ENT</td>
                <td class="tituloGRANDEgris" style="text-align:center">QT_ENT</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="RS0">RSV</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;"  id="OCC0">OC</td>
            <%else%>
                <td class="tituloGRANDEgris" style="text-align:center">CODIGO</td>
               
                <td class="tituloGRANDEgris" style="text-align:center">KG</td>
                <td class="tituloGRANDEgris" style="text-align:center">QTY</td>
                <td class="tituloGRANDEgris" style="text-align:center">DESTINO</td>
                <td class="tituloGRANDEgris" style="text-align:center">DESCRIPCION</td>
                <td class="tituloGRANDEgris" style="text-align:center">KG_ENT</td>
                <td class="tituloGRANDEgris" style="text-align:center">QT_ENT</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="RS0">RSV</td>
                <td class="tituloGRANDEgris" style="text-align:center; display:block;" id="OCC0">OC</td>
            <%end if %>
        </tr>
        <%ATOT = Array(null,null, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)%>
      
        <%CONTA= 0%>       
        <%DO WHILE NOT RS.EOF%>  
             <%texto = ucase(RS.FIELDS.ITEM(0))%>
                <% if d = 0 then 
                    if inStr(ofis,texto) = 0 then ofis = ofis + trim(texto) + "','" 
                end if %>
            <% DESTINO = RS.FIELDS(2).name
                codigo = rs.fields.item(2)
                if len(trim(codigo)) = 6 then kod = codigo + "0000000000" else kod=codigo
                sas = "select ar_cdescri from rsfaccar..al0001arti where ar_ccodigo = '"&kod&"'"
                'response.Write(sas)
                descripcion= ""
                rs2.open sas,cnn
                if  rs2.recordcount > 0 then 
                    rs2.movefirst
                    descripcion = rs2("ar_cdescri")
                end if
                rs2.close
               off = RS.FIELDS.ITEM(0)
               if lcase(lt1) = "c" then ' ENTREGA TELA CRUDA
                   dato  = "crudo " 
                   grupo = "sum(kgsteje) as KGS_crudo , case when left(crudo,1) ='9' then sum(qty) else 0 end as qty"

               elseif lcase(lt1) = "t" then   ' ENTREGA TELA COLOR
                   dato = "tela " 
                   grupo = "sum(kgs) as kgs_tela, case when left(tela,1) ='9' then sum(qty) else 0 end as qty"
               else        ' ENTREGA HILADO
                   dato = "h1, h2, h3, h4, h5, h6 "
                   grupo = "sum(k1) as k1, sum(k2) as k2, sum(k3) as k3, sum(k4) as k4, sum(k5) as k5, sum(k6) as k6, 0 as qty "
               end if
             '  response.Write(destino)
               donde = " and ofi = '" + off + "' and " + destino + " = '" + codigo + "'"
               dad = "select ofi, po, " + dato+ ", " + grupo + " " + cSql + donde + " group by  ofi, po," + dato + " ORDER BY " + dato + ",ofi "
            'response.write(dad)
           ' response.end
          rs2.open dad,cnn
          col2 = rs2.fields.count-1
          if rs2.recordcount > 0 then rs2.movefirst
          dac=1
          mac=1
         'RESPONSE.WRITE(Dad)%>
          <%'=kad%>
            <tr style="padding-right:10px; padding-left:10px;" id='itm<%=CONTA%>' >
                <td style="text-align:left; " class="textogris4"><%=(ln/2)%></td>
                <td style="text-align:left; " class="textogris4"><%=ucase(RS.FIELDS.ITEM(0))%></td>
                <td style="text-align:left; " class="textogris4"><%=ucase(RS.FIELDS.ITEM(1))%></td>
                <%if lt1 = "h" and LT2= "h"  then %><!-- ORIGEN -->
                    <td style="text-align:left; " class="textogris4"><%=ucase(RS2.FIELDS.ITEM(2))%></td>
                    <td style="text-align:right;" class="textogris4"><%=formatnumber(RS2.FIELDS.ITEM(8),3,,,TRUE)%></td>
                    <%FOR w=3 TO mani+2%>
                        <% IF  len(TRIM(RS.FIELDS.ITEM(w))) > 1 Then%>
                            <td style="text-align:right; " class="textogris4"><%=RS2.FIELDS.ITEM(w)%> </td>
                            <td style="text-align:right; " class="textogris4"><%=formatnumber(RS2.FIELDS.ITEM(w+6),3,,,TRUE)%></td>
                        <%END IF%>
                    <%NEXT %>              
                    <%FOR w=2 TO mani+2%>
                        <% IF  len(TRIM(RS2.FIELDS.ITEM(w))) > 1Then%>
                            <td style="text-align:right; " class="textogris4"><%=RS.FIELDS.ITEM(w)%></td>
                            <td style="text-align:right; " class="textogris4"><%=formatnumber(RS.FIELDS.ITEM(w+6),3,,,TRUE)%></td>
                            <%dac=DAC+1%>
                        <%END IF%>
                    <%NEXT %>
                    <td style="text-align:center; " class="textogris4"><input id='RS<%=CONTA%>' type="button" class="botonok4"  onclick="RESER('<%=LN%>',1, '<%=kod%>')"  onmouseover="this.className='botonok5'" onmouseout="this.className='botonok4'"/></td>
                    <td style="text-align:center; " class="textogris4"><input id='OC<%=CONTA%>' type="checkbox" onclick="mira('<%=conta%>','<%=ln%>')" /></td>
                    
                <%elseif lt1 = "h" then%>
                    <%mAC=1%>             
                    <%FOR w=2 TO mani+3%>
                        <td style="text-align:right; " class="textogris4"><%=RS2.FIELDS.ITEM(w)%></td>
                        <td style="text-align:right; " class="textogris4"><%=formatnumber(RS2.FIELDS.ITEM(w+6),3,,,TRUE)%> </td>
                        <%mac=mAC+1%>
                    <%NEXT %>             
                    <td style="text-align:right;  " class="textogris4"><%=RS.FIELDS.ITEM(2)%> </td>
                    <td style="text-align:right;  " class="textogris4"><%=formatnumber(RS.FIELDS.ITEM(3),3,,,TRUE)%></td>
                    <td style="text-align:right;  " class="textogris4"><%=formatnumber(RS.FIELDS.ITEM(4),0,,,TRUE)%></td>
                    <td style="text-align:center; " class="textogris4">
                    <input id='RV<%=CONTA%>' type="button" class="botonok4"  onmouseout="this.className='botonok4'" 
                    onmouseover="this.className='botonok5'"   onclick="RESER('<%=LN%>',2, '<%=kod%>');"  style="display:none"/>
                    </td>
                    <td style="text-align:center; " class="textogris4"><input id='OC<%=CONTA%>' type="checkbox" style="display:none" onclick="mira('<%=conta%>','<%=ln%>')" /></td>
                     
                <%else%> 
                    <td style="text-align:right;  " class="textogris4"><%=RS2.FIELDS.ITEM(2)%><%=chr(127)%> </td>
                    <td style="text-align:right;  " class="textogris4"><%=formatnumber(RS2.FIELDS.ITEM(3),3,,,TRUE)%></td>  
                    <td style="text-align:right;  " class="textogris4"><%=formatnumber(RS2.FIELDS.ITEM(4),3,,,TRUE)%></td> 
                    <td style="text-align:right;  " class="textogris4"><%=RS.FIELDS.ITEM(2)%> </td>
                    <td style="text-align:left;   " class="textogris4"><%=descripcion%></td>
                    <td style="text-align:right;  " class="textogris4"><%=formatnumber(RS.FIELDS.ITEM(3),3,,,TRUE)%></td>
                    <td style="text-align:right;  " class="textogris4"><%=formatnumber(RS.FIELDS.ITEM(4),0,,,TRUE)%></td>
                    <td style="text-align:center; " class="textogris4">
                    <input id='RV<%=CONTA%>' type="button" class="botonok4" 
                    onmouseover="this.className='botonok5'"  onclick="RESER('<%=LN%>',3, '<%=kod%>')" onmouseout="this.className='botonok4'"/></td>
                    <td style="text-align:center; " class="textogris4"><inpu3t id='OC<%=CONTA%>' type="checkbox" onclick="mira('<%=conta%>')" /></td>
                     
                <%end if%>   
                <%cch1 = RS2.FIELDS.ITEM(2)
                      of = RS2.FIELDS.ITEM(0)
                      Mam = " select * from ordencompra where ofi = '"&of&"' " & _
                            " and codigo = '"&ser&"'  AND CODDES = '"&KOD&"' " & _
                            " and almdes = '"&des&"'  "
                         '  response.write(mam)
                        rs3.open mam, cnn
                        if rs3.recordcount > 0 then show= 0 else show=1
                        rs3.close
                     %>
                     <script language="jscript" type="text/jscript">

                         sh = parseInt('<%=show%>', 10)
                         cnt = parseInt('<%=conta%>', 10)
                         ooc = "OC" + cnt.toString()
                         voc = "RV" + cnt.toString()
                         if (sh == 0) {
                             document.getElementById(ooc).style.display = 'none'
                             document.getElementById(voc).style.display = 'none'
                             //  alert("Esta ofi ya tiene OC para este servicio\no se puede realizar movimiento")
                         }
                         else {
                             document.getElementById(ooc).style.display = 'block'
                             document.getElementById(voc).style.display = 'block'
                         }
                    </script>           
            </tr>
            <tr id="sp<%=ln%>" >
            <td colspan='<%=columnas+8 %>'>
            <iframe id="if<%=ln%>" name="if<%=ln%>" src=""  width="100%" scrolling="no" frameborder="1" onload="autofitIframe(this)" style="display:none"></iframe>
            </td>
            </tr>
            <%rs2.close%>
            <%CONTA = CONTA + 1 %>
            <%ln = ln +2%>
            <%RS.movenext%>            
        <%loop%>
         <script language="jscript" type="text/jscript">
         //  oculta las columnas que no tienen datos
            dac = parseInt('<%=dac%>', 10)
            mac = parseInt('<%=mac%>', 10)
             lt1 = '<%=lt1%>'
             lt2 = '<%=lt2%>'

             if (lt1 == 'h' && lt2 == 'h')
                 dac = dac
             else if (lt1 == 'h' && lt2 != 'h')
                 dac = mac
             else // porque no tiene hilos
                 dac = 7
                   
           //  alert(dac)
             if (trim(lt1) == 'h') {
                 for (u = dac; u < 7; u++) {
               //  alert(u)
                     oo = "ORI" + u.toString()
                     bb = "KGS" + u.toString()
                     document.getElementById(oo).style.display = 'none'
                     document.getElementById(bb).style.display = 'none'
                 }
             }
             //alert("ssss")
            if (lt2 == 'h') {
                for (mu = dac; mu < 7; mu++) {
                    os = "DES" + mu.toString()
                    bs = "KIL" + mu.toString()
                    document.getElementById(os).style.display = 'none'
                    document.getElementById(bs).style.display = 'none'
                }
            }
           //  alert()
        </script>
        <tr >
            <td colspan="<%=COLUMNAS+7%>" align="center">&nbsp;</td>
            <td align="center"><input type="button" class="botongold" onclick="ordCOM()" /></td>
            
        </tr>
</table>
<%end if %>
<p></p>
<!--------------------------------------------------------------------------------->
<!------------- DATOS RESUMIDOS PARA EMITIR LA ORDEN DE COMPRA -------------------->
<!--------------------------------------------------------------------------------->     
<%if ucase(trim(TIP)) = "C" then%>

            <table align="center" cellspacing="1" border="1" cellpadding="3" id="resumenC" name="resumenC" style="display:block" >
              <tr><td height="60px;" colspan="16" class="tituloMODELADOR">ORDEN DE  <%=mov %>         </td></tr>
                           <tr style="text-align:center">
                    <td style="text-align:center; background-color:#826f39;color:#fff;FONT-WEIGHT: 700;FONT-SIZE: 12px;
                        FONT-FAMILY: Arial;TEXT-ALIGN: CENTER; " >RSV</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">CODIGO</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">DESCRIPCION</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">KGS</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">QTY</td>
                    <td style="text-align:center" class="tituloGRANDEROJO">U.M.</td>
                    <td style="text-align:center" class="tituloGRANDEROJO">STK</td>
                    <td style="text-align:center" class="tituloGRANDEROJO">ALM</td>
                    <td style="text-align:center" class="tituloRESUMEN">SUGERIDO</td>
                    <td style="text-align:center; background-color:#d404d2; color:#fff;FONT-WEIGHT: 700;FONT-SIZE: 12px;
                        FONT-FAMILY: Arial;TEXT-ALIGN: CENTER; ">RSV</td>
                    <td style="text-align:center; background-color:#826f39; color:#fff;FONT-WEIGHT: 700;FONT-SIZE: 12px;
                        FONT-FAMILY: Arial;TEXT-ALIGN: CENTER; ">OC</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">ULT. O/C</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">CAN</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">US$</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">RUC</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">PROVEEDOR</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">ULT COMPRA</td>
                </tr>
                     <% UFO = left(trim(ofis), len(trim(ofis))-2)
                        UFO = right(trim(UFO), len(UFO)-1)
                        UFO = replace(ufo, "'","")
                      '  response.write(ufo)
                     ofis= left(trim(ofis), len(trim(ofis))-2)+ ")"%>   
                     <%FOR I= 0 TO UBOUND(aC2)%>     
                     
                     <%RS.CLOSE
                           if len(trim(ac2(i))) < 16 and lt2 = "h" then 
                                ac2(i) = left(trim(ac2(i))+"000000000000",12) 
                            else
                                ac2(i) = left(trim(ac2(i))+"000000000000000",16) 
                            end if
                            'response.write(ofis)
                        CAD = " SELECT DISTINCT '1' as orden, SK_NSKDIS= ISNULL((select SK_NSKDIS-(select CAN = CASE  WHEN SUM(QTY)>0 THEN SUM(QTY) " & _
                              " WHEN SUM(KGS) > 0 THEN SUM(KGS) ELSE 0 END from rsv_tela  where CODIGO = '"&AC2(I)&"')                              " & _
                              " from rsfaccar..AL0001STOC where sk_calma = ('"&DES&"')  and sk_ccodigo= '"&AC2(I)&"'),0),                           " & _
                              " OC  = (SELECT TOP 1 OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " CAN = (SELECT TOP 1 OC_NCANORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " PRE = (SELECT TOP 1 OC_NPREUNI FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " UND = (SELECT TOP 1 OC_CUNIDAD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&ac2(i)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " RUC = (SELECT TOP 1 OC_CCODPRO FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " PRO = (SELECT top 1 OC_CRAZSOC FROM RSFACCAR..CO0001MOVC AS AA INNER JOIN RSFACCAR..CO0001MOVD AS SS ON             " & _
                              " SS.OC_CNUMORD = AA.OC_CNUMORD AND AA.OC_CCODPRO = SS.OC_CCODPRO where ss.OC_CCODIGO = '"&ac2(i)&"' and              " & _
                              " aa.OC_CNUMORD = (SELECT TOP 1 OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO =  '"&AC2(I)&"' and             " & _
                              " ISNULL((select SK_NSKDIS - (select CAN = CASE  WHEN SUM(QTY) > 0 THEN SUM(QTY)                                      " & _
                              " WHEN SUM(KGS) > 0 THEN SUM(KGS) ELSE 0 END from rsv_tela  where CODIGO = '"&AC2(I)&"')                              " & _
                              " from rsfaccar..AL0001STOC where sk_calma = ('"&DES&"')  and sk_ccodigo= '"&AC2(I)&"'),0) > 0                        " & _
                              " ORDER BY OC_CNUMORD DESC) ),                                                                                        " & _
                              " fec = (SELECT TOP 1 OC_dfecdoc FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&ac2(i)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " sk_calma,                                                                                                           " & _
                              " RSV = (SELECT ISNULL(sum(CASE WHEN QTY=0 THEN KGS ELSE QTY END),0) FROM RSV_TELA WHERE CODIGO='"&AC2(I)&"'          " & _
                              " AND ALM='"&DES&"'   and ofi in "&ofis&")                                                                            " & _
                              " FROM RSFACCAR..AL0001STOC WHERE SK_CALMA = ('"&DES&"' ) AND SK_CCODIGO = '"&AC2(I)&"'                               " & _
                              " UNION                                                                                                               " & _
                              " SELECT DISTINCT '2' as orden,SK_NSKDIS= ISNULL((select SK_NSKDIS-(select CAN = CASE  WHEN SUM(QTY)>0 THEN SUM(QTY)  " & _
                              " WHEN SUM(KGS) > 0 THEN SUM(KGS) ELSE 0 END from rsv_tela  where CODIGO = '"&AC2(I)&"')                              " & _
                              " from rsfaccar..AL0001STOC where sk_calma = ('"&OLD&"')  and sk_ccodigo= '"&AC2(I)&"'), 0),                          " & _
                              " OC  = (SELECT TOP 1 OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " CAN = (SELECT TOP 1 OC_NCANORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " PRE = (SELECT TOP 1 OC_NPREUNI FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " UND = (SELECT TOP 1 OC_CUNIDAD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&ac2(i)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " RUC = (SELECT TOP 1 OC_CCODPRO FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " PRO = (SELECT top 1 OC_CRAZSOC FROM RSFACCAR..CO0001MOVC AS AA INNER JOIN RSFACCAR..CO0001MOVD AS SS ON             " & _
                              " SS.OC_CNUMORD = AA.OC_CNUMORD AND AA.OC_CCODPRO = SS.OC_CCODPRO where ss.OC_CCODIGO = '"&ac2(i)&"' and              " & _
                              " aa.OC_CNUMORD = (SELECT TOP 1 OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO =  '"&AC2(I)&"'                 " & _
                              " ORDER BY OC_CNUMORD DESC) ),                                                                                        " & _
                              " fec = (SELECT TOP 1 OC_dfecdoc FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&ac2(i)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " sk_calma, 0                                                                                                         " & _
                              " FROM RSFACCAR..AL0001STOC WHERE SK_CALMA = ('"&OLD&"' ) AND SK_CCODIGO = '"&AC2(I)&"'  and                          " & _
                              " ISNULL((select SK_NSKDIS - (select CAN = CASE  WHEN SUM(QTY) > 0 THEN SUM(QTY)                                      " & _
                              " WHEN SUM(KGS) > 0 THEN SUM(KGS) ELSE 0 END from rsv_tela  where CODIGO = '"&AC2(I)&"')                              " & _
                              " from rsfaccar..AL0001STOC where sk_calma = ('"&old&"')  and sk_ccodigo= '"&AC2(I)&"'),0) > 0 order by orden         "
                        '*********************************************************
                        '    FALTA RESTAR LA CANTIDAD QUE YA ESTÁ COMPROMETIDA
                        '*********************************************************
                        'response.write(cad)
                        'response.write("<BR>")
                        'RESPONSE.END
                        RS.OPEN CAD,CNN%>
                          <tr  class="TEXTO4" id="lin<%=i%>">
                            <td ><%if rs.recordcount> 0 then
                                    if ucase(trim(des)) = ucase(TRIM((RS("SK_CALMA")))) and CDBL(RS("SK_NSKDIS")) <> 0  then %>
                                        <input id="ch<%=I%>" type ="checkbox" style="display:block;">
                                    <%end if %>
                                <%end if %>
                            &nbsp;</td>
                            <td style="text-align:left;  background-color:#CFFEDD" id="c<%=i%>" ><%=TRIM(ac2(i))%></td>
                            <td style="text-align:left;  background-color:#CFFEDD" id="d<%=i%>"><%=TRIM(aD2(i))%></td>
                            <td style="text-align:right; background-color:#CFFEDD" id="k<%=i%>"><%=FORMATNUMBER(TRIM(ak2(i)),3,,,TRUE)%>
                            <input id="kg<%=i%>" value="<%=FORMATNUMBER(TRIM(ak2(i)),3,,,TRUE)%>" style="display:none;width:60px" /></td>
                            <td style="text-align:right; background-color:#CFFEDD" id="q<%=i%>"> 
                              <input id="qt<%=i%>" value="<%=FORMATNUMBER(TRIM(aq2(i)),0,,,TRUE)%>" style="display:none;width:60px" />                
                                <!-- DEPENDE SI HAY CANTIDAD ES PORQUE HAY RECTILINEO POR UNIDADES  -->
                                <%IF aq2(i) <> 0 THEN  response.write(FORMATNUMBER(TRIM(aq2(i)),0,,,TRUE)) ELSE response.write("&nbsp;")%></td>        
                        <% IF RS.RECORDCOUNT > 0 THEN %>  <!-- ES PORQUE ENCONTRO DATOS EN EL ARCHIVO DE STOCKS.... -->
                            <td style="text-align:right; background-color:#FCE0F9" id="u<%=i%>"><%=TRIM(RS("UND"))%></td>          
                            <td style="text-align:right; background-color:#FCE0F9;cursor:pointer;" ondblclick="partida('a','<%=i%>')" id="s<%=i%>" >
                            <%if UCASE(trim(RS("UND"))) = "UND" THEN 
                                if CDBL(RS("SK_NSKDIS")) <> 0 then response.write(FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),0,,,TRUE)) else response.Write("&nbsp;")
                              else 
                                if CDBL(RS("SK_NSKDIS")) <> 0 then response.write(FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),3,,,TRUE)) else response.Write("&nbsp;")
                              end if%>
                            <!-- VERIFICA SI ES EL ALMACEN NUEVO PARA HACER EL SUGERIDO SI ES EL ANTIGUO, LO MUESTRA SOLO COMO AYUDA REFERENCIAL -->
                            <%if ucase(trim(rs("sk_calma"))) = ucase(trim(des)) THEN%>
                                <%IF  aq2(i) <> 0 THEN 
                                        SUGE = CDBL(TRIM(aQ2(i))) - CDBL(RS("SK_NSKDIS")) 
                                       if suge = 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                ELSE 
                                    SUGE = CDBL(TRIM(ak2(i))) - CDBL(RS("SK_NSKDIS"))
                                    if suge = 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                END IF%>
                            <%ELSE%>
                                <%IF  aq2(i) <> 0 THEN 
                                        SUGE = CDBL(TRIM(aQ2(i)))
                                       if suge = 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                ELSE 
                                    SUGE = CDBL(TRIM(ak2(i))) 
                                    if suge = 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                END IF %>
                            <%END IF%>                          
                            </td>                      
                            <script language="jscript" type="text/jscript">
                                i= '<%=i%>'
                                if( parseFloat(eval("document.all.s"+i+".innerText"))<=0)
                                    eval("document.all.ch"+i+".style.display='none'")
                            </script>
                            <td style="text-align:right; background-color:#FCE0F9" id="a<%=i%>">
                            <%=TRIM((RS("SK_CALMA")))%></td>            
                            <td style="text-align:right; background-color:#C1D3FF;">
                            <input type="text" value="<%=suge%>" class="DATOSceleste" id="sug<%=i%>" style="text-align:right; 
                                padding-right:10px;width:60px" onchange="valida(this,'<%=i%>')"  onfocus="seleccionar(this)" />
                            <%if suge = "" then suge = 0 %>
                            <input id="su<%=i%>" name="su<%=i%>" value='<%=suge%>' style="display:none;width:60px" /> 
                            </td>                          
                            <td style="background-color:#f7b7f6" >
                             <input id="rs<%=i%>" name="rs<%=i%>" value='<%=CDBL(rs("rsv"))%>' style="display:none;width:60px" /> 
                            <%IF CDBL(rs("rsv")) > 0 THEN %><%=FORMATNUMBER(CDBL(rs("rsv")),3,,,true)%><%else%>&nbsp;<%end if%></td>                           
                            <script language="javascript" type="text/jscript">
                               // modifica el sugerido!!!
                               i = parseInt('<%=i%>', 10)
                               dd = i.toString()
                               su = document.getElementById("su" + dd).value
                               ss = su.replace(',','');
                               suger = parseFloat(ss) 
                               ki = document.getElementById("kg" + dd).value.replace(',','');
                               kilos = parseFloat(ki)
                               ca = document.getElementById("qt" + dd).value.replace(',','')
                               canti = parseInt(ca,10);
                               re = document.getElementById("rs" + dd).value.replace(',','')
                               reser = parseFloat(re);
                               nuevo = '';                      
                               if (reser > 0) {
                                   if (canti > 0) {
                                       if (parseInt(canti, 10) > parseInt(reser, 10)) {
                                           nuevo = parseInt(ss,10) - parseInt(re,10) 
                                      }
                                   }
                                   else {
                                       if (parseFloat(kilos) > parseFloat(reser)) 
                                       {  nuevo = (parseFloat(suger) - parseFloat(reser)).toFixed(3);      }
                                   }
                                   if (parseInt(nuevo, 10) <= 0)
                                       nuevo = ''
                                   document.getElementById("sug" + dd).value = nuevo
                               }
                            </script>                           
                            <td><%if ucase(trim(des)) = ucase(TRIM((RS("SK_CALMA")))) then %>
                                <input id="co<%=i%>" type ="checkbox" style="display:block" onclick="bake('<%=i%>', this)" />
                                <%end if %>&nbsp;</td>
                            <script type="text/jscript" language="jscript">
                                i = '<%=i%>'
                                if (trim(eval("document.all.sug" + i + ".value")) == '') 
                                {  eval("document.all.co" + i + ".style.display='none'")        }
                            </script>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=TRIM(RS("OC"))%></td>                        
                             <%if isnull(RS("CAN")) then can= 0 else can = CDBL(RS("CAN")) %>
                            <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(can,3,,,TRUE)%></td>
                             <%if isnull(RS("pre")) then can= 0 else can = CDBL(RS("pre")) %>
                            <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(can,2,,,TRUE)%></td>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=TRIM(RS("RUC"))%>&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=TRIM(RS("PRO"))%>&nbsp;</td>
                             <%if isnull(RS("fec")) then fec= "" else fec =formatdatetime(rs("fec"),2) %>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=fec%></td>
                        <%else %>
                            <td style="text-align:right; background-color:#FCE0F9">&nbsp;</td>
                            <td style="text-align:left ; background-color:#FCE0F9" id="s<%=i%>">&nbsp;</td>
                            <td style="text-align:right; background-color:#FCE0F9">&nbsp;</td>
                            <td style="text-align:right; background-color:#C1D3FF;" ondblclick="partida('a','<%=i%>')">
                            <input type="text" value="<%=FORMATNUMBER(TRIM(ak2(i)),3,,,TRUE)%>" class="DATOSceleste" id="sug<%=i%>" 
                            style="text-align:right;padding-right:10px;width:60px" 
                             onchange="valida(this,'<%=i%>')"  onfocus="seleccionar(this)"/></td>
                             <td style="background-color:#f7b7f6">&nbsp;</td>
                            <td><%IF RS.RECORDCOUNT > 0 THEN %>
                                    <%if ucase(trim(des)) = ucase(TRIM((RS("SK_CALMA")))) then %>
                                        <input id="co<%=i%>" type ="checkbox" />
                                    <%END IF %>
                                <%ELSE%>
                                      <input id="co<%=i%>" type ="checkbox" />
                                <%END IF%>&nbsp;</td>
                            <td style="text-align:right; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                        <%END IF %>
                          </tr>
                        <%IF RS.RECORdCOUNT >1 THEN 
                            RS.MOVENEXT %>
                      
                           <tr  class="TEXTO4" id="ln<%=i%>">
                                <td><%IF RS.RECORDCOUNT > 1 THEN %>
                                    <%if ucase(trim(des)) = ucase(TRIM((RS("SK_CALMA")))) then %>
                                        <input id="cc<%=i%>" type ="checkbox" />
                                    <%END IF %>
                                <%END IF%>
                               &nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="ca<%=i%>">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="da<%=i%>">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="ka<%=i%>">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="qa<%=i%>">&nbsp;</td>
                                <td style="text-align:right; background-color:#FCE0F9" ><%=trim(RS("UND")) %></td>
                         
                                 <%if UCASE(trim(RS("UND"))) = "UND" THEN%>
                                        <%dis =FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),0,,,TRUE)%>
                                    <%else%>
                                        <%dis =FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),3,,,TRUE)%>
                                    <%end if %>
                          
                                    <!-- VERIFICA SI ES EL ALMACEN NUEVO PARA HACER EL SUGERIDO -->
                                    <!-- SI ES EL ANTIGUO, LO MUESTRA SOLO COMO AYUDA REFERENCIAL -->
                                    <%if ucase(trim(rs("sk_calma"))) = ucase(trim(des)) THEN%>
                                        <%IF  aq2(i) <> 0 THEN 
                                                SUGE = CDBL(TRIM(aQ2(i))) - CDBL(RS("SK_NSKDIS")) 
                                        ELSE 
                                            SUGE = CDBL(TRIM(ak2(i))) - CDBL(RS("SK_NSKDIS"))
                                        END IF%>
                                    <%ELSE%>
                                        <%SUGE = CDBL(TRIM(ak2(i)))%>
                                <%END IF%>
                                <td style="text-align:right; background-color:#FCE0F9; cursor:pointer;" id="st<%=i%>" 
                                ondblclick="partida('old','<%=i%>')" ><%=dis%></td>
                                <td style="text-align:right; background-color:#FCE0F9;" id="old<%=i%>"><%=TRIM(RS("SK_CALMA"))%></td>
                                <td style="text-align:right; background-color:#C1D3FF" >&nbsp;</td>
                                <td style="background-color:#f7b7f6">&nbsp;</td>
                                <td><%IF RS.RECORDCOUNT > 1 THEN %>
                                        <%if ucase(trim(des)) = ucase(TRIM((RS("SK_CALMA")))) then %>
                                            <input id="co<%=i%>" type ="checkbox" />
                                        <%END IF%>
                                    <%END IF%>&nbsp;</td>
                                <td style="text-align:right; background-color:#E5E5E5"><%=TRIM(RS("OC"))%></td>
                                <%if isnull(RS("CAN")) then can= 0 else can = CDBL(RS("CAN")) %>
                                <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(can,3,,,TRUE)%></td>
                                <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(TRIM(CDBL(RS("PRE"))),2,,,TRUE)%></td>
                                <td style="text-align:right; background-color:#E5E5E5"><%=TRIM(RS("RUC"))%></td>
                                <td style="text-align:left;  background-color:#E5E5E5"><%=TRIM(RS("PRO"))%></td>
                                  <%if isnull(RS("fec")) then fec= "" else fec =formatdatetime(rs("fec"),2) %>
                                <td style="text-align:left ; background-color:#E5E5E5"><%=fec%></td>
                            </tr>
                        <%END IF%>
                    <%next %>
               <tr>
                <td><input type="button" class="botonrsv" onclick="reserva()"></td>
                <td colspan="8"></td>
                <td><input type="button" class="botonrsv" onclick="orden()"></td>
               </tr>
            </table>
        
<%ELSE %>
    <!----------------------------------------------------
            DATOS PARA SERVICIOS DE TRANSFORMACION
            está en el cuadro superior porque tiene
            origen y destino y se necesita reserva
            para poder enviar al servicio
    ------------------------------------------------------>

<%END IF%>   
</form>  
<script language="jscript" type="text/jscript">

autofitIframe(this.id)

    var maxi = parseInt('<%=i%>', 10)
  // alert(maxi)

    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=350,width=700";
    var des = trim('<%=des%>')
    for (v = 0; v < maxi; v++) 
    {   dd = "ch" + v.toString()
        so = "s" + v.toString()
        var ele = document.getElementById(dd);
        var sos = document.getElementById(so);
        if (sos != null) 
        {        if (trim(eval("document.all.s" + v + ".innerText")) == '' && ele !== null) 
            {   eval("document.all.ch" + v + ".style.display='none'")       
              }
            if (trim(eval("document.all.sug" + v + ".value")) == '' && trim(eval("document.all.sug" + RS + ".value")) != '' && ele !== null) {
                eval("document.all.ch" + v + ".style.display='none'")
            }
        }
    } 
    //alert()
function partida(data, ff) {
    lt2 = trim('<%=lt2 %>')
    cod = eval("trim(document.all.c" + ff + ".innerText)");
    alm = eval("trim(document.all." + data + ff + ".innerText)");
    //alert(alm)
    cad = 'help/HLPpartida.asp?cod=' + cod + '&alm=' + alm
    window.open(cad, '', opc)
}
    function valida(obj, ff) {
        obj.value = toInt(obj.value)
        var cod = eval("trim(document.all.c" + ff + ".innerText)");
        var kg = eval("trim(document.all.k" + ff + ".innerText)");
        var qt = eval("trim(document.all.q" + ff + ".innerText)");
        var st = eval("trim(document.all.s" + ff + ".innerText)");
        var ped = parseFloat(obj.value)
        var qtt = qt.replace(',', '')
        var kgt = kg.replace(',', '')

        if (isNaN(qtt) != true) {
            qty = parseFloat(qtt)
            kgs = parseFloat(kgt)
        }
        else {
            qty = 0
            kgs = 0
        }
        stt = st.replace(',', '')
        if (isNaN(stt) != true)
            stk = parseFloat(stt)
        else
            stk = 0

        if (qty > 0)
        { dif = qty - ped }
        else
        { dif = kgs - ped }

        if (dif < 0) {
            alert("Esta intentando comprar mas de lo que se necesita\nEsto no esta permitido ")
            return false;
        }
    }
    function reserva() {
        rsv = 0
        aCod = new Array()
        aAlm = new Array()
        aCan = new Array()
        aDes = new Array()
        lt2 = trim('<%=lt2 %>')
        //alert(lt2)
        for (b = 0; b < maxi; b++) {
            cc = "ch" + b.toString()
            ell = document.getElementById(cc);
            if (ell !== null) 
            {   if (ell.style.display == 'block') 
                { if (ell.checked == true) 
                   {    cod = eval("trim(document.all.c" + b + ".innerText)");
                        ss = "s" + b.toString()
                        var vl = document.getElementById(ss);
                        if (vl !== null)
                            can = eval("trim(document.all.s" + b + ".innerText)");
                        else
                            can = 0;
                        qty = can.replace(',', '')
                        // la cantidad que hay en el almacén
                        if (trim(qty) != '')
                            can = parseFloat(qty)
                        // si es rectilineo el requerido viene en unidades 
                        if (Left(trim(cod), 1) == '9') 
                        {
                            qq = "q" + b.toString()
                            qt = document.getElementById(qq);
                            if (vl !== null) 
                            {
                                cnt = eval("trim(document.all.q" + b + ".innerText)");
                                qty = cnt.replace(',', '');
                                cnt = parseInt(qty, 10);
                            }
                            else {
                                cnt = 0;
                            }
                        }
                        else  // si es tela normal
                        {
                            cnt = eval("trim(document.all.k" + b + ".innerText)");
                            qty = cnt.replace(',', '');
                            cnt = parseFloat(qty);
                        }
                        if (can > cnt)
                            canti = cnt
                        else
                            canti = can                                               
                        alm = eval("trim(document.all.a" + b + ".innerText)");
                        aCod[rsv] = cod;
                        aAlm[rsv] = alm;
                        aDes[rsv] = eval("ltrim(document.all.d" + b + ".innerText)");
                        aCan[rsv++] = can;

                    }  // del checked
                } // del display block
            } // si existe
        }  // del for
        if (rsv == 0) {
            alert("Nada que reservar")
        }
        else {
            cad = 'help/hlpRSV.asp?cod=' + aCod + '&alm=' + aAlm + '&can=' + aCan + '&lt2=' + '<%=lt2%>' + '&des=' + aDes
            //    alert('<%=txtusuario%>')
            window.open(cad)
        }
    }


function orden() {
var fin = 0    
var aCod = new Array()
var aCan = new Array()
    for (f = 0; f < maxi; f++) {
        cc = "co" + f.toString()
        ell = document.getElementById(cc);
        if (ell !== null) 
        {
            if (ell.checked == true && ell.style.display=='block') {
                //alert("OC")
                aCod[fin]   = eval("trim(document.all.c" + f + ".innerText)");
                dd = eval("trim(document.all.sug" + f + ".value)");
                datos = dd.replace(',','')
                aCan[fin++] = datos
            }
        }
    }
    if (fin == 0)
    { alert("Nada que emitir") }
    else {
        // ORDEN DE COMPRAAAA

        ofi = '<%=replace(ofis, "'" , "")%>'
        off = Left(ofi, ofi.length - 1)
        aOfi = Right(off,off.length-1)
        
        cad = 'fichaocNEW.asp?des=' + '<%=des%>'
        cad += '&cod=' + aCod
        cad += '&can=' + aCan
        cad += '&ofi=' + aOfi
        cad += '&lt2=' + '<%=lt2%>'
        cad += '&al2=' + '<%=des%>'
        cad += '&lt1=' + '<%=lt1%>'
        cad += '&al1=' + '<%=ori%>'
        cad += '&cla=' + 'C'
        //alert(cad)       
   window.open(cad,'OC_Auto',opc) 
    
  }
}
function bake(pos, obj) {
//document.all.head.style.display='block'

    if (obj.checked == true) {
        ofi = '<%=ufo%>'
        alm = '<%=des%>'
        cod = eval("trim(document.all.c" + pos + ".innerText)");
        cad = 'bake/bakeOC.asp?pos=' + pos + '&ofi=' + ofi + '&cod=' + cod + '&alm=' + alm + '&TIP=' + '<%=LT2%>'
       // alert(cad)
        document.all.head.src = cad
    }
    else {  obj.style.backgroundColor = '#fff' }
}

function RESER(LIN, OP, kod) {

var t = document.all.detaS;

LIN = parseInt(LIN,10)+2
cols = parseInt(t.rows(LIN).cells.length,10)-2
lt1 = '<%=lt1%>'
lt2 = '<%=lt2%>'
ori = '<%=ori%>'
ser = '<%=ser%>'
des = '<%=des%>'
ll= parseInt(LIN,10) - 2
// el if viene de iframe
ln = 'if' + ll.toString()
//alert(ln)
if(document.getElementById(ln).style.display=='block')
{    document.getElementById(ln).style.display='none'
    return true;
}
else
{    document.getElementById(ln).style.display='block'  }

aHil = new Array()
aKil = new Array()
aQty = new Array()

cn1 = 0
cn2 = 0
ofi = trim(t.rows(LIN).cells(1).innerHTML) 
po  = trim(t.rows(LIN).cells(2).innerHTML) 

Kad  = '&ori='+ ori + '&po=' + po + '&ofi='+ ofi  + '&lin='+ parseInt((LIN-2)/2 ,10)
Kad += '&lt1='+ lt1 + '&ser=' + ser + '&kod=' + kod + '&des='+ des


if (trim(lt1) == 'h')
{  // ya tengo la materia prima que se necesita para la tela (codigo y kilos)
    for (p=3; p < (cols-3); p+=2)
    {   str = trim(t.rows(LIN).cells(p+1).innerHTML) 
        kil = str.replace(/,/g, "");
        if(parseFloat(kil)> 0)
        {   aHil[cn1] = t.rows(LIN).cells(p).innerHTML 
            aKil[cn1++] = kil
        }
    }
//    alert(aHil)
    //alert(aKil)
cad  = 'bake/reSERVIhilo.asp?ahil='+ aHil + '&aCan=' + aKil  
}

// revisa el stock y reserva si hay stock para hacer la reserva
//alert(cad + Kad)
document.getElementById(ln).src = cad + Kad

}


function mira(conta,LIN)
{  dd =  'OC'+ conta
chk = document.getElementById(dd).checked 

var t = document.all.detaS;
LIN = parseInt(LIN,10)+2

cad  = 'bake/bakeRSVhiloSRV.asp?ccc='+ (LIN-2)/2

cod = trim(t.rows(LIN).cells(3).innerHTML)  // es el primer codigo de origen
ofi = trim(t.rows(LIN).cells(1).innerHTML) 
po  = trim(t.rows(LIN).cells(2).innerHTML) 

cols = parseInt(t.rows(LIN).cells.length,10)-5
//alert(cols)
KOD = trim(t.rows(LIN).cells(cols).innerHTML) 
ori = '<%=ori%>'
lt1 = '<%=lt1%>'
lt2 = '<%=lt2%>'
ser = '<%=ser%>'
des = '<%=des%>'
dele = 1
if (chk!= true)
{   dele=0 }
if (KOD.length == 6) KOD += '0000000000'
Kad  = '&ori='+ ori + '&po=' + po + '&ofi='+ ofi  + '&lin='+ parseInt((LIN-2)/2,10) + '&dele='+ dele
Kad += '&lt1='+ lt1 + '&ser=' + ser + '&des='+ des+ '&lt2=' + lt2 +'&cod=' + cod + '&KOD=' + KOD  

aHil = new Array()
aKil = new Array()
aQty = new Array()
cn1 = 0
cn2 = 0
if (trim(lt1) == 'h')
{  // ya tengo la materia prima que se necesita para la tela (codigo y kilos)
    for (p=3; p < (cols-3); p+=2)
    {   str = trim(t.rows(LIN).cells(p+1).innerHTML) 
        kil = str.replace(/,/g, "");
        if(parseFloat(kil)> 0)
        {   aHil[cn1] = t.rows(LIN).cells(p).innerHTML 
            aKil[cn1++] = kil
        }
    }
  //  alert("mira")
    //alert(aKil)

ll= parseInt(LIN,10) - 2
// el if viene de iframe
ln = 'if' + ll.toString()
//document.getElementById(ln).src = cad+Kad
//document.getElementById(ln).style.display='block'
}

cad  = 'COMUN/INSERrsvHILO.asp?ahil='+ aHil + '&aKil=' + aKil  
cad += Kad
//document.getElementById('head').style.display='block'
document.getElementById('head').src = cad 
document.getElementById(ln).onclick
document.getElementById(ln).style.display='none'
}


function ordCOM() {
var fin = 0    

maxi = parseInt('<%=conta%>',10)
var aCod = new Array()
var aCan = new Array()
var aQty = new Array()
var aOfi = new Array()
var aPos = new Array()
var aHi1 = new Array()
var aKi1 = new Array()
var aHi2 = new Array()
var aKi2 = new Array()
var aHi3 = new Array()
var aKi3 = new Array()
var aHi4 = new Array()
var aKi4 = new Array()
var aHi5 = new Array()
var aKi5 = new Array()
var aHi6 = new Array()
var aKi6 = new Array()
var t = document.all.detaS;
ori = '<%=ori%>'
lt1 = '<%=lt1%>'
lt2 = '<%=lt2%>'
ser = '<%=ser%>'
des = '<%=des%>'
LIN = parseInt(t.rows.length,10)
CELS = parseInt(t.rows(2).cells.length,10)

datos = ofi
//alert(CELS)
mm = 0
    for (f = 2; f < (LIN-1); f+=2) {
        cc = "OC" + mm.toString()
        ell = document.getElementById(cc);       
        if (ell.checked == true && ell.style.display=='block') 
        {  // SIEMPRE voy a tener por lo menos UNA materia prima de origen
            aCod[fin]  =trim(t.rows(f).cells(CELS-5).innerHTML) 
            dd = trim(t.rows(f).cells(CELS-4).innerHTML) 
            dato = dd.replace(',','')
            aCan[fin] = dato
            dd = trim(t.rows(f).cells(CELS-3).innerHTML) 
            dato = dd.replace(',','')
            aQty[fin] = dato
            aOfi[fin] = trim(t.rows(f).cells(1).innerHTML) 
            aPos[fin] = trim(t.rows(f).cells(2).innerHTML) 
                    
            aHi1[fin] = trim(t.rows(f).cells(3).innerHTML) 
            dd = trim(t.rows(f).cells(4).innerHTML) 
            dato = dd.replace(',','')
            aKi1[fin] = dato
            if (CELS-5 > 5)
            {   if ( trim(t.rows(f).cells(5).innerHTML) == '')
                {   aHi2[fin]= ''
                    aKi2[fin] = 0
                }
                else
                {   aHi2[fin] = trim(t.rows(f).cells(5).innerHTML) 
                    dd = trim(t.rows(f).cells(6).innerHTML) 
                    dato = dd.replace(',','')
                    aKi2[fin] = dato
                }
            }
            else 
            {   aHi2[fin]= ''
                aKi2[fin] = 0
                }
            if (CELS-5 > 7)
            {   if ( trim(t.rows(f).cells(7).innerHTML) == '')
                {   aHi3[fin]= ''
                    aKi3[fin] = 0
                }
                else
                {   aHi3[fin] = trim(t.rows(f).cells(7).innerHTML) 
                    dd = trim(t.rows(f).cells(8).innerHTML) 
                    dato = dd.replace(',','')
                    aKi3[fin] = dato
                }
            }
            else
            {  aHi3[fin]= ''
               aKi3[fin] = 0
                }
            if (CELS-5 > 9)
            {   if ( trim(t.rows(f).cells(9).innerHTML) == '')
                {   aHi4[fin]= ''
                    aKi4[fin] = 0
                }
                else
                {   aHi4[fin] = trim(t.rows(f).cells(9).innerHTML) 
                    dd = trim(t.rows(f).cells(10).innerHTML) 
                    dato = dd.replace(',','')
                    aKi4[fin] = dato
                }
            }
            else
            { aHi4[fin]= ''
              aKi4[fin] = 0
                }
            if (CELS-5 > 11)
            {   if ( trim(t.rows(f).cells(11).innerHTML) == '')
                {   aHi5[fin]= ''
                    aKi5[fin] = 0
                }
                else
                {   aHi5[fin] = trim(t.rows(f).cells(11).innerHTML) 
                    dd = trim(t.rows(f).cells(12).innerHTML) 
                    dato = dd.replace(',','')
                    aKi5[fin] = dato
                }
            }
            else
            { aHi5[fin]= ''
              aKi5[fin] = 0
            }


            if (CELS-5 > 13)
            {   if ( trim(t.rows(f).cells(13).innerHTML) == '')
                {   aHi6[fin]= ''
                    aKi6[fin] = 0
                }
                else
                {   aHi6[fin] = trim(t.rows(f).cells(15).innerHTML) 
                    dd = trim(t.rows(f).cells(16).innerHTML) 
                    dato = dd.replace(',','')
                    aKi6[fin] = dato
                }
            }
            else
            {  aHi6[fin]= ''
               aKi6[fin] = 0
                }


            fin++
        }
        mm++       
    }
   // alert()

    if (fin == 0)
    { alert("Nada que emitir") }
    else {
        // ORDEN DE COMPRAAAA
        cad = 'fichaocNEW.asp?des=' + '<%=des%>'
        cad += '&cod=' + aCod
        cad += '&can=' + aCan
        cad += '&ofi=' + aOfi
        cad += '&Pos=' + aPos
        cad += '&qty=' + aQty
        cad += '&hi1=' + aHi1
        cad += '&hi2=' + aHi2
        cad += '&hi3=' + aHi3
        cad += '&hi4=' + aHi4
        cad += '&hi5=' + aHi5
        cad += '&hi6=' + aHi6
        cad += '&ki1=' + aKi1
        cad += '&ki2=' + aKi2
        cad += '&ki3=' + aKi3
        cad += '&ki4=' + aKi4
        cad += '&ki5=' + aKi5
        cad += '&ki6=' + aKi6
        cad += '&lt2=' + '<%=lt2%>'
        cad += '&al2=' + '<%=des%>'
        cad += '&lt1=' + '<%=lt1%>'
        cad += '&al1=' + '<%=ori%>'
        cad += '&ser=' + '<%=ser%>'
        cad += '&cla=' + 'S'
       alert(cad)       
   window.open(cad,'OC_Auto',opc) 
    
  }
}



</script>
</body>
</html>
