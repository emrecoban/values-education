<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi</title>
<link href="Assets/css/main.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="main">
	<!-- #include file="Assets/inc/sidebar.asp" -->
    <div id="panel">
    	<!-- #include file="Assets/inc/userbar.asp" -->
        <div id="maincontent">
        <%
		sql="Select * From de_Settings WHERE settID=1"
		Set sett = conn.Execute(sql)
		if user("Yetki")=1 and sett("Bilgi")<>"" then%>
        <!-- //ContentBox1 -->
            <div class="contentpanel">
                <div class="contenttitle">Bilgi Ekranı</div>
                <div class="contentbox">
                	<%=sett("Bilgi")%>
                </div>
            </div>
         
        <%end if
		if sett("NedirTT")<>"" and sett("Nedir")<>"" then
		%>   
        <!-- //ContentBox2 -->
            <div class="contentpanel">
                <div class="contenttitle"><%=sett("NedirTT")%></div>
                <div class="contentbox"><%=sett("Nedir")%></div>
            </div>
		<%end if%>
            
         
        </div>
    </div>
    <div id="clear"></div>
    <!-- #include file="Assets/inc/footer.asp" -->
</div>
</body>
</html>
