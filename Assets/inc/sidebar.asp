   <div id="sidebar">
    	<div id="logo"><img src="Assets/img/logo2.png" width="228" height="150" border="0" /></div>
      <div id="sidebarbg">
      <!-- // MenuBox1 -->
        	<div class="menupanel">
            	<div class="menuicon"><img src="Assets/img/ico1.png" width="30" height="30" border="0" /></div>
                <div class="menutitle">İŞLEMLER</div>
            </div>
            <div class="menubox">
              <ul class="menu">
                <li><a href="start.asp">Başlangıç</a></li>
              <%if user("Yetki")=0 Then%>
                <li><a href="teachers.asp">Öğretmenler</a></li>
              <%else%>
              	<li><a href="students.asp">Öğrenciler</a></li>
                <li><a href="books.asp">Kitaplar</a></li>
                <li><a href="ask.asp">Sorular</a></li>
                <li><a href="games.asp">Oyunlar</a></li>
              <%end if%>
              </ul>
          </div>
        
     <!-- // MenuBox2 -->
        	<div class="menupanel">
            	<div class="menuicon"><img src="Assets/img/ico2.png" width="31" height="30" border="0" /></div>
                <div class="menutitle">AYARLAR</div>
            </div>
            <div class="menubox">
              <ul class="menu">
                <li><a href="profile.asp">Kullanıcı Bilgilerim</a></li>
                <%if user("Yetki")=1 Then%>
                <li><a href="logger.asp">Hesap Geçmişim</a></li>
                <%end if%>
                <%if user("Yetki")=0 Then%>
                <li><a href="logger.asp">Hesap Geçmişleri</a></li>
                <li><a href="settings.asp">Genel Ayarlar</a></li>
                <%end if%>
              </ul>
          </div>

          
          

          
          
     </div> 
    </div>