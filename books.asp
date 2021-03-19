<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>1 then response.Redirect("default.asp")%>
<%
set books = server.createobject("adodb.recordset")
sql="Select * From de_Book WHERE teachersID="&user("userID")&" order by bookID DESC"
books.open sql,conn,1,3
set pagesTT = server.createobject("adodb.recordset")
sql="Select * From de_Page WHERE teachersID="&user("userID")
pagesTT.open sql,conn,1,3


if request.QueryString("Delete")="ok" and request.querystring("bookID")<>"" Then
	sql="Select * From de_Ask WHERE bookID="&request.querystring("bookID")&""
	Set kontrol0 = conn.Execute(sql)
	
	sql="Select * From de_Page WHERE bookID="&request.querystring("bookID")&""
	Set kontrol = conn.Execute(sql)
		
	if not kontrol.eof then
%>
	<script language="javascript" type="text/javascript">
    alert("Kitabı silebilmeniz için lütfen önce sayfalarını silin.");
	location.href="pages.asp?bookID=<%=request.querystring("bookID")%>";
    </script>
	<%
	elseif not kontrol0.eof then
	%>
    <script language="javascript" type="text/javascript">
    alert("Kitabı silebilmeniz için lütfen önce kitaba ait soruları silin.");
	location.href="ask.asp";
    </script>
    <%
	else
	set Sil = conn.execute("DELETE from de_Book WHERE bookID="& request.querystring("bookID") &"")
	%>
    <script language="javascript" type="text/javascript">
    alert("Başarıyla silindi.");
	location.href="books.asp";
    </script>
<%
	end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Kitaplar</title>
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
                      <td width="349" align="left" valign="middle">Kitaplar</td>
                      <td width="349" align="right" valign="middle"><a href="bookAdd.asp" class="addlink">Yeni Kitap</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                

                	<table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Sayfa</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=pagesTT.RecordCount%></span></td>
                      </tr>
                    </table>
                    <table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Kitap</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=books.RecordCount%></span></td>
                      </tr>
                    </table>
                    <div class="cleartwo"></div>
                    <%if not books.eof or not books.bof then%>
                      <table width="696" border="0" cellspacing="1" cellpadding="0" class="geneltablo">
                        <tr class="tabletitle">
                          <td width="286" height="30" align="center" valign="middle">Kitap Adı</td>
                          <td width="75" height="30" align="center" valign="middle">Sayfa</td>
                          <td width="140" height="30" align="center" valign="middle">Oluşturulma Tarihi</td>
                          <td width="190" height="30" align="center" valign="middle">İşlemler</td>
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
						books.pagesize = 30
						books.absolutepage = syf 
						sayfa_sayisi = books.pagecount
						
						bg=0
						
						for a=1 to books.pagesize
						if books.eof then exit for
						
						set pages = server.createobject("adodb.recordset")
						sql="Select * From de_Page WHERE bookID=" & books("bookID")
						pages.open sql,conn,1,3
						%>
                        <tr <%if bg mod 2=0 then%>bgcolor="#DFF4FF"<%else%>bgcolor="#CAEDFF"<%end if%> class="tablerow">
                          <td height="30" align="left" valign="middle">&nbsp;&nbsp;<%=books("BookName")%></td>
                          <td height="30" align="center" valign="middle">&nbsp;&nbsp;<%=pages.RecordCount%></td>
                          <td height="30" align="center" valign="middle"><%=books("BookDate")%></td>
                          <td height="30" align="center" valign="middle"><a href="pages.asp?bookID=<%=books("bookID")%>" class="titlelink">Sayfalar</a>&nbsp;<a href="bookUpdate.asp?bookID=<%=books("bookID")%>" class="updatelink">Düzenle</a>&nbsp;<a href="?Delete=ok&bookID=<%=books("bookID")%>" class="deletelink">Sil</a></td>
                        </tr>
                        <%
						bg=bg+1
						books.movenext : next
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
					  <%books.close%>  
                </div>
            </div>

            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
