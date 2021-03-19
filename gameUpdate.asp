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
	
if isnumeric(Temizleyici(request.QueryString("gameID")))=false then
response.redirect "start.asp"
response.End
end if

if request.QueryString("gameID")<>"" and isnumeric(request.QueryString("gameID")) then
gameID = request.QueryString("gameID")
else
%>
        <script language="javascript" type="text/javascript">
        alert("Hatalı giriş. Lütfen bilgilerin doğruluğundan emin olun.");
		location.href="start.asp";
        </script>
<%
end if

set games = server.createobject("adodb.recordset")
sql="Select * From de_Game WHERE gameID=" & gameID
games.open sql,conn,1,3

if games.eof then
response.redirect "start.asp"
response.End()
end if

if request.ServerVariables("REQUEST_METHOD")="POST" then

Set Upload = Server.CreateObject("Persits.Upload")
Count = upload.save
dim uploadsDirVar
uploadsDirVar = server.MapPath("Game_swf_img") & "/"

	if Upload.Form("gameName")<>"" and Upload.Form("puan")<>"" then
	
		iname=""
		iname1=""
		if count <>  0 then
			
						Randomize
						Rast1 = int(RND*10)+0
						Rast2 = int(RND*100)+0
						Rast3 = int(RND*1000)+0
						Rast4 = int(RND*10000)+0
						Rast5 = int(RND*100000)+0
						Rast6 = int(RND*1000000)+0
						RAST = Rast1 & "_" & Rast2 & "_" & Rast3 & "_" & Rast4 & "_" & Rast5 & "_" & Rast6
			if Not Upload.Files("upload") Is Nothing then			
				set f = upload.files("upload")
					IF f.ext<>".jpg" and f.ext<>".png" and f.ext<>".gif" and f.ext<>".jpeg" and f.ext<>".JPG" then
					%>
						<script language="javascript" type="text/javascript">
						alert("Istenmeyen dosya turu hatasi.\nDosya yukleme basarisiz.");
						location.href="gameUpdate.asp?gameID=<%=gameID%>";
						</script>
					<%
					ELSE
						f.saveas uploadsDirVar & "DegerlerEgitimi_" & RAST & f.ext
						iname = "DegerlerEgitimi_" & RAST & f.ext
					END IF
			end if
		
			if Not Upload.Files("upload1") Is Nothing then		
				set f1 = upload.files("upload1")
					IF f1.ext<>".swf" then
					%>
						<script language="javascript" type="text/javascript">
						alert("Istenmeyen dosya turu hatasi.\nDosya yukleme basarisiz.");
						location.href="gameUpdate.asp?gameID=<%=gameID%>";
						</script>
					<%
					response.End()
					ELSE
						set f = server.CreateObject("Scripting.FileSystemObject")
						f.deletefile Server.MapPath("Game_swf_img/"&games("gameFile"))
						
						f1.saveas uploadsDirVar & "DegerlerEgitimi_" & RAST & f1.ext
						iname1 = "DegerlerEgitimi_" & RAST & f1.ext
					END IF
			end if
			
			
		end if
		
		
		
		games("gameName")=Upload.Form("gameName")
		games("puan")=Upload.Form("puan")
		if iname<>"" then
		games("gamePhoto")=iname
		end if
		if iname1<>"" then
		games("gameFile")=iname1
		end if
		games.Update
		%>
        <script type="text/javascript">
		alert("Basariyla guncellendi.");
		location.href="games.asp";
		</script>
        <%
	else
	%>
    <script type="text/javascript">
	alert("Lutfen oyun adi ve puan alanlarini doldurun.");
	location.href="gameUpdate.asp?gameID=<%=gameID%>";
    </script>
    <%
	end if	
end if
%>
<%
if request("Delete") <> "" then
	if games("gamePhoto") <> "" then
		set f = server.CreateObject("Scripting.FileSystemObject")
		f.deletefile Server.MapPath("Game_swf_img/"&games("gamePhoto"))
		games("gamePhoto") = ""
		games.update
	end if
response.Redirect "?gameID="&request.QueryString("gameID")
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Oyunlar</title>
<link href="Assets/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
function onlyNum(obj){
		var kelime = obj.value;
			obj.value = kelime.replace(/[(<>"'*\-+!\\"^\/_$çÇğĞıİöÖ şŞü.Ü{}\[\]¼#²¹¬<>|~%&'()=?,&A-z]/g,'') //Sayı kontrol
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
                      <td width="349" align="left" valign="middle">Oyun Düzenle</td>
                      <td width="349" align="right" valign="middle"><a href="games.asp" class="backlink">Oyunlar</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST" enctype="multipart/form-data">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Oyun Adı:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="gameName" class="formtext" value="<%=games("gameName")%>" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Puan:</span></td>
                          <td height="30" align="left" valign="middle"><input type="text" name="puan" class="formtext" value="<%=games("Puan")%>" onKeyUp="onlyNum(this);" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Oyun Resmi:</span></td>
                          <td width="493" height="30" align="left" valign="middle">
                          <%if games("gamePhoto")<>"" then%>
                          <br />
                          &nbsp;<img src="Game_swf_img/<%=games("gamePhoto")%>" width="110" height="110" border="0" />
                          &nbsp;<a href="?gameID=<%=gameID%>&Delete=ok" class="deletelink">Sil</a>
                          <br /><br />
                          <%else%>
                          
                          &nbsp;<input type="file" name="upload" />&nbsp;
                          <span class="backlink">.jpg</span>&nbsp;
                          <span class="backlink">.png</span>&nbsp;
                          <span class="backlink">.gif</span>&nbsp;
                          <span class="backlink">.jpeg</span>
                          <%end if%>
                          </td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Oyun Dosyası:</span></td>
                          <td height="30" align="left" valign="middle">&nbsp;<input type="file" name="upload1" />&nbsp;
                          <span class="backlink">.swf</span></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="250" align="right" valign="middle"><span style="font-size:14px;">Oyun Önizleme:</span></td>
                          <td width="493" height="250" align="left" valign="middle">
                          	<object width="225" height="225" style="margin:5px;">
                                <param name="movie" value="Game_swf_img/<%=games("gameFile")%>">
                                <embed src="Game_swf_img/<%=games("gameFile")%>" width="225" height="225">
                                </embed>
                            </object>
                          </td>
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
