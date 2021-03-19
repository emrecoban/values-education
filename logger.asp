<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")=2 then response.Redirect("default.asp")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - <%
					  if user("Yetki")=0 then
					  	response.write "Hesap Geçmişleri"
					  else
					  	response.write "Hesap Geçmişim"
					  end if
					  %></title>
<link href="Assets/css/main.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="main">
	<!-- #include file="Assets/inc/sidebar.asp" -->
    <div id="panel">
    	<!-- #include file="Assets/inc/userbar.asp" -->
        <div id="maincontent">
 
        <!-- //ContentBox1 -->
            <div class="contentpanel">
                <div class="contenttitle">
                  <table width="698" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="349" align="left" valign="middle">
                      <%
					  if user("Yetki")=0 then
					  	response.write "Hesap Geçmişleri"
					  else
					  	response.write "Hesap Geçmişim"
					  end if
					  %>
                      </td>
                      <td width="349" align="right" valign="middle"></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <table width="696" border="0" cellspacing="1" cellpadding="0" class="geneltablo">
                        <tr class="tabletitle">
                          <td width="246" height="30" align="center" valign="middle">Tarayıcı</td>
                          <td width="150" height="30" align="center" valign="middle">I.P. Adresi</td>
                          <td width="120" height="30" align="center" valign="middle">Giriş Zamanı</td>
                          <td width="111" height="30" align="center" valign="middle">Kullanıcı Adı</td>
                          <td width="63" height="30" align="center" valign="middle">Durum</td>
                        </tr>
                        <%
						if user("Yetki")=0 then
							set logs = server.createobject("adodb.recordset")
							sql="Select * From de_Log order by logID DESC"
							logs.open sql,conn,1,3
						else
							set logs = server.createobject("adodb.recordset")
							sql="Select TOP 20 * From de_Log WHERE username='"&user("username")&"' order by logID DESC"
							logs.open sql,conn,1,3
						end if
						
						function sayfalama(sayfa,sf,nm)
						
						if sayfa > 6 and sf > 6 then Response.Write "<a class=""syf_Link"" href=?"&nm&"=1 >|<</a><a class=""syf_Link"" href=?"&nm&"="&sf-1&"><<</a>" 
						for g = sf-9 to sf+9
						if g = cint(sf) then
						response.write "<span class=""syf_Suan"" >&nbsp;"&g&"&nbsp;</span> " 
							  
						elseif g < 1 or g > sayfa then response.Write "" 
						else
						response.Write "<a class=""syf_Link"" href=?"&nm&"=" & g & ">" & g & "</a> "
						
						end if
						next
						if not g > sayfa and sayfa > 6 then response.Write "<a class=""syf_Link"" href=?"&nm&"="&sf+1&" >&nbsp;>>&nbsp;</a><a class=""syf_Link"" href=?"&nm&"="&sayfa&" >&nbsp;>|&nbsp;</a>" end if
						end function
													  
						if isnumeric(Request.QueryString("syf")) then
							syf = Request.QueryString("syf")
						else
							syf = 1
						end if
						If syf="" Then syf="1"
						logs.pagesize = 30
						logs.absolutepage = syf 
						sayfa_sayisi = logs.pagecount
						
						bg=0
						
						for a=1 to logs.pagesize
						if logs.eof then exit for
						%>
                        <tr <%if bg mod 2=0 then%>bgcolor="#DFF4FF"<%else%>bgcolor="#CAEDFF"<%end if%> class="tablerow">
                          <td height="30" align="left" valign="middle" style="padding:5px;"><%=logs("Browser")%></td>
                          <td height="30" align="left" valign="middle">&nbsp;&nbsp;<%=logs("IP")%></td>
                          <td height="30" align="center" valign="middle"><%=logs("Date")%></td>
                          <td height="30" align="center" valign="middle"><%=logs("username")%></td>
                          <td height="30" align="center" valign="middle"><%
						  if logs("durum")="Başarılı" then
						  	response.write "<span style='color:green;'>" & logs("durum") & "</span>"
						  else
						  	response.write "<span style='color:red;'>" & logs("durum") & "</span>"
						  end if
						  %></td>
                        </tr>
                        <%
						bg=bg+1
						logs.movenext : next
						%>
                      </table>
                      <%if sayfa_sayisi>1 then%>
                      <table width="696" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                          <td height="10" align="center" valign="middle"></td>
                        </tr>
                        <tr>
                          <td width="696" align="center" valign="middle"><%call sayfalama(sayfa_sayisi,syf,"syf")%></td>
                        </tr>
                      </table>
                      <%end if%>
					  <%logs.close%>  
                </div>
            </div>

            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
