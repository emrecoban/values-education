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
	
if isnumeric(Temizleyici(request.QueryString("PageID")))=false then
response.redirect "start.asp"
response.End
end if

if request.QueryString("PageID")<>"" and isnumeric(request.QueryString("PageID")) then
PageID = request.QueryString("PageID")
else
%>
        <script language="javascript" type="text/javascript">
        alert("Hatalı giriş. Lütfen bilgilerin doğruluğundan emin olun.");
		location.href="start.asp";
        </script>
<%
end if

sql="Select * From de_Page WHERE PageID="&PageID&""
Set pages = conn.Execute(sql)

bookID = request.QueryString("bookID")
sql="Select * From de_Book WHERE bookID="&bookID&""
Set bookInfo = conn.Execute(sql)

if pages.eof then
response.redirect "start.asp"
response.End()
end if

set PageUpd = server.createobject("adodb.recordset")
sql="Select * From de_Page WHERE PageID=" & PageID
PageUpd.open sql,conn,1,3

if request.ServerVariables("REQUEST_METHOD")="POST" then

Set Upload = Server.CreateObject("Persits.Upload")
Count = upload.save
dim uploadsDirVar
uploadsDirVar = server.MapPath("Page_img") & "/"

	if Upload.Form("PageOne")<>"" then
	
		iname=""	
		if count <>  0 then
			set f = upload.files("upload")
				if f.ext<>".jpg" and f.ext<>".png" and f.ext<>".gif" and f.ext<>".jpeg" and f.ext<>".JPG" then
				%>
                <script language="javascript" type="text/javascript">
				alert("Istenmeyen dosya turu hatasi.\nDosya yukleme basarisiz.");
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
		
		if iname<>"" then
		PageUpd("Photo")=iname
		end if
		PageUpd("Page")=upload.Form("PageOne")
		PageUpd.Update
		%>
        <script type="text/javascript">
		alert("Basariyla guncellendi.");
		location.href="pages.asp?bookID=<%=bookID%>";
		</script>
        <%
	else
	%>
    <script type="text/javascript">
	alert("Lutfen sayfa icerigini doldurun.");
	location.href="pageUpdate.asp?pageID=<%=PageID%>&bookID=<%=bookID%>";
    </script>
    <%
	end if	
end if

if request("Delete") <> "" then
	if PageUpd("Photo") <> "" then
		set f = server.CreateObject("Scripting.FileSystemObject")
		f.deletefile Server.MapPath("Page_img/"&PageUpd("Photo"))
		PageUpd("Photo") = ""
		PageUpd.update
	end if
response.Redirect "?pageID="&request.QueryString("pageID")&"&bookID="&request.QueryString("bookID")
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
                      <td width="349" align="left" valign="middle">Sayfa Düzenle > <%=bookInfo("BookName")%></td>
                      <td width="349" align="right" valign="middle"><a href="books.asp" class="backlink">Kitaplar</a>&nbsp;<a href="pages.asp?bookID=<%=request.QueryString("bookID")%>" class="backlink">Sayfalar</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST" enctype="multipart/form-data" accept-charset="ISO-8859-9">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="100" height="30" align="right" valign="middle"><span style="font-size:14px;">Sayfa İçeriği:</span></td>
                          <td width="593" height="30" align="left" valign="middle"><textarea name="PageOne" class="formarea"><%=pages("Page")%></textarea></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Resim:</span></td>
                          <td height="30" align="left" valign="middle">
                          <%if pages("Photo")<>"" then%>
                          <br />
                          &nbsp;<img src="Page_img/<%=pages("Photo")%>" width="110" height="110" border="0" />
                          &nbsp;<a href="?pageID=<%=pageID%>&bookID=<%=bookID%>&Delete=ok" class="deletelink">Sil</a>
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
