<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>1 then response.Redirect("default.asp")%>
<%
set ask = server.createobject("adodb.recordset")
sql="Select * From de_Ask WHERE teachersID="&user("userID")&" order by askID DESC"
ask.open sql,conn,1,3


if request.QueryString("Delete")="ok" and request.querystring("askID")<>"" Then
set Sil = conn.execute("DELETE from de_Ask WHERE askID="& request.querystring("askID") &"")
%>
    <script language="javascript" type="text/javascript">
    alert("Başarıyla silindi.");
	location.href="ask.asp";
    </script>
<%end if%>
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
                      <td width="349" align="left" valign="middle">Sorular</td>
                      <td width="349" align="right" valign="middle"><a href="askAdd.asp" class="addlink">Yeni Soru</a></td>
                    </tr>
                  </table>
                </div>
                <div class="contentbox">
                
                	<table width="200" cellspacing="0" cellpadding="0" class="totaltablo">
                      <tr>
                        <td height="30" align="left" valign="middle" class="totaltitle" width="100">&nbsp;Soru</td>
                        <td height="30" align="center" valign="middle" width="100"><span style="font-size:14px;"><%=ask.RecordCount%></span></td>
                      </tr>
                    </table>

                    <div class="cleartwo"></div>
                    <%if not ask.eof or not ask.bof then%>
                      <table width="696" border="0" cellspacing="1" cellpadding="0" class="geneltablo">
                        <tr class="tabletitle">
                          <td width="247" height="30" align="center" valign="middle">Kitap Adı</td>
                          <td width="324" height="30" align="center" valign="middle">Soru</td>
                          <td width="120" height="30" align="center" valign="middle">İşlemler</td>
                        </tr>
                        <%
						function sayfalama(sayfa,sf,nm)
						
						if sayfa > 6 and sf > 6 then Response.Write "<a class=""syf_Link"" href=?"&nm&"=1 >|<</a><a class=""syf_Link"" href=?"&nm&"="&sf-1&"><<</a>" 
						for g = sf-9 to sf+9
						if g = cint(sf) then
						response.write "<span class=""syf_Suan"" >&nbsp;"&g&"&nbsp;</span> " 
							  
						elseif g < 1 or g > sayfa then response.Write "" 
						else
						response.Write "<a class=""syf_Link"" href=?"&nm&"=" & g & ">" & g & "</a> "
						
						end if
						next
						if not g > sayfa and sayfa > 6 then response.Write "<a class=""syf_Link"" href=?"&nm&"="&sf+1&" >&nbsp;>>&nbsp;</a><a class=""syf_Link"" href=?"&nm&"="&sayfa&" >&nbsp;>|&nbsp;</a>" end if
						end function
													  
						if isnumeric(Request.QueryString("syf")) then
							syf = Request.QueryString("syf")
						else
							syf = 1
						end if
						If syf="" Then syf="1"
						ask.pagesize = 30
						ask.absolutepage = syf 
						sayfa_sayisi = ask.pagecount
						
						bg=0
						
						for a=1 to ask.pagesize
						if ask.eof then exit for
						sql="Select * From de_Book WHERE bookID="&ask("bookID")&""
						Set bookInfo = conn.Execute(sql)
						%>
                        <tr <%if bg mod 2=0 then%>bgcolor="#DFF4FF"<%else%>bgcolor="#CAEDFF"<%end if%> class="tablerow">
                          <td height="30" align="left" valign="middle">&nbsp;&nbsp;<%=bookInfo("bookName")%></td>
                          <td height="30" align="left" valign="middle" style="padding:5px;"><%=ask("Question")%></td>
                          <td height="30" align="center" valign="middle"><a href="askUpdate.asp?askID=<%=ask("askID")%>" class="updatelink">Düzenle</a>&nbsp;<a href="?Delete=ok&askID=<%=ask("askID")%>" class="deletelink">Sil</a></td>
                        </tr>
                        <%
						bg=bg+1
						ask.movenext : next
						%>
                      </table>
                      <%if sayfa_sayisi>1 then%>
                      <table width="696" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                          <td height="10" align="center" valign="middle"></td>
                        </tr>
                        <tr>
                          <td width="696" align="center" valign="middle"><%call sayfalama(sayfa_sayisi,syf,"syf")%></td>
                        </tr>
                      </table>
                      <%end if%>
                      <%end if%>
					  <%ask.close%>  
                </div>
            </div>

            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
