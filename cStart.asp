<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="Assets/inc/conn.asp" -->
<!-- #include file="Assets/inc/system.asp" -->
<!-- #include file="Assets/inc/userControl.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Değerler Eğitimi</title>
<link href="Assets/css/cloud.css" rel="stylesheet" type="text/css" />
<link href="Assets/css/child_main.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	function Exit(){
		if(confirm("Çıkış yapmak istediğinizden emin misiniz ?")){
			location.href="?exit=ok";
		}
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
<div id="main"><img src="Assets/img/child_cont_bgTXT.png" width="762" height="1099" border="0" usemap="#Map" />
  <map name="Map" id="Map">
    <area shape="poly" coords="342,891" href="#" />
    <area shape="poly" coords="298,854" href="#" />
    <area shape="poly" coords="341,891,289,893,260,879,241,867,278,839,302,839,334,839" href="javascript:Exit();" />
    <area shape="poly" coords="357,804,447,803" href="#" />
    <area shape="poly" coords="354,804,452,803,469,785,433,760,357,769" href="cSett.asp" />
    <area shape="poly" coords="344,704,277,706,224,683,270,653,354,653" href="cGames.asp" />
    <area shape="poly" coords="386,578" href="#" />
    <area shape="poly" coords="385,578,475,575,494,557,462,535,387,546" href="cBooks.asp" />
  </map>
</div>
</body>
</html>
