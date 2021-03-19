<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<%if user("Yetki")<>2 then response.Redirect("default.asp")%>
<%
	Function Temizleyici(TMZ)
		TMZ = replace(TMZ, ",", "'")
	Temizleyici = TMZ
	End Function
	
if isnumeric(Temizleyici(request.QueryString("gameID")))=false then
response.redirect "cStart.asp"
response.End
end if

if request.QueryString("gameID")<>"" and isnumeric(request.QueryString("gameID")) then
gameID = request.QueryString("gameID")
else
%>
        <script language="javascript" type="text/javascript">
        alert("Hatalı giriş. Lütfen bilgilerin doğruluğundan emin olun.");
		location.href="cStart.asp";
        </script>
<%
end if

set games = server.createobject("adodb.recordset")
sql="Select * From de_Game WHERE teachersID="&user("teachersID")&" and Puan<="&user("puan")&" and  gameID="&gameID&""
games.open sql,conn,1,3
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi - <%=games("gameName")%></title>
<link href="Assets/css/cloud.css" rel="stylesheet" type="text/css" />
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
            	<div id="titleico"><img src="Assets/img/child_icon_2.png" width="40" height="40" border="0" /></div>
                <div id="titletxt"><%=games("gameName")%></div>
            </div>
            <div id="maincont">
            	<div id="gameSWF">
                			<object width="640" height="430">
                                <param name="movie" value="Game_swf_img/<%=games("gameFile")%>">
                                <embed src="Game_swf_img/<%=games("gameFile")%>" width="640" height="430">
                                </embed>
                            </object>
                </div>
                <div id="gameCont">
                		<%if games("gamePhoto")<>"" then%>
                    		<img src="Game_swf_img/<%=games("gamePhoto")%>" width="190" height="190" border="0" style="margin-top:10px;" />
                        <%else%>
                        	<img src="Assets/img/no-image.png" width="190" height="190" border="0" style="margin-top:10px;" />
                        <%end if%>
                        <br />
                        <b><%=games("gameName")%></b>
                        <br />
                        Bu oyunu sadece <%=games("Puan")%> ve üzeri puana sahip olanlar oynayabilir. Daha fazla kitap okuyarak, farklı oyunlar oynama şansını yakala!
                </div>
            </div>
        </div>
    </div>  
</div>
<!-- #include file="Assets/inc/child_footer.asp" -->
</body>
</html>
