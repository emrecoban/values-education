<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>1 then response.Redirect("default.asp")%>
<%
if request.ServerVariables("REQUEST_METHOD")="POST" then
	if request.Form("BookName")<>"" then
			set YeniKtp = server.createobject("adodb.recordset")
			sql="Select * From de_Book"
			YeniKtp.open sql,conn,1,3
			
			YeniKtp.AddNew
			YeniKtp("teachersID")=user("userID")
			YeniKtp("BookName")=request.Form("BookName")
			YeniKtp("BookDate")=date()
			YeniKtp.Update
			%>
			<script type="text/javascript">
			alert("Başarıyla eklendi.");
			location.href="books.asp";
			</script>
			<%
	else
	%>
    <script type="text/javascript">
	alert("Lütfen tüm alanları doldurun.");
	location.href="bookAdd.asp";
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
                      <td width="349" align="left" valign="middle">Yeni Kitap</td>
                      <td width="349" align="right" valign="middle"><a href="books.asp" class="backlink">Kitaplar</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Kitap Adı:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="BookName" class="formtext" /></td>
                        </tr>
                        <tr>
                          <td height="30" align="right" valign="middle">&nbsp;</td>
                          <td height="30" align="left" valign="middle"><input type="submit" value="Ekle" class="formadd" /></td>
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
