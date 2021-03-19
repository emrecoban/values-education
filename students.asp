<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>1 then response.Redirect("default.asp")%>
<%
set students = server.createobject("adodb.recordset")
sql="Select * From de_User WHERE Yetki=2 and teachersID="&user("userID")&" order by userID DESC"
students.open sql,conn,1,3
'--
puan=0
do while not students.eof
puan = puan + students("puan")
students.movenext : loop
'--

if request.QueryString("Delete")="ok" and request.querystring("userID")<>"" Then
set Sil = conn.execute("DELETE from de_User WHERE userID="& request.querystring("userID") &"")
set Guncel = conn.execute("UPDATE de_User SET kota_k=kota_k+1 WHERE userID="&user("userID")&"")
%>
    <script language="javascript" type="text/javascript">
    alert("Başarıyla silindi.");
	location.href="students.asp";
    </script>
<%end if%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Öğrenciler</title>
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
                      <td width="349" align="left" valign="middle">Öğrenciler</td>
                      <td width="349" align="right" valign="middle"><a href="studentAdd.asp" class="addlink">Yeni Öğrenci</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                
                	<table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Öğrenci</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=students.RecordCount%></span></td>
                      </tr>
                    </table>
                	<table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Puan</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=puan%></span></td>
                      </tr>
                    </table>
                    <table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Kota</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=user("kota")%> / <%=user("kota_k")%></span></td>
                      </tr>
                    </table>
                    <div class="cleartwo"></div>
                    <%if not students.eof or not students.bof then%>
                      <table width="696" border="0" cellspacing="1" cellpadding="0" class="geneltablo">
                        <tr class="tabletitle">
                          <td width="247" height="30" align="center" valign="middle">Ad Soyad</td>
                          <td width="224" height="30" align="center" valign="middle">Kullanıcı Adı</td>
                          <td width="100" height="30" align="center" valign="middle">Puan</td>
                          <td width="120" height="30" align="center" valign="middle">İşlemler</td>
                        </tr>
                        <%
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
						students.pagesize = 30
						students.absolutepage = syf 
						sayfa_sayisi = students.pagecount
						
						bg=0
						
						for a=1 to students.pagesize
						if students.eof then exit for
						%>
                        <tr <%if bg mod 2=0 then%>bgcolor="#DFF4FF"<%else%>bgcolor="#CAEDFF"<%end if%> class="tablerow">
                          <td height="30" align="left" valign="middle">&nbsp;&nbsp;<%=students("Ad")%>&nbsp;<%=students("Soyad")%></td>
                          <td height="30" align="left" valign="middle">&nbsp;&nbsp;<%=students("username")%></td>
                          <td height="30" align="center" valign="middle"><%=students("puan")%></td>
                          <td height="30" align="center" valign="middle"><a href="studentUpdate.asp?userID=<%=students("userID")%>" class="updatelink">Düzenle</a>&nbsp;<a href="?Delete=ok&userID=<%=students("userID")%>" class="deletelink">Sil</a></td>
                        </tr>
                        <%
						bg=bg+1
						students.movenext : next
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
                      <%end if%>
					  <%students.close%>  
                </div>
            </div>

            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
