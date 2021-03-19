<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>2 then response.Redirect("default.asp")%>
<%
set books = server.createobject("adodb.recordset")
sql="Select * From de_Book WHERE teachersID="&user("teachersID")&" order by bookID DESC"
books.open sql,conn,1,3
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - Kitaplar</title>
<link href="Assets/css/cloud.css" rel="stylesheet" type="text/css" />
<link href="Assets/css/child_shelf.css" rel="stylesheet" type="text/css" />
<link href="Assets/css/child_main.css" rel="stylesheet" type="text/css" />
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
            	<div id="titleico"><img src="Assets/img/child_icon_1.png" width="40" height="40" border="0" /></div>
                <div id="titletxt">KİTAPLIK</div>
            </div>
            <div id="maincont">
            <%if not books.eof or not books.bof then%>
            <!-- raflar -->
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
						books.pagesize = 12
						books.absolutepage = syf 
						sayfa_sayisi = books.pagecount
						
						bg=1
						function kitaprenk(say)
							dim renk
							renk=""
							if say=1 then
								renk = "#EF7B7E"
							elseif say=2 then
								renk = "#F6C44B"
							elseif say=3 then
								renk = "#AEC251"
							elseif say=4 then
								renk = "#FCE281"
							elseif say=5 then
								renk = "#4EBCD3"
							elseif say=6 then
								renk = "#4D729E"
							elseif say=7 then
								renk = "#B1B6FA"
							elseif say=8 then
								renk = "#DF73AD"
							elseif say=9 then
								renk = "#FBCBE1"
							elseif say=10 then
								renk = "#FF622B"
							elseif say=11 then
								renk = "#D93600"
							elseif say=12 then
								renk = "#66CCFF"
							end if
							response.write renk
						end function
						%>
               <div class="shelf">
						<%	
						Dim kitap
						for a=1 to books.pagesize
						if books.eof then exit for
						if Len(books("BookName"))>22 then
							kitap = left(books("BookName"),22) & "..."
						else
							kitap = books("BookName")
						end if
						%>
                
            	
                
					<a href="cReader.asp?BookID=<%=books("bookID")%>"><div class="book" data-tooltip="<%=kitap%>" style="background-color:<%=kitaprenk(bg)%>;"></div></a>
					<%if bg=6 then%>
                    <div class="bookend_left"></div>
                    <div class="bookend_right"></div>
                    <div class="reflection"></div>
                	</div>
                    <div class="shelf">
                    <%end if%>
                
                   
                		<%
						bg=bg+1
						books.movenext : next
						%>
 					<div class="bookend_left"></div>
                    <div class="bookend_right"></div>
                    <div class="reflection"></div>
                	</div>
                <%if sayfa_sayisi>1 then%>
                <br /><br />
				<center><%call sayfalama(sayfa_sayisi,syf,"syf")%></center>
                <%end if%>
				<%end if%>
				<%books.close%> 
                
                
            </div>
        </div>
    </div>  
</div>
<!-- #include file="Assets/inc/child_footer.asp" -->
</body>
</html>
