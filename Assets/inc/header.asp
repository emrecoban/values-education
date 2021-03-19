	<script language="javascript">
	function Exit(){
		if(confirm("Çıkış yapmak istediğinizden emin misiniz ?")){
			location.href="?exit=ok";
		}
	}
	</script>
    <div id="head">
    	<div id="logo"><span class="logotxt">DEĞERLER</span><span class="logotxt" style="color:#C3DC78;">EĞİTİMİ</span></div>
        <div id="exit"><a href="javascript:Exit();" class="exitlink">ÇIKIŞ</a></div>
    </div>
    <div id="menuTab">
    	<div class="boxMenu" style="width:189px;"><a href="cStart.asp" title="Ana Sayfa"><img src="Assets/img/box_AnaSayfa.png" width="189" height="190" border="0" /></a></div>
        <div class="boxMenu" style="width:150px;"><a href="cBooks.asp" title="Kitaplık"><img src="Assets/img/box_Kitaplik.png" width="150" height="190" border="0" /></a></div>
        <div class="boxMenu" style="width:150px;"><a href="cGames.asp" title="Oyunlar"><img src="Assets/img/box_Oyunlar.png" width="150" height="190" border="0" /></a></div>
        <div class="boxMenu" style="width:150px;"><a href="cSett.asp" title="Ayarlar"><img src="Assets/img/box_Ayarlar.png" width="150" height="190" border="0" /></a></div>
        <div class="boxMenu" style="width:283px;background-color:#EF7B7E;"><img src="Assets/img/box_Puan.png" width="120" height="190" border="0" style="float:left;" /><span class="points"><%=user("puan")%> PUAN</span></div>
    </div>