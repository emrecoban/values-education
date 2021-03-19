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
	
if isnumeric(Temizleyici(request.QueryString("userID")))=false then
response.redirect "start.asp"
response.End
end if

if request.QueryString("userID")<>"" and isnumeric(request.QueryString("userID")) then
userID = request.QueryString("userID")
else
%>
        <script language="javascript" type="text/javascript">
        alert("Hatalı giriş. Lütfen bilgilerin doğruluğundan emin olun.");
		location.href="start.asp";
        </script>
<%
end if

sql="Select * From de_User WHERE Yetki=2 and userID="&userID&""
Set students = conn.Execute(sql)

if students.eof then
response.redirect "start.asp"
response.End()
end if

if request.ServerVariables("REQUEST_METHOD")="POST" then
	if request.Form("ad")<>"" and request.Form("soyad")<>"" and request.Form("password")<>"" and request.Form("mail")<>"" and request.Form("yas")<>"" then
		set YeniOgr = server.createobject("adodb.recordset")
		sql="Select * From de_User WHERE userID=" & userID
		YeniOgr.open sql,conn,1,3
		
		YeniOgr("ad")=request.Form("ad")
		YeniOgr("soyad")=request.Form("soyad")
		YeniOgr("password")=request.Form("password")
		YeniOgr("mail")=request.Form("mail")
		YeniOgr("yas")=request.Form("yas")
		YeniOgr.Update
		%>
        <script type="text/javascript">
		alert("Başarıyla güncellendi.");
		location.href="students.asp";
		</script>
        <%
	else
	%>
    <script type="text/javascript">
	alert("Lütfen tüm alanları doldurun.");
	location.href="studentUpdate.asp?userID=<%=userID%>";
    </script>
    <%
	end if	
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Öğrenciler</title>
<link href="Assets/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
function onlyNum(obj){
		var kelime = obj.value;
			obj.value = kelime.replace(/[(<>"'*\-+!\\"^\/_$çÇğĞıİöÖ şŞü.Ü{}\[\]¼#²¹¬<>|~%&'()=?,&A-z]/g,'') //Sayı kontrol
}
function onlyEN(obj){
		var kelime = obj.value;
			obj.value = kelime.replace(/[(<>"'*\-+!\\"^\/$çÇğĞıİöÖ şŞü.Ü{}\[\]¼#²¹¬<>|~%&'()=?]/g,'') //Rumuz kontrol
}
</script>
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
                      <td width="349" align="left" valign="middle">Öğrenci Düzenle</td>
                      <td width="349" align="right" valign="middle"><a href="students.asp" class="backlink">Öğrenciler</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Ad:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="ad" class="formtext" value="<%=students("ad")%>" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Soyad:</span></td>
                          <td height="30" align="left" valign="middle"><input type="text" name="soyad" class="formtext" value="<%=students("soyad")%>" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Kullanıcı Adı:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="username" class="formtext" onKeyUp="onlyEN(this);" value="<%=students("username")%>" disabled="disabled" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Parola:</span></td>
                          <td height="30" align="left" valign="middle"><input type="password" name="password" class="formtext" value="<%=students("password")%>" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">E-Posta:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="mail" class="formtext" value="<%=students("mail")%>" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Yaş:</span></td>
                          <td height="30" align="left" valign="middle"><input type="text" name="yas" class="formtext" onKeyUp="onlyNum(this);" value="<%=students("yas")%>" /></td>
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
