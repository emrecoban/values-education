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
	
if isnumeric(Temizleyici(request.QueryString("bookID")))=false then
response.redirect "cStart.asp"
response.End
end if

if request.QueryString("bookID")<>"" and isnumeric(request.QueryString("bookID")) then
bookID = request.QueryString("bookID")
else
%>
        <script language="javascript" type="text/javascript">
        alert("Hatalı giriş. Lütfen bilgilerin doğruluğundan emin olun.");
		location.href="cStart.asp";
        </script>
<%
end if

set books = server.createobject("adodb.recordset")
sql="Select * From de_Book WHERE teachersID="&user("teachersID")&" and bookID="&bookID&""
books.open sql,conn,1,3

set pages = server.createobject("adodb.recordset")
sql="Select * From de_Page WHERE teachersID="&user("teachersID")&" and bookID="&bookID&" order by pageID ASC"
pages.open sql,conn,1,3

if request.ServerVariables("REQUEST_METHOD")="POST" then

'Puan Hesapla
set ask = server.createobject("adodb.recordset")
sql="Select * From de_Ask WHERE teachersID="&user("teachersID")&" and bookID="&bookID&" order by askID ASC"
ask.open sql,conn,1,3

Points=0
do while not ask.eof
if ask("TrueReply") = "A" then cevap = ask("ReplyA")
if ask("TrueReply") = "B" then cevap = ask("ReplyB")
if ask("TrueReply") = "C" then cevap = ask("ReplyC")
if request.form("Question" & ask("askID")) = cevap then
	Points=Points+5
end if
ask.movenext : loop
'Puan Hesapla

set student = server.createobject("adodb.recordset")
sql="Select * From de_User WHERE userID="&user("userID")&""
student.open sql,conn,1,3

student("puan")=student("puan")+Points
student.update
%>
	<script type="text/javascript">
	alert("Tebrikler!\nProfiline <%=Points%> puan daha eklendi.");
	location.href="cBooks.asp";
    </script>
<%end if%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>Değerler Eğitimi - <%=books("BookName")%></title>
<link href="Assets/css/cloud.css" rel="stylesheet" type="text/css" />
<link href="Assets/css/child_main.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="Assets/css/default.css" />
<link rel="stylesheet" type="text/css" href="Assets/css/bookblock.css" />
<link rel="stylesheet" type="text/css" href="Assets/css/bookblock1.css" />

<script src="Assets/js/modernizr.custom.js"></script>
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
    	<div id="contcenter" style="height:125px !important;">
        	<div id="title">
            	<div id="titleico"><img src="Assets/img/child_icon_1.png" width="40" height="40" border="0" /></div>
                <div id="titletxt"><%=books("BookName")%></div>
            </div>
        </div>
     
    
    <div class="container fontstyle">
			<div class="bb-custom-wrapper">
				<form action="" method="post">
				<div id="bb-bookblock" class="bb-bookblock">
					<div class="bb-item">
						<div class="bb-custom-firstpage">
							<h1><%=books("BookName")%></h1>	
							<p></p>
						</div>
						<div class="bb-custom-side">
							<p>Diğer sayfalara geçebilmek için aşağıda yer alan yön butonlarını veya klavyenin sağ-sol tuşlarını kullanabilirsin. <br /><br />Bu kitaba ait soruları cevaplandırıp puan kazanabilmen için son sayfada olman gerekir.</p>
						</div>
					</div>
                    <%
					say=0
						do while not pages.eof
							if say mod 2=0 then response.write "<div class='bb-item'>"
							%>
								<div class="bb-custom-side">
									<p>
									<%if pages("Photo")<>"" then%>
                                    	<img src="Page_img/<%=pages("Photo")%>" width="100%" style="max-height:300px;max-width:100%;" border="0" />
                                    <%end if%>
									<%=pages("Page")%></p>
								</div>
							<%
							say=say+1
							if say mod 2=0 then response.write "</div>"
						pages.movenext : loop
					%>
                    <%
					set ask = server.createobject("adodb.recordset")
					sql="Select * From de_Ask WHERE teachersID="&user("teachersID")&" and bookID="&bookID&" order by askID ASC"
					ask.open sql,conn,1,3
					
					if not ask.eof or not ask.bof then
					%>  
                    
                    <div class='bb-item'>
                    	<div class="bb-custom-side">
							<p></p>
                        </div>
                        <div class="bb-custom-side">
							<p><img src="Assets/img/ques.png" width="300" height="300" border="0" /></p>
                        </div>
                    </div>
                    
                    <%
					vay=0
						do while not ask.eof
							if vay mod 2=0 then response.write "<div class='bb-item'>"
							%>
								<div class="bb-custom-side">
									<p>
										<%=ask("Question")%><br />
                                        
                                        <input name="Question<%=ask("askID")%>" id="replyA<%=ask("askID")%>" type="radio" value="<%=ask("replyA")%>" /><label for="replyA<%=ask("askID")%>"><%=ask("replyA")%></label><br />
                                        <input name="Question<%=ask("askID")%>" id="replyB<%=ask("askID")%>" type="radio" value="<%=ask("replyB")%>" /><label for="replyB<%=ask("askID")%>"><%=ask("replyB")%></label><br />
                                        <input name="Question<%=ask("askID")%>" id="replyC<%=ask("askID")%>" type="radio" value="<%=ask("replyC")%>" /><label for="replyC<%=ask("askID")%>"><%=ask("replyC")%></label>
                                    
                                    </p>
								</div>
							<%
							vay=vay+1
							if vay mod 2=0 then response.write "</div>"
						ask.movenext : loop
					%>
                    </div>
                    <div class='bb-item'>
                    	<div class="bb-custom-side">
							<p><input type="submit" id="quessub" value="" /></p>
                        </div>
                        <div class="bb-custom-side">
							<p><img src="Assets/img/ques_2.png" width="300" height="300" border="0" /></p>
                        </div>
                    </div>
                    
					<%end if%>
				
                </form>
                

				<nav>
					<a id="bb-nav-first" href="#" class="bb-custom-icon bb-custom-icon-first">İlk Sayfa</a>
					<a id="bb-nav-prev" href="#" class="bb-custom-icon bb-custom-icon-arrow-left">Önce</a>
					<a id="bb-nav-next" href="#" class="bb-custom-icon bb-custom-icon-arrow-right">Sonra</a>
					<a id="bb-nav-last" href="#" class="bb-custom-icon bb-custom-icon-last">Son Sayfa</a>
				</nav>

			</div>

		</div><!-- /container -->
    <script src="Assets/js/jquery.min.js"></script>
	<script src="Assets/js/jquerypp.custom.js"></script>
	<script src="Assets/js/jquery.bookblock.js"></script>
    <script>
			var Page = (function() {
				
				var config = {
						$bookBlock : $( '#bb-bookblock' ),
						$navNext : $( '#bb-nav-next' ),
						$navPrev : $( '#bb-nav-prev' ),
						$navFirst : $( '#bb-nav-first' ),
						$navLast : $( '#bb-nav-last' )
					},
					init = function() {
						config.$bookBlock.bookblock( {
							speed : 1000,
							shadowSides : 0.8,
							shadowFlip : 0.4
						} );
						initEvents();
					},
					initEvents = function() {
						
						var $slides = config.$bookBlock.children();

						// add navigation events
						config.$navNext.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'next' );
							return false;
						} );

						config.$navPrev.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'prev' );
							return false;
						} );

						config.$navFirst.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'first' );
							return false;
						} );

						config.$navLast.on( 'click touchstart', function() {
							config.$bookBlock.bookblock( 'last' );
							return false;
						} );
						
						// add swipe events
						$slides.on( {
							'swipeleft' : function( event ) {
								config.$bookBlock.bookblock( 'next' );
								return false;
							},
							'swiperight' : function( event ) {
								config.$bookBlock.bookblock( 'prev' );
								return false;
							}
						} );

						// add keyboard events
						$( document ).keydown( function(e) {
							var keyCode = e.keyCode || e.which,
								arrow = {
									left : 37,
									up : 38,
									right : 39,
									down : 40
								};

							switch (keyCode) {
								case arrow.left:
									config.$bookBlock.bookblock( 'prev' );
									break;
								case arrow.right:
									config.$bookBlock.bookblock( 'next' );
									break;
							}
						} );
					};

					return { init : init };

			})();
		</script>
		<script>
				Page.init();
		</script>
        
  </div>  
</div>
<!-- #include file="Assets/inc/child_footer.asp" -->
</body>
</html>
