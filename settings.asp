<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>0 then response.Redirect("default.asp")%>
<%
set sett = server.createobject("adodb.recordset")
sql="Select * From de_Settings WHERE settID=1"
sett.open sql,conn,1,3

if request.ServerVariables("REQUEST_METHOD")="POST" then
		
		sett("Bilgi")=request.Form("Bilgi")
		sett("NedirTT")=request.Form("NedirTT")
		sett("Nedir")=request.Form("Nedir")
		sett.Update
		%>
        <script type="text/javascript">
		alert("Başarıyla güncellendi.");
		location.href="settings.asp";
		</script>
<%end if%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Genel Ayarlar</title>
<link href="Assets/css/main.css" rel="stylesheet" type="text/css" />
<script src="Assets/ckeditor/ckeditor.js"></script>
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
                      <td width="349" align="left" valign="middle">Genel Ayarlar</td>
                      <td width="349" align="right" valign="middle"></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                      <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Metin Başlığı:</span></td>
                          <td width="493" height="30" align="left" valign="middle">
                          <input type="text" name="NedirTT" class="formtext" value="<%=sett("NedirTT")%>" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td width="200" height="30" align="right" valign="top"><span style="font-size:14px;">Metin:</span><br />(Metini gizlemek için kutucuğu boş bırakın)</td>
                          <td width="493" height="30" align="left" valign="middle">
                          <textarea name="Nedir" class="formarea"><%=sett("Nedir")%></textarea></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="top"><span style="font-size:14px;">Bilgi Ekranı:</span><br />(Bilgi Ekranını kapatmak için kutucuğu boş bırakın)</td>
                          <td width="493" height="30" align="left" valign="middle">
                          <textarea name="bilgi" class="formarea"><%=sett("Bilgi")%></textarea></td>
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
<script>
		CKEDITOR.replace( 'bilgi', {
			// Define the toolbar groups as it is a more accessible solution.
			toolbarGroups: [
			{"name":"styles","groups":["styles"]},
				{"name":"basicstyles","groups":["basicstyles"]},
				{"name":"links","groups":["links"]},
				{"name":"paragraph","groups":["list","blocks"]},
				
				
				
			],
			// Remove the redundant buttons from toolbar groups defined above.
			removeButtons: 'Subscript,Superscript,Anchor,Styles,Specialchar'
		} );
		CKEDITOR.replace( 'Nedir', {
			// Define the toolbar groups as it is a more accessible solution.
			toolbarGroups: [
			{"name":"styles","groups":["styles"]},
				{"name":"basicstyles","groups":["basicstyles"]},
				{"name":"links","groups":["links"]},
				{"name":"paragraph","groups":["list","blocks"]},
				
				
				
			],
			// Remove the redundant buttons from toolbar groups defined above.
			removeButtons: 'Subscript,Superscript,Anchor,Styles,Specialchar'
		} );
</script>
</body>
</html>
