<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>1 then response.Redirect("default.asp")%>
<%
	Function Temizleyici(TMZ)
		TMZ = replace(TMZ, ",", "'")
	Temizleyici = TMZ
	End Function
	
if isnumeric(Temizleyici(request.QueryString("bookID")))=false then
response.redirect "start.asp"
response.End
end if

if request.QueryString("bookID")<>"" and isnumeric(request.QueryString("bookID")) then
bookID = request.QueryString("bookID")
else
%>
        <script language="javascript" type="text/javascript">
        alert("Hatalı giriş. Lütfen bilgilerin doğruluğundan emin olun.");
		location.href="start.asp";
        </script>
<%
end if


set pages = server.createobject("adodb.recordset")
sql="Select * From de_Page WHERE teachersID="&user("userID")&" and bookID="&bookID&" order by pageID DESC"
pages.open sql,conn,1,3



sql="Select * From de_Book WHERE bookID="&bookID&""
Set bookInfo = conn.Execute(sql)

if request.QueryString("Delete")="ok" and request.querystring("bookID")<>"" Then
	set PageUpd = server.createobject("adodb.recordset")
	sql="Select * From de_Page WHERE PageID="&request.querystring("pageID")
	PageUpd.open sql,conn,1,3
	if PageUpd("Photo") <> "" then
		set f = server.CreateObject("Scripting.FileSystemObject")
		f.deletefile Server.MapPath("Page_img/"&PageUpd("Photo"))
	end if
	set Sil = conn.execute("DELETE from de_Page WHERE pageID="& request.querystring("pageID") &"")
	%>
    <script language="javascript" type="text/javascript">
    alert("Başarıyla silindi.");
	location.href="pages.asp?bookID=<%=request.QueryString("bookID")%>&syf=<%=request.QueryString("syf")%>";
    </script>
<%end if%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Sayfalar</title>
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
                      <td width="349" align="left" valign="middle">Sayfalar > <%=bookInfo("BookName")%></td>
                      <td width="349" align="right" valign="middle"><a href="books.asp" class="backlink">Kitaplar</a>&nbsp;<a href="pageAdd.asp?bookID=<%=bookID%>" class="addlink">Yeni Sayfa</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                

                	<table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Sayfa</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=pages.RecordCount%></span></td>
                      </tr>
                    </table>

                    <div class="cleartwo"></div>
                    <%if not pages.eof or not pages.bof then%>
                      <table width="696" border="0" cellspacing="1" cellpadding="0" class="geneltablo">
                        <tr class="tabletitle">
                          <td width="120" height="30" align="center" valign="middle">Resim</td>
                          <td width="451" height="30" align="center" valign="middle">Özet</td>
                          <td width="121" height="30" align="center" valign="middle">İşlemler</td>
                        </tr>
                        <%
						function sayfalama(sayfa,sf,nm)
						
						if sayfa > 6 and sf > 6 then Response.Write "<a class=""syf_Link"" href=?"&nm&"=1&bookID="&bookID&" >|<</a><a class=""syf_Link"" href=?"&nm&"="&sf-1&"&bookID="&bookID&"><<</a>" 
						for g = sf-9 to sf+9
						if g = cint(sf) then
						response.write "<span class=""syf_Suan"" >&nbsp;"&g&"&nbsp;</span> " 
							  
						elseif g < 1 or g > sayfa then response.Write "" 
						else
						response.Write "<a class=""syf_Link"" href=?"&nm&"=" & g & "&bookID="&bookID&">" & g & "</a> "
						
						end if
						next
						if not g > sayfa and sayfa > 6 then response.Write "<a class=""syf_Link"" href=?"&nm&"="&sf+1&"&bookID="&bookID&" >&nbsp;>>&nbsp;</a><a class=""syf_Link"" href=?"&nm&"="&sayfa&"&bookID="&bookID&" >&nbsp;>|&nbsp;</a>" end if
						end function
													  
						if isnumeric(Request.QueryString("syf")) then
							syf = Request.QueryString("syf")
						else
							syf = 1
						end if
						If syf="" Then syf="1"
						pages.pagesize = 30
						pages.absolutepage = syf 
						sayfa_sayisi = pages.pagecount
						
						bg=0
						
						for a=1 to pages.pagesize
						if pages.eof then exit for
						%>
                        <tr <%if bg mod 2=0 then%>bgcolor="#DFF4FF"<%else%>bgcolor="#CAEDFF"<%end if%> class="tablerow">
                          <td height="120" align="center" valign="middle">
                          <%if pages("Photo")<>"" then%>
                          	<img src="Page_img/<%=pages("Photo")%>" width="110" height="110" border="0" />
                          <%else%>
                          	<img src="Assets/img/no-image.png" width="110" height="110" border="0" />
                          <%end if%>
                          </td>
                          <td height="30" align="left" valign="middle" style="padding:5px;"><%=left(pages("Page"),450)%></td>
                          <td height="30" align="center" valign="middle"><a href="pageUpdate.asp?pageID=<%=pages("pageID")%>&bookID=<%=bookID%>" class="updatelink">Düzenle</a>&nbsp;<a href="?Delete=ok&pageID=<%=pages("pageID")%>&bookID=<%=bookID%>&syf=<%=request.QueryString("syf")%>" class="deletelink">Sil</a></td>
                        </tr>
                        <%
						bg=bg+1
						pages.movenext : next
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
					  <%pages.close%>  
                </div>
            </div>

            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
