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
sql="Select * From de_Book WHERE bookID="&bookID&""
Set bookInfo = conn.Execute(sql)

if request.ServerVariables("REQUEST_METHOD")="POST" then

Set Upload = Server.CreateObject("Persits.Upload")
Count = upload.save
dim uploadsDirVar
uploadsDirVar = server.MapPath("Page_img") & "/"

	
	if Upload.Form("PageOne")<>"" then
	
			set YeniPg = server.createobject("adodb.recordset")
			sql="Select * From de_Page"
			YeniPg.open sql,conn,1,3
		iname=""	
		if count <>  0 then
			set f = upload.files("upload")
				IF f.ext<>".jpg" and f.ext<>".png" and f.ext<>".gif" and f.ext<>".jpeg" and f.ext<>".JPG" then
				%>
					<script language="javascript" type="text/javascript">
                    alert("İstenmeyen dosya türü hatası.\nDosya yükleme başarısız.");
                    location.href="pages.asp?BookID=<%=bookID%>";
                    </script>
                <%
				ELSE
				
					Randomize
					Rast1 = int(RND*10)+0
					Rast2 = int(RND*100)+0
					Rast3 = int(RND*1000)+0
					Rast4 = int(RND*10000)+0
					Rast5 = int(RND*100000)+0
					Rast6 = int(RND*1000000)+0
					RAST = Rast1 & "_" & Rast2 & "_" & Rast3 & "_" & Rast4 & "_" & Rast5 & "_" & Rast6
					
					f.saveas uploadsDirVar & "DegerlerEgitimi_" & RAST & f.ext
					iname = "DegerlerEgitimi_" & RAST & f.ext
				END IF
		end if

				YeniPg.AddNew
				YeniPg("teachersID")=user("userID")
				YeniPg("Photo")=iname
				YeniPg("Page")=upload.Form("PageOne")
				YeniPg("bookID")=upload.Form("bookID")
				YeniPg.Update

			%>
			<script type="text/javascript">
			alert("Başarıyla eklendi.");
			location.href="pages.asp?BookID=<%=bookID%>";
			</script>
			<%
	else
	%>
    <script type="text/javascript">
	alert("Lütfen sayfa içeriğini doldurun.");
	location.href="pageAdd.asp?BookID=<%=bookID%>";
    </script>
    <%
	end if	
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Sayfalar</title>
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
                      <td width="349" align="left" valign="middle">Yeni Sayfa > <%=bookInfo("BookName")%></td>
                      <td width="349" align="right" valign="middle"><a href="books.asp" class="backlink">Kitaplar</a>&nbsp;<a href="pages.asp?bookID=<%=bookInfo("BookID")%>" class="backlink">Sayfalar</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST" enctype="multipart/form-data" accept-charset="ISO-8859-9">
                      <input type="hidden" name="bookID" value="<%=bookID%>" />
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="100" height="30" align="right" valign="middle"><span style="font-size:14px;">Sayfa İ&ccedil;eriği:</span></td>
                          <td width="593" height="30" align="left" valign="middle"><textarea name="PageOne" class="formarea"></textarea></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Resim:</span></td>
                          <td height="30" align="left" valign="middle">&nbsp;<input type="file" name="upload" />&nbsp;
                          <span class="backlink">.jpg</span>&nbsp;<span class="backlink">.png</span>&nbsp;<span class="backlink">.gif</span>&nbsp;<span class="backlink">.jpeg</span></td>
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
<script>
		CKEDITOR.replace( 'PageOne', {
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
