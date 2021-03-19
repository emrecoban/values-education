<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>2 then response.Redirect("default.asp")%>
<%
set sett = server.createobject("adodb.recordset")
sql="Select * From de_User WHERE teachersID="&user("teachersID")&" and userID="&user("userID")&""
sett.open sql,conn,1,3


if request.ServerVariables("REQUEST_METHOD")="POST" then
	if request.Form("ad")<>"" and request.Form("soyad")<>"" and request.Form("password")<>"" and request.Form("mail")<>"" and request.Form("yas")<>"" then
		
		sett("ad")=request.Form("ad")
		sett("soyad")=request.Form("soyad")
		sett("password")=request.Form("password")
		sett("mail")=request.Form("mail")
		sett("yas")=request.Form("yas")
		sett.Update
		%>
        <script type="text/javascript">
		alert("Başarıyla güncellendi.");
		location.href="cSett.asp";
		</script>
        <%
	else
	%>
    <script type="text/javascript">
	alert("Lütfen tüm alanları doldurun.");
	location.href="cSett.asp";
    </script>
    <%
	end if	
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Ayarlar</title>
<link href="Assets/css/cloud.css" rel="stylesheet" type="text/css" />
<link href="Assets/css/child_main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
function onlyNum(obj){
		var kelime = obj.value;
			obj.value = kelime.replace(/[(<>"'*\-+!\\"^\/_$çÇğĞıİöÖ şŞü.Ü{}\[\]¼#²¹¬<>|~%&'()=?,&A-z]/g,'') //Sayı kontrol
}
</script>
</head>

<body>
<div id="background-wrap">
    <div class="x1">
        <div class="cloud"></div>
    </div>

    <div class="x2">
        <div class="cloud"></div>
    </div>

    <div class="x3">
        <div class="cloud"></div>
    </div>

    <div class="x4">
        <div class="cloud"></div>
    </div>

    <div class="x5">
        <div class="cloud"></div>
    </div>
</div>
<div id="cMain">
	<!-- #include file="Assets/inc/header.asp" -->
    <div id="content">
    	<div id="contcenter">
        	<div id="title">
            	<div id="titleico"><img src="Assets/img/child_icon_3.png" width="40" height="40" border="0" /></div>
                <div id="titletxt">AYARLAR</div>
            </div>
            <div id="maincont">
            	<div style="width:696px;margin-left:auto;margin-right:auto;">
            	<form action="" method="POST">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                      <tr bgcolor="#17AEFF">
                          <td height="30" colspan="2" align="left" valign="middle"><span style="font-size:14px;color:#FFF;font-weight:bold;">&nbsp;&nbsp;Kişisel Bilgilerim</span></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Adım:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="ad" class="formtext" value="<%=sett("Ad")%>" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Soyadım:</span></td>
                          <td height="30" align="left" valign="middle"><input type="text" name="soyad" class="formtext" value="<%=sett("Soyad")%>" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Yaşım:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="yas" class="formtext" value="<%=sett("yas")%>" onKeyUp="onlyNum(this);" /></td>
                        </tr>
                        <tr bgcolor="#17AEFF">
                          <td height="30" colspan="2" align="left" valign="middle"><span style="font-size:14px;color:#FFF;font-weight:bold;">&nbsp;&nbsp;Profil Bilgilerim</span></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Parolam:</span></td>
                          <td height="30" align="left" valign="middle"><input type="password" name="password" class="formtext" value="<%=sett("password")%>" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">E-Posta Adresim:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="mail" class="formtext" value="<%=sett("mail")%>" /></td>
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
</div>
<!-- #include file="Assets/inc/child_footer.asp" -->
</body>
</html>
