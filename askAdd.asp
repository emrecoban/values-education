<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>1 then response.Redirect("default.asp")%>
<%
if request.ServerVariables("REQUEST_METHOD")="POST" then
	if request.Form("Question")<>"" and request.Form("ReplyA")<>"" and request.Form("ReplyB")<>"" and request.Form("ReplyC")<>""  then
	
			set YeniQ = server.createobject("adodb.recordset")
			sql="Select * From de_Ask"
			YeniQ.open sql,conn,1,3
			
			YeniQ.AddNew
			YeniQ("teachersID")=user("userID")
			YeniQ("bookID")=request.Form("bookID")
			YeniQ("Question")=request.Form("Question")
			YeniQ("ReplyA")=request.Form("ReplyA")
			YeniQ("ReplyB")=request.Form("ReplyB")
			YeniQ("ReplyC")=request.Form("ReplyC")
			YeniQ("TrueReply")=request.Form("TrueReply")
			YeniQ.Update
			%>
			<script type="text/javascript">
			alert("Başarıyla eklendi.");
			location.href="ask.asp";
			</script>
			<%

	else
	%>
    <script type="text/javascript">
	alert("Lütfen tüm alanları doldurun.");
	location.href="askAdd.asp";
    </script>
    <%
	end if	
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Sorular</title>
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
                      <td width="349" align="left" valign="middle">Yeni Soru</td>
                      <td width="349" align="right" valign="middle"><a href="ask.asp" class="backlink">Sorular</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                      <form action="" method="POST">
                      <table width="696" border="0" cellspacing="1" cellpadding="0">
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Kitap:</span></td>
                          <td width="493" height="30" align="left" valign="middle">
                          <select name="bookID" class="formtext">
                          <%
						  sql="Select * From de_Book WHERE teachersID="&user("userID")&" Order By bookID DESC"
						  Set bookList = conn.Execute(sql)
						  do while not bookList.eof
						  %>
                          <option value="<%=bookList("bookID")%>"><%=bookList("bookName")%></option>
                          <%bookList.movenext : loop
						  bookList.Close%>
						  </select>
                          </td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Soru:</span></td>
                          <td height="30" align="left" valign="middle"><input type="text" name="Question" class="formtext" style="width:400px;" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Cevap A:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="ReplyA" class="formtext" style="width:400px;" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Cevap B:</span></td>
                          <td height="30" align="left" valign="middle"><input type="text" name="ReplyB" class="formtext" style="width:400px;" /></td>
                        </tr>
                        <tr bgcolor="#DFF4FF">
                          <td width="200" height="30" align="right" valign="middle"><span style="font-size:14px;">Cevap C:</span></td>
                          <td width="493" height="30" align="left" valign="middle"><input type="text" name="ReplyC" class="formtext" style="width:400px;" /></td>
                        </tr>
                        <tr bgcolor="#CAEDFF">
                          <td height="30" align="right" valign="middle"><span style="font-size:14px;">Doğru Yanıt:</span></td>
                          <td height="30" align="left" valign="middle">
                          <select name="TrueReply" class="formtext">
                          <option value="A">A</option>
                          <option value="B">B</option>
                          <option value="C">C</option>
						  </select>
                          </td>
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
