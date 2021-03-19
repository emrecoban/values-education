<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<%
if Session("GirisDeger") = "1" Then
		response.Redirect("start.asp")
end if

If request.ServerVariables("REQUEST_METHOD")="POST" Then
username = clean(Trim(request.Form("username")))
password = clean(Trim(request.Form("password")))

	Set rsKontrol = Server.CreateObject("Adodb.Recordset")
	SQL= "SELECT * from de_User where username='" & UserName & "' and password='" & Password & "' and Yetki<>2"
	rsKontrol.open SQL,conn,1,3
	
	Set rsLOG = Server.CreateObject("Adodb.Recordset")
	SQL= "SELECT * from de_Log"
	rsLOG.open SQL,conn,1,3
	
	if rsKontrol.eof then
		rsLOG.addnew
		rsLOG("IP")=request.form("IP")
		rsLOG("Date")=request.form("Date")
		rsLOG("Browser")=request.form("Browser")
		rsLOG("username")=username
		rsLOG("Durum")="Başarısız"
		rsLOG.Update
		%>
			<script language="javascript" type="text/javascript">
				alert("Kullanıcı adınız veya parolanız yanlış. \nLütfen kontrol ederek yeniden deneyiniz.");
				location.href="AdmTea.asp";
            </script>
		<%
	ELSE
		rsLOG.addnew
		rsLOG("IP")=request.form("IP")
		rsLOG("Date")=request.form("Date")
		rsLOG("Browser")=request.form("Browser")
		rsLOG("username")=username
		rsLOG("Durum")="Başarılı"
		rsLOG.Update
		
		Session("GirisDeger") = "1"
		Session("userID") = rsKontrol("userID")
		Session("Yetki") = rsKontrol("Yetki")
		response.redirect("start.asp")
	End If
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi</title>
<link href="Assets/css/login.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
function LoginFormControl(){
	if (document.LoginForm.username.value == ""){
		alert ("Lütfen tüm alanları doldurunuz.");
		document.LoginForm.username.focus();
		return false;  
	}
	if (document.LoginForm.password.value == ""){
		alert ("Lütfen tüm alanları doldurunuz.");
		document.LoginForm.password.focus();
		return false;  
	}
}
</script>
</head>

<body>
<div id="loginpanel">
	<div id="panel_head">
    	<div id="panel_logo">
        	<img src="Assets/img/logo.png" width="88" height="90" border="0" style="margin-top:3px;" />
        </div>
        <div id="panel_title">
        	DEĞERLER EĞİTİMİ
        </div>
    </div>
    <div id="panel_content">
    <br />
    	<strong>Tarayıcı Bilgileri:</strong> <%=request.servervariables("HTTP_USER_AGENT")%><br />
        <strong>I.P. Adresi:</strong> <%=request.servervariables("REMOTE_ADDR")%><br />
        <strong>Giriş Zamanı:</strong> <%=Now()%><br /><br />
        
        <div id="panel_form">
        	<form action="" method="POST" name="LoginForm" onSubmit="return LoginFormControl();">
            <input type="hidden" name="IP" value="<%=request.servervariables("REMOTE_ADDR")%>" />
            <input type="hidden" name="Date" value="<%=Now()%>" />
            <input type="hidden" name="Browser" value="<%=request.servervariables("HTTP_USER_AGENT")%>" />
            <input type="text" name="username" placeholder="Kullanıcı Adı" autocomplete="off" class="logininput" />
            <input type="password" name="password" placeholder="Parola" autocomplete="off" class="logininput" />
            <input type="submit" value="GİRİŞ" class="loginbuton" />
            </form>
        </div>
    </div>
  <div id="panel_shadow"></div>
  <div id="panel_foot">Değerler Eğitimi © 2015</div>
</div>
</body>
</html>
