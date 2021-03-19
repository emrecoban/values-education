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

sql="Select * From de_Book WHERE teachersID="&user("userID")&" and bookID="&bookID&""
Set books = conn.Execute(sql)

if books.eof then
response.redirect "start.asp"
response.End()
end if

if request.ServerVariables("REQUEST_METHOD")="POST" then
	if request.Form("BookName")<>"" then
		set YeniKtp = server.createobject("adodb.recordset")
		sql="Select * From de_Book WHERE bookID=" & bookID
		YeniKtp.open sql,conn,1,3
		
		YeniKtp("BookName")=request.Form("BookName")
		YeniKtp.Update
		%>
        <script type="text/javascript">
		alert("Başarıyla güncellendi.");
		location.href="books.asp";
		</script>
        <%
	else
	%>
    <script type="text/javascript">
	alert("Lütfen tüm alanları doldurun.");
	location.href="bookUpdate.asp?bookID=<%=bookID%>";
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
                      <td width="349" align="left" valign="middle">Kitap Düzenle</td>
                      <td width="349" align="right" valign="middle"><a href="books.asp" class="backlink">Kitaplar</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Ad:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="BookName" class="formtext" value="<%=books("BookName")%>" /></td>
                        </tr>
                        <tr>
                          <td height="30" align="right" valign="middle">&nbsp;</td>
                          <td height="30" align="left" valign="middle"><input type="submit" value="Güncelle" class="formadd" /></td>
                        </tr>
                      </table>
                      </form>
                </div>
            </div>

            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
